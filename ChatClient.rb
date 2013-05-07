require 'socket'

class ChatClient
  def initialize (hostname,port)
    @s = TCPSocket.new hostname, port
  end

  def get


end