#!/usr/bin/env julia --project=@.

import HTTP
import HTTP.WebSockets as WebSockets

const HOST = "192.168.0.0"
const PORT = "80"


#server = WebSockets.listen!(HOST, PORT) do websocket
#
#	for message in websocket
#		send(websocket, message)
#	end
#end
	

WebSockets.open("http://"*HOST*":"*PORT) do websocket
	for message in websocket
		show(message)
	end
end
	


