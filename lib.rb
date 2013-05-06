require 'resolv'
require 'gserver'

class Client
  attr_accessor :client_name

  def initialize(client_name)
    @client_name = client_name
  end


end

class Room
  def initialize(room_name)

  end


end

class ChatServer < GServer
  def initialize(*args)
    super(*args)
    @@client_id = 0
    @@chat = []
  end





  def serve(io)
    io.puts("To stop this server, type 'shutdown'\n")
    self.stop if io.gets =~ /shutdown/
  end
end

server = ChatServer.new(6000,'192.168.1.137')
server.start
loop do
  break if server.stopped?
end
