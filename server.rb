#!/usr/bin/env ruby
require 'socket'

def local_ip(target) 
  # turn off reverse DNS resolution 
  bdns, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true 

  UDPSocket.open do |s| 
  s.connect target, 8000 
  s.addr.last 
  end 
  ensure 
  # restore DNS resolution 
  Socket.do_not_reverse_lookup = bdns 
end 

if ARGV.count != 1
  abort("Error: Wrong number of argument.")
end

user = Hash.new

puts "Starting server..."
server = TCPServer.new(ARGV[0].to_i)
puts "Server IP: #{local_ip('www.google.com')}:#{ARGV[0]}"

loop {
  # client = server.accept
  # client.puts(Time.now.ctime)
  # client.puts "Closing the client. Bye!"
  # client.close
  Thread.start(server.accept) do |client|
    puts "Incoming: #{client.peeraddr[2]}:#{client.peeraddr[1]}"
    while line = client.gets
      puts line
      case line.split(' ')[0]
      when '#HELLO'
        client.puts "Welcome #{line.split(' ')[1]}"
        client.puts(Time.now.ctime)
        user[line.split(' ')[1]] = client

      when '#BYE'
        client.close
        break
      else
        puts "Unknown command."
      end





    end
  end
}
