#!/usr/bin/env julia --project=@.
# Client for sending requests


import HTTP
import SHA
import JSON.json

const PORT = "8080"
const HOST = "127.0.0.1"
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

# Function that converts unique patients Id into token to be checked on Server
function get_patient_token(patient_id::String)
	return bytes2hex(SHA.sha256(patient_id * "HealthNetSalt"))
end


# Send JSON with POST

doc = Document("Arrhythmia!", get_patient_token(NAME))
request = HTTP.post(
	      "http://$(HOST):$(PORT)/resource/process",
	      [("Content-Type" => "application/json")],
	      json(doc);
	      verbose=3) # verbose -> number of debugging(verbose) information
show(request)
