require 'socket'

class ChatClient
  attr_reader :s,:name
  attr_accessor :history, :friends
  def initialize (hostname,port,name)
    @s = TCPSocket.new hostname, port
    p "ok"
    @name = name
    @history = []
    @friends = []
  end
  def sendName name
    @s.puts name
  end
  def send message
    ary = message.split(" ")
    case ary[0][0]
    when "@"
      ary[0] = "#WISP:#{ary[0][1..-1]}:"
      message = ary.join(" ")
    else
      message = "#BROAD:" + message
    end
    @s.puts message
  end

  def gets
    return @s.gets
  end

  def addFriend name
    @friends << name
  end

  def rmFriend name
    @friends.delete name
  end

  def disconnect
    @s.close
  end
end