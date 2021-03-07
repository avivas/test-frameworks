#!/bin/bash

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 15.0.1.hs-adpt

echo "Construyendo crud-mysql-vertx"
mvn clean package

echo "Iniciando aplicacion"

java -Xms135M\
     -Xmx135M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3081\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/hello-world-vertx-1.0.jar &

echo $! > ./hello-world-vertx.pid
     
sleep 5

echo "Iniciando test"
WRK_HOME=/home/alejo/Descargas/wrk2-master
echo "Test GET"
$WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8081/

