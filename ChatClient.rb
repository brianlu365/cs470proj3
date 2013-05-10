require 'socket'

class ChatClient
  attr_reader :s,:name
  def initialize (hostname,port,name)
    @s = TCPSocket.new hostname, port
    @name = name
  end

  # def get


end