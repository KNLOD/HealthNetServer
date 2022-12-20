#!/usr/bin/env julia --project=@.

include("LocalDataSource.jl")
import Sockets
import HTTP
import HTTP.WebSockets 

import JSON

const patient_token = "a642e1c72a5444859567707febfbd65a11c6759c1ce080f48ada67e234209f59"
# declare rout processor
# 
index(req::HTTP.Request) = HTTP.Response(200, "You've Connectet to the HealthNetServer")

function welcome_user(req::HTTP.Request)

	user = ""
	if (m = match( r".*/user/([[:alpha:]]+)", req.target)) != nothing #RegEx
		user = m[1]
	end
	return HTTP.Response(200, "Hello " * user)
end

"""
Send message to WebSocketServer through tcp 
"""
function send_message()  
	tcp_client = Sockets.connect(2000)
	@async while isopen(tcp_client)
		write(tcp_client, "Alarm!")
		close(tcp_client)
	end
end

# Parse JSON
#
function process_resource(req::HTTP.Request) where T

	message = JSON.parse(String(req.body))
	@info message
	patient_token = message["patient_token"]
	if is_patient_in_db(patient_token)
		message["server_mark"] = "You're not a Stranger, Help is on the way!"
		@async send_message()

		
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




HTTP.serve(ROUTER, "0.0.0.0", 8080)





