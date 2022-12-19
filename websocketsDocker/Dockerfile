
FROM --platform=linux/x86_64 julia:alpine

COPY websocket_server.jl home/src/websocket_server.jl

RUN julia -e "import Pkg; Pkg.add(\"HTTP\"); Pkg.add(\"LibPQ\"); Pkg.add(\"Tables\"); Pkg.add(\"SHA\"); Pkg.add(\"JSON\"); Pkg.add(\"Sockets\")"

CMD julia home/src/websocket_server.jl

