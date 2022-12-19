

FROM --platform=linux/x86_64 julia:alpine

COPY REQUIRE $HOME/REQUIRE
COPY ../src/server.jl home/src/server.jl
# load packages defined in REQUIRE
# RUN julia -e "import Pkg; mv(\"$HOME/REQUIRE\",joinpath(dirname(pathof(REQUIRE)),remove_destination=true); Pkg.resolve(); for p in Pkg.available(); end"

RUN julia -e "import Pkg; Pkg.add(\"HTTP\"); Pkg.add(\"LibPQ\"); Pkg.add(\"Tables\"); Pkg.add(\"SHA\"); Pkg.add(\"JSON\"); Pkg.add(\"Sockets\")"

CMD julia home/src/server.jl

