#!/usr/bin/env julia --project=@.
# Client for sending requests


import Sockets
import HTTP
import SHA
import JSON.json

const PORT = "8080"
const HOST = "0.0.0.0"
const NAME = "KNLOD"

# Document format

struct Document
	title::String
	patient_token::String
end

Base.show(r::HTTP.Messages.Response) =
	println(r.status == 200 ? String(r.body) : "Error: " * r.status)

# Root route
request = HTTP.get("http://$(HOST):$(PORT)")
show(request)

# Request rout /user/:name

request = HTTP.get("http://$(HOST):$(PORT)/user/$(NAME)"; verbose=1)
show(request)



# Send JSON with POST

doc = Document("Arrhythmia!", NAME)
request = HTTP.post(
	      "http://$(HOST):$(PORT)/resource/process",
	      [("Content-Type" => "application/json")],
	      json(doc);
	      verbose=3) # verbose -> number of debugging(verbose) information
show(request)
