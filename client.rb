require './ChatClient.rb'

s = CharClient.new "localhost" 7000 "brian"
s.send s.name
