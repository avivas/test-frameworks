
#!/bin/sh

echo "Starting docker crud-mysql-go-gingonic"
cd docker 
docker-compose -p crud-mysql-go-gingonic up -d
cd ../
sleep 10


echo "Building crud-mysql-go-gingonic"
go build .

echo "Starting crud-mysql-go-gingonic"
./crud-mysql-go-gingonic &

echo $! > ./crud-mysql-go-gingonic.pid     
sleep 1

#echo "Starting test"
#WRK_HOME=/home/alejo/Descargas/wrk2-master
#echo "Test POST"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-post.lua   http://localhost:8086
#echo "Test PUT"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-put.lua    http://localhost:8086
#echo "Test GET"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000                      http://localhost:8086/1
#echo "Test DELETE"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-delete.lua http://localhost:8086/

