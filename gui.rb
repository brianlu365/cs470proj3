require 'socket'
Shoes.app(:width => 500,:height => 700 ) do
  begin
    serv_addr = ask("Please, enter server address:") #ask for server address
  end while not serv_addr =~ /(.+):(\d+)/
  hostname = serv_addr.split(':')[0]
  port = serv_addr.split(':')[1]
  serv = TCPSocket.open(hostname,port)
  stack do
    edit_box
    edit_box :width => 460, :height => 400
    flows do
      edit_box
      edit_box :width => 400, :height => 250
      button "send"
    end
  end
  
end