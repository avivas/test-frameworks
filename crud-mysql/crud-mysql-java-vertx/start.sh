#!/bin/sh

echo "Starting docker crud-mysql-java-vertx"
cd src/main/docker 
docker-compose -p crud-vertx up -d

sleep 10

echo "Build crud-mysql-java-vertx"
cd ../../..

echo "Starting crud-mysql-java-vertx"

java -Xms135M\
     -Xmx135M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3333\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/crud-mysql-java-vertx-1.0.jar &

echo $! > ./crud-mysql-vertx.pid    
     
sleep 5
