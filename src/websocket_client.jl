#!/usr/bin/env julia --project=@.

import HTTP
import HTTP.WebSockets as WebSockets

const HOST = "0.0.0.0"
const PORT = "12346"


WebSockets.open("ws://"*HOST*":"*PORT) do websocket
	for message in websocket
		@info message
	end
end
	


