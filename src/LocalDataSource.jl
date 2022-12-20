using LibPQ, Tables
include("get_token.jl")

function connect()

	conn= LibPQ.Connection("host=localhost port=5432 dbname=healthnet_db user=admin password=root")
	return conn

end



function get_patients()
	
	conn= connect()
	result = execute(conn, "SELECT * FROM patients")
	@info columntable(result)
	for raw in result
		println(raw)
	end

	show("completed")
	close(conn)
end


function create_table()
	conn = connect()
	result = execute(conn, """
			 CREATE TABLE IF NOT EXISTS patients (
				patient_id serial PRIMARY KEY,
				token varchar(255) UNIQUE NOT NULL)
				""")
	close(conn)
end

function is_patient_in_db(token::String)
	conn = connect()
	token = get_patient_token(token)
	result = execute(conn, "SELECT * FROM patients WHERE token=\$1", [token])
	data = columntable(result)
	if data.token == []
		close(conn)
		return false
	end

	close(conn)
	return true

end


function save_patient(token::String)
	conn = connect()
	token_decrypt = get_patient_token(token) 
	LibPQ.load!((;token=[token_decrypt]),
	      conn,
	      "INSERT INTO patients (token) VALUES (\$1);")
	execute(conn, "COMMIT;")
	close(conn)

end



