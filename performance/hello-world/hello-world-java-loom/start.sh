#!/bin/bash

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.2.lm-open
 
echo "Construyendo hello-world-java-loom"
mvn clean package

#-XX:+UseZGC\
echo "Iniciando aplicacion"
java -Xms440M\
     -Xmx440M\
     -Xss190k\
     -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=85 -XX:G1MaxNewSizePercent=85\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3084\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -server\
     -jar\
     target/hello-world-java-loom-1.0.jar &

echo $! > ./hello-world-java-loom-1.0.pid

sleep 5

#echo "Iniciando test"
#WRK_HOME=/home/alejo/Descargas/wrk2-master
#echo "Test GET"
#$WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8084/