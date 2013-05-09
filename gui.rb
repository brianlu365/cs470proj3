require 'socket'
Shoes.app(:width => 500,:height => 500 ) do
  # begin
  #   serv_addr = ask("Please, enter server address:") #ask for server address
  # end while not serv_addr =~ /(.+):(\d+)/
  # hostname = serv_addr.split(':')[0]
  # port = serv_addr.split(':')[1]
  # serv = TCPSocket.open(hostname,port)
	# flows do
    #   edit_box
    #   edit_box :width => 400, :height => 250
    #   button "send"
    # end
	background "#EFC"
	flow :width => 500, :margin => 10 do
		stack :width => "50%" do
			@names = edit_box :height => "300"
		end
		stack :width => "50%" do
			@chat = edit_box :height => "300"
		end
		stack :width => "100%" do
			@msg = edit_box
		end
	end
end