#!/usr/bin/env julia --project=@.

import HTTP
import HTTP.WebSockets as WebSockets

const HOST = "0.0.0.0"
const PORT = "12346"


#server = WebSockets.listen!(HOST, PORT) do websocket
#
#	for message in websocket
#		send(websocket, message)
#	end
#end
	

WebSockets.open("ws://"*HOST*":"*PORT) do websocket
	for message in websocket
		@info message
	end
end
	


