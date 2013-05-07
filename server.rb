#!/usr/bin/env ruby
require './lib'

ChatServer.new(7000, '0.0.0.0', 100, $stderr, true).start.join