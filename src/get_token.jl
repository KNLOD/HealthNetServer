import SHA

# Function that converts unique patients Id into token to be checked on Server
function get_patient_token(patient_id::String)
	return bytes2hex(SHA.sha256(patient_id * "HealthNetSalt"))
end
