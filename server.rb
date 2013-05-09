#!/usr/bin/env ruby
require './ChatServer'

ChatServer.new(7000, '0.0.0.0', 100, $stderr, true).start.join