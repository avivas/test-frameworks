
#!/bin/sh

echo "Construyendo hello-world-go-gingonic"

echo "Iniciando aplicacion"
./main &

echo $! > ./hello-world-go-gingonic.pid     
sleep 1

echo "Iniciando test"
WRK_HOME=/home/alejo/Descargas/wrk2-master
echo "Test GET"
$WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8082/