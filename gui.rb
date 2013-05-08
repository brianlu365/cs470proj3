require 'socket'
Shoes.app(:width => 500,:height => 700 ) do
  # begin
  #   serv_addr = ask("Please, enter server address:") #ask for server address
  # end while not serv_addr =~ /(.+):(\d+)/
  # hostname = serv_addr.split(':')[0]
  # port = serv_addr.split(':')[1]
  # serv = TCPSocket.open(hostname,port)
  stacks do
	para strong("") "Please enter the server address"
	flow do
		@entered_text = edit_box :width => 460, :height => 400
		@connect = button "Connect"
	end
	@connect.click{
		serv_name = @entered_text.text
		if(not serv_name =~ /(.+):(\d+)/)
			#clear text box and empty entered_text
		else
			hostname = serv_name.split(:)[0]
			port = serv_name.split(:)[1]
			client = ChatClient.new (hostname, port)
		end
	}
	# flows do
    #   edit_box
    #   edit_box :width => 400, :height => 250
    #   button "send"
    # end
  end
  
end