using LibPQ, Tables


conn= LibPQ.Connection("host=localhost port=5432 dbname=test2 user=postgres password=password")



result = execute(conn, "SELECT * FROM patients")
@info columntable(result)
for raw in result
	println(raw)
end

show("completed")

result = execute(conn, """
		 CREATE TABLE IF NOT EXISTS patients (
		 	patient_id serial PRIMARY KEY,
			key varchar(255) UNIQUE NOT NULL)
			""")

"""
LibPQ.load!(
	    (;key = ["12345dasd"]),
	    conn,
	    "INSERT INTO patients (key) VALUES (\$1);") 

execute(conn, "COMMIT;") 
"""

close(conn)
