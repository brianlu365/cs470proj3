#!/usr/bin/env ruby
require './lib'

server = Server.new(5000)
server.start

loop do 
  break if server.stopped?
end

puts "Server has been terminated"
