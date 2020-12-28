#!/bin/sh

echo "Iniciando docker mysql"
cd src/main/docker 
docker-compose -p crud-vertx up -d

sleep 10

echo "Construyendo crud-mysql-vertx"

cd ../../..
mvn clean package

echo "Iniciando aplicacion"

java -Xms135M\
     -Xmx135M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3333\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/crud-mysql-vertx-1.0.jar &

echo $! > ./crud-mysql-vertx.pid    
     
sleep 5

echo "Iniciando test"
WRK_HOME=/home/alejo/Descargas/wrk2-master
$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2.lua  http://localhost:8081