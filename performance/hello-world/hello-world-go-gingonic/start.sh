
#!/bin/sh

source  ~/.gvm/scripts/gvm
gvm use go1.16.5

echo "Build hello-world-go-gingonic"
go build .

echo "Start hello-world-go-gingonic"
./hello-world-go-gingonic &

echo $! > ./hello-world-go-gingonic.pid     
sleep 1

#echo "Iniciando test"
#WRK_HOME=/home/alejo/Descargas/wrk2-master
#echo "Test GET"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8082/