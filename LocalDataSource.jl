using LibPQ, Tables


conn= LibPQ.Connection("host=localhost port=5432 dbname=test2 user=postgres password=password")



result = execute(conn, "SELECT * FROM student")
for raw in result
	show(raw) 
end
show("completed")


close(conn)
