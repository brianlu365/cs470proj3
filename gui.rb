require 'socket'
require './ChatClient.rb'
Shoes.app(:title => "Chat Client",:width => 500,:height => 700, :resizable => false) do
  begin
    serv_addr = ask("Please, enter server address.") #ask for server address
    name = ask("What's your name?")
  end while not serv_addr =~ /(.+):(\d+)/
  hostname = serv_addr.split(':')[0]
  port = serv_addr.split(':')[1]
  flow do
    stack :width => "100%" do
      para "SERVER:#{serv_addr}"
      edit_box :width => "100%"
    end
 
  end
  # serv = TCPSocket.open(hostname,port)
 #  stacks do
	# para strong("") "Please enter the server address"
	# flow do
	# 	@entered_text = edit_box :width => 460, :height => 400
	# 	@connect = button "Connect"
	# end
	# @connect.click{
	# 	serv_name = @entered_text.text
	# 	if(not serv_name =~ /(.+):(\d+)/)
	# 		#clear text box and empty entered_text
	# 	else
	# 		hostname = serv_name.split(:)[0]
	# 		port = serv_name.split(:)[1]
	# 		client = ChatClient.new (hostname, port)
	# 	end
	# }
	# flows do
      # edit_box :width => 400, :height => 400
      # flows do
      #   edit_box #:width => 400, :height => 250
      #   button "send"
      # end
    # end
  # end
  
end