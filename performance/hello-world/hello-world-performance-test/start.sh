#!/bin/bash

function test_k6 {
    k6 run hello-world-k6.js
}

function test_wrk {
    WRK_HOME=/home/alejo/Descargas/wrk2-master
    $WRK_HOME/wrk -t12 -c200 -d60s -R600000 http://localhost:8080/ > summary.json
}

echo "Starting test"
test_wrk
#test_k6