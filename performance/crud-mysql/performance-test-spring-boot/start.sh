#!/bin/sh

#docker run --name crud-mysql -p 13306:3306 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=crud -e MYSQL_USER=user -e MYSQL_PASSWORD=password -d mysql:8.0.22
 
echo "Iniciando docker mysql spring-boot"
cd src/main/docker 
docker-compose -p crud-spring-boot up -d
cd ../../.. 
 
sleep 10


echo "Construyendo crud-mysql-spring-boot"
mvn clean package


echo "Iniciando aplicacion"
java -Xms800M\
     -Xmx800M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3334\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/crud-mysql-1.0.jar &

echo $! > ./crud-mysql-spring-boot.pid
     
sleep 5
echo "Iniciando test"
WRK_HOME=/home/alejo/Descargas/wrk2-master
$WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2.lua  http://localhost:8080