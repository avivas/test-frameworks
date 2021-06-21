#!/bin/bash

rm -f ./hello-world-java-loom.pid

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.2.lm-open

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

echo $! > ./hello-world-java-loom.pid

sleep 5