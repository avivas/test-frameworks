#!/bin/bash

echo "Starting docker crud-mysql-java-loom"
cd src/main/docker 
docker-compose -p crud-java-loom up -d
sleep 10
cd ../../..

./build.sh

echo "Starting crud-mysql-java-loom"
echo "Using java 17 loom"
. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.2.lm-open

#~/Descargas/openjdk-17-loom+4-174_linux-x64_bin/jdk-17/bin/
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
