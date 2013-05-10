require './ChatClient.rb'
Shoes.app(:title => "Chat Client",:width => 500,:height => 700, :resizable => false) do
  begin
    serv_addr = ask("Please, enter server address.") #ask for server address
  end while not serv_addr =~ /(.+):(\d+)/
  begin
    name = ask("What's your name?")
  end while name.nil?
  hostname = serv_addr.split(':')[0]
  port = serv_addr.split(':')[1]
  flow :margin => 10, :height => "100%" do
    stack  do
      para "#{serv_addr}"
      flow :width => "100%" do
        stack :width => "25%" do
          para "friend list"
          edit_box :width => "100%", :height => 400
        end
        edit_box :width => "75%", :height => 500
      end
      flow :width => "100%", :height => 40 do
      end
      flow do
        edit_box :width => "75%"
        stack :width => "25%" do 
          flow :width => "100%",:height => "60%" do
          end
          button "send" 
        end
      end
    end
  end
  # background "#EFC"
  # flow :width => 500, :margin => 10 do
  #   stack :width => "50%" do
  #     @names = edit_box :height => "300"
  #   end
  #   stack :width => "50%" do
  #     @chat = edit_box :height => "300"
  #   end
  #   para "Please type the message here.\n"
  #   stack :width => "500" do
  #     @msg = edit_box
  #   end
  #   @disconnect = button "disconnect"
  #   @send = button "send"
  # end
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