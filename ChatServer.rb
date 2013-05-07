require 'gserver'


class Client
  attr_reader :io, :name

  def initialize (args = {})
    @io = args[:io]
    @name = args[:name]
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
 
    #Mutex for safety - GServer uses threads
    @mutex.synchronize do
      @chatters.each do |chatter|
        begin
          chatter.print message unless chatter == sender
        rescue
          @chatters.delete chatter
        end
      end
    end
  end
 
  #Handle each connection
  def serve io
    # io.print 'Name: '
    name = io.gets
    name.strip!
    io.print '#ERROR:name is nil' if name.nil? #error msg if name is null

    c = Client.new(:name => "#{name}",:io => io)

    #msg everybody 
    broadcast "--+ #{name} has joined +--"
 
    #Add to our list of connections
    @mutex.synchronize do
      @chatters[] << io
    end
 
    #Get and broadcast input until connection returns nil
    loop do
      message = io.gets
 
      if message
        broadcast "#{name}> #{message}", io
      else
        break
      end
    end
 
    broadcast "--+ #{name} has left +--"
  end
end