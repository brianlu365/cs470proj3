require 'gserver'


class Client
  attr_reader :io, :name

  def initialize (args = {})
    @io = args[:io]
    @name = args[:name]
  end


  #get msg from who. If who is not specified then it is a system msg
  def gets message, who = nil
    message = message.strip << "\r\n"
    message = who.nil? ?  message : "#{who}: " + message

    # p @io
    begin
      @io.print message + "\r\n"
    # rescue
    #   puts "not get."
    end
  end

  #a talk to b message
  def talkTo other, message
    message = message.strip << "\r\n"
    message = "#{@name} whispered: " + message
    begin  
      other.io.print message + "\r\n"
    rescue
      this.io.print '#ERROR:Msg failed!' + "\r\n"
    end
  end

  def addUser other
    this.print "#ADDUSER:#{other.name}" + "\r\n"
  end

  def rmUser other
    this.print "#RMUSER:#{other.name}" + "\r\n"
  end


end


class ChatServer < GServer
  def initialize *args
    super
    #hash of clients, key as name, value as client
    @chatters = {}

    #thread safety
    @mutex = Mutex.new 
  end


  #Send message out to everyone but sender
  def broadcast message, sender = nil
    #Need to use \r\n for our Windows friends
    message = message.strip << "\r\n"
    p message
    #Mutex for safety - GServer uses threads
    @mutex.synchronize do
      @chatters.each do |name,chatter|
        begin
          if sender
            chatter.gets message,sender.name #unless name == sender.name
          else
            chatter.gets message
          end
        rescue
          @chatters.delete name
        end
      end
    end
  end
 
  def whisper sender, receiver, message
    message = message.strip << "\r\n"

    @mutex.synchronize do
      begin
        sender.talkTo receiver, message
      rescue
        sender.gets '#ERROR:Msg failed!' + "\r\n"
      end
    end
  end


  #Handle each connection
  def serve io
    # io.print "#NAME\r\n"
    name = io.gets
    name.strip!
    io.print '#ERROR:name is nil.' if name.nil? #error msg if name is null

    c = Client.new(:name => "#{name}",:io => io)
    p c.name
    #msg everybody 
 
    #Add to our list of connections
    p @chatters
    c.io.print  "#FRIEND:#{@chatters.keys.join(",")}\r\n"
    @mutex.synchronize do
      @chatters[name] = c
    end
    p @chatters
    broadcast "#JOINED:#{name}"
    

    #Get and broadcast input until connection returns nil
    loop do
      message = io.gets
      msg_ary = message.split(":")
      case msg_ary[0] 
      when '#WISP'
        whisper c, @chatters[msg_ary[1]], msg_ary[2..-1].join
      when '#BROAD' 
        # p "okay"
        p msg_ary[1..-1].join
        broadcast msg_ary[1..-1].join, c
      else
        break
      end
    end
 
    broadcast "#LEFT:#{name}"
    @mutex.synchronize do
      @chatters.delete name
    end
  end
end