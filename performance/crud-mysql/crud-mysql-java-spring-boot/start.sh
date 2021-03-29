#!/bin/sh

echo "Starting docker mysql crud-mysql-spring-boot"
cd src/main/docker 
docker-compose -p crud-spring-boot up -d
cd ../../.. 
 
sleep 10


echo "Build crud-mysql-spring-boot"
mvn clean package


echo "Starting crud-mysql-spring-boot"
java -Xms800M\
     -Xmx800M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3334\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/crud-mysql-java-spring-boot-1.0.jar &

echo $! > ./crud-mysql-spring-boot.pid
     
sleep 5