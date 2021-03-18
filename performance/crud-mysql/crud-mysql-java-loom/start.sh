#!/bin/bash

echo "Iniciando docker mysql-java-loom"
cd src/main/docker 
docker-compose -p crud-java-loom up -d
sleep 10
cd ../../..

./build.sh

echo "Starting crud-mysql-java-loom"
echo "Using java 17 loom"
. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.2.lm-open

java -Xms135M\
     -Xmx135M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3085\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/crud-mysql-java-loom-1.0.jar &

echo $! > ./crud-mysql-java-loom.pid    
     
sleep 5

echo "Stating test"
WRK_HOME=/home/alejo/Descargas/wrk2-master
echo "Test POST"
$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-post.lua   http://localhost:8085
#echo "Test PUT"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-put.lua    http://localhost:8085
#echo "Test GET"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000                      http://localhost:8085/1
#echo "Test DELETE"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-delete.lua http://localhost:8085/

