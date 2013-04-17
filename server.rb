#!/usr/bin/env ruby
require 'socket'

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

server = TCPServer.new(ARGV[0].to_i)
puts "Server IP: #{local_ip('www.google.com')}:#{ARGV[0]}"
loop {
	# client = server.accept
	# client.puts(Time.now.ctime)
	# client.puts "Closing the connection. Bye!"
	# client.close
	Thread


}