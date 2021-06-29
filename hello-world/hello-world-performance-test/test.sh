#!/bin/bash

function test_k6 {
    k6 run -e APP_NAME=$1 hello-world-k6.js 
    cat summary-$1.csv >> summary-hello-world.csv 
    echo >> summary-hello-world.csv
    rm summary-$1.csv
}

function test_wrk {
    WRK_HOME=/home/alejo/Descargas/wrk2-master
    $WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8080/ > summary.json
}

echo "Starting test: $1"

#test_wrk
test_k6 $1