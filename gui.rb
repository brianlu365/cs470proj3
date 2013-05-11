require './ChatClient.rb'
Shoes.app(:title => "Chat Client",:width => 500,:height => 700, :resizable => false) do
  begin
    serv_addr = ask("Please, enter server address.") #ask for server address
  end while not serv_addr =~ /(.+):(\d+)/
  begin
    name = ask("What's your name?") #ask for username
  end while name.nil?
  hostname = serv_addr.split(':')[0]
  port = serv_addr.split(':')[1]
  s = ChatClient.new(hostname,port,name) #create connect to server
  s.sendName s.name #send name to server

  flow :margin => 10, :height => "100%" do
    stack  do
      para "#{serv_addr}"
      flow :width => "100%" do
        stack :width => "25%" do
          para "friend list"
          @friend_box = stack :width => "100%",:height  => 400, :scroll=>true do
            background yellow
            @p1 = para ""
            # # para = s.gets
            # para s.gets
          end
        end
        @read_box = stack :width => "75%",:height  => 500, :scroll=>true do
          background whitesmoke
        end
      end
      flow :width => "100%", :height => 40 do
      end
      flow do
        @write_box = edit_box :width => "75%"
        stack :width => "25%" do 
          flow :width => "100%",:height => "60%" do
          end
          @send_button = button "send" 
          @send_button.click do
            if not @write_box.text.nil?
              s.send @write_box.text

              @write_box.text = ""
              
            end
          end
        end
      end
    end
  end

  Thread.new {
    loop do
      if line = s.gets
        ary = line.split(":")
        case ary[0]
        when "#FRIEND"
          s.friends = ary[1].split(",")
          @p1.text = s.friends.join("\r")
        when "#JOINED"
          s.addFriend ary[1]
          @p1.text = s.friends.join("\r")

        when "#LEFT"
          s.friends.delete ary[1]
          @p1.text = s.friends.join("\r")
        when "#ERROR"
          @read_box.append do 
            stack :width => "100%" do
              background red
              para ary[1]
            end
          end
          @read_box.scroll_top=@read_box.scroll_max
        else
          @read_box.append do 
            stack :width => "100%" do
              background whitesmoke
              para line
            end
          end
          @read_box.scroll_top=@read_box.scroll_max
        end
      end
    end
  }


end