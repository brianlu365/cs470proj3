require 'socket'

MAX_PEOPLE = 50



server = TCPServer.new 4000

loop do 
  Thread.start (server.accept) do 

  end


  
end