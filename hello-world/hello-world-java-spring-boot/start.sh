#!/bin/sh

rm -f ./hello-world-spring-boot.pid

sdk use java 15.0.1.hs-adpt

echo "Starring hello-world-java-spring-boot"
java -Xms210M\
     -Xmx210M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=2222\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/hello-world-java-spring-boot-1.0.jar &

echo $! > ./hello-world-spring-boot.pid
     
sleep 5


  