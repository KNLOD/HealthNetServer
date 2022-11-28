#!/usr/bin/env julia --project=@.

import Sockets
import HTTP
import HTTP.WebSockets 

import JSON

const patient_token = "a642e1c72a5444859567707febfbd65a11c6759c1ce080f48ada67e234209f59"
# declare rout processor
# 
index(req::HTTP.Request) = HTTP.Response(200, "Hello World")

function welcome_user(req::HTTP.Request)

	user = ""
	if (m = match( r".*/user/([[:alpha:]]+)", req.target)) != nothing #RegEx
		user = m[1]
	end
	return HTTP.Response(200, "Hello " * user)
end

# Parse JSON
#
function process_resource(req::HTTP.Request)

	message = JSON.parse(String(req.body))
	@info message
	if message["patient_token"] == patient_token
		#@async webSocketServer.send(webSocketServer, "Alarm!")
		message["server_mark"] = "You're not a Stranger, Help is on the way!"
		return HTTP.Response(200, JSON.json(message))
	else 
		return HTTP.Response(401, "Unauthorized")
	end
end


# Register routes and processors
#
const ROUTER = HTTP.Router()
HTTP.register!(ROUTER, "GET", "/", index)
HTTP.register!(ROUTER, "GET", "/user/*", welcome_user)
HTTP.register!(ROUTER, "POST", "/resource/process", process_resource)


#webSocketServer = HTTP.WebSockets.listen!("192.168.0.0", 80)
HTTP.serve(ROUTER, Sockets.localhost, 8080)





