#!/bin/bash

function test_k6 {
    k6 run -e APP_NAME=$1 crud-mysql-k6-post.js
    cat summary-post-$1.csv >> summary-crud-mysql.csv
    echo >> summary-crud-mysql.csv
    rm summary-post-$1.csv
    
    k6 run -e APP_NAME=$1 crud-mysql-k6-put.js
    cat summary-put-$1.csv >> summary-crud-mysql.csv
    echo >> summary-crud-mysql.csv
    rm summary-put-$1.csv

    k6 run -e APP_NAME=$1 crud-mysql-k6-get.js
    cat summary-get-$1.csv >> summary-crud-mysql.csv
    echo >> summary-crud-mysql.csv
    rm summary-get-$1.csv

    k6 run -e APP_NAME=$1 crud-mysql-k6-delete.js
    cat summary-delete-$1.csv >> summary-crud-mysql.csv
    echo >> summary-crud-mysql.csv
    rm summary-delete-$1.csv
}

function test_wrk {
    WRK_HOME=/home/alejo/Descargas/wrk2-master
    echo "Test POST"
    $WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-post.lua   http://localhost:8080   > summary-post.json
    echo "Test PUT"
    $WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-put.lua    http://localhost:8080   > summary-put.json
    echo "Test GET"
    $WRK_HOME/wrk -t12 -c200 -d60s -R600000                      http://localhost:8080/1 > summary-get.json
    echo "Test DELETE"
    $WRK_HOME/wrk -t12 -c200 -d60s -R600000 -s ./wrk2-delete.lua http://localhost:8080/  > summary-delete.json
}

echo "Starting test"
#test_wrk
test_k6 $1