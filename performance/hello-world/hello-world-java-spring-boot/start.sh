#!/bin/sh


echo "Construyendo crud-mysql-spring-boot"
mvn clean package


echo "Iniciando aplicacion"
java -Xms210M\
     -Xmx210M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=2222\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/hello-world-spring-boot-1.0.jar &

echo $! > ./hello-world-spring-boot.pid
     
sleep 5
echo "Iniciando test"
WRK_HOME=/home/alejo/Descargas/wrk2-master
$WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8080/


  