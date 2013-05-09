require 'gserver'


class Client
  attr_reader :io, :name

  def initialize (args = {})
    @io = args[:io]
    @name = args[:name]
  end

  def gets message, sys = nil
    message = message.strip << "\r\n"
    # message = sys ?  "#{@name} said: " + message + "\r\n" : message + "\r\n" 
    # p @io
    begin
      @io.print message + "\r\n"
    # rescue
    #   puts "not get."
    end
  end


  def talkTo other, message
    message = message.strip << "\r\n"
    message = "#{@name} whispered: " + message
    begin  
      other.io.print message
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
  attr_accessor :chatters
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
          chatter.gets message unless name == sender.name
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
        receiver.talkTo receiver, message
      rescue
        sender.gets '#ERROR:Msg failed!' + "\r\n"
      end
    end
  end


  #Handle each connection
  def serve io
    io.print "#NAME\r\n"
    name = io.gets
    name.strip!
    io.print '#ERROR:name is nil.' if name.nil? #error msg if name is null

    c = Client.new(:name => "#{name}",:io => io)
    p c.name
    #msg everybody 
 
    #Add to our list of connections
    p @chatters
    @mutex.synchronize do
      @chatters[name] = c
    end
    p @chatters
    broadcast "--+ #{name} has joined +--", c
    

    #Get and broadcast input until connection returns nil
    loop do
      message = io.gets
      msg_ary = message.split(":")
      case msg_ary[0] 
      when '#WISP'
        whisper c, @chatters[msg_ary[1]], msg_ary[2..-1].join
      when '#BOARD' 
        p "okay"
        p msg_ary[1..-1].join
        broadcast msg_ary[1..-1].join, c
      else
        break
      end
    end
 
    broadcast "--+ #{name} has left +--"
  end
end