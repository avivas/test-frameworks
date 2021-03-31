#!/bin/bash

function test_k6 {
    k6 run -e APP_NAME=$1 hello-world-k6.js 
}

function test_wrk {
    WRK_HOME=/home/alejo/Descargas/wrk2-master
    $WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8080/ > summary.json
}

echo "Starting test: $1"
#test_wrk
test_k6 $1



echo "app,total request,request/sec,failed request" > summary-hello-world.csv
cat summary-hello-world-java-vertx.csv >> summary-hello-world.csv 
echo >> summary-hello-world.csv
cat summary-hello-world-go-gingonic.csv >> summary-hello-world.csv 
echo >> summary-hello-world.csv
cat summary-hello-world-java-loom.csv >> summary-hello-world.csv 
echo >> summary-hello-world.csv
cat summary-hello-world-java-spring-boot.csv >> summary-hello-world.csv 