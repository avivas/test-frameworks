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

echo "Starting test"
test_k6 $1