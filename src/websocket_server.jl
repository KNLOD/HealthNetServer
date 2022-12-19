using Sockets
import HTTP
import HTTP.WebSockets 


webSocketServer = HTTP.WebSockets.listen("0.0.0.0", 12346) do ws
	HTTP.WebSockets.send(ws, "Alarm!")
	begin
	tcp_server = listen(2000)
		while true 
			show("Im here")
			sock = accept(tcp_server)
			show(sock)
			while isopen(sock)
				line = readline(sock, keep=true)
				println("\nline: $line")
			end
			HTTP.WebSockets.send(ws, "Alarm!")
		end
	end
end


		

