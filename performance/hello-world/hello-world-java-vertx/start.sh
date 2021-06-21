#!/bin/bash

rm -f ./hello-world-vertx.pid

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 15.0.1.hs-adpt

echo "Start hello-world-java-vertx"

java -Xms135M\
     -Xmx135M\
     -Xss190k\
     -Dcom.sun.management.jmxremote=true\
     -Dcom.sun.management.jmxremote.port=3081\
     -Dcom.sun.management.jmxremote.authenticate=false\
     -Dcom.sun.management.jmxremote.ssl=false\
     -jar\
     target/hello-world-java-vertx-1.0.jar &

echo $! > ./hello-world-vertx.pid
     
sleep 5

