#!/bin/bash

# Set config to test
ulimit -n 100000

# Run crud mysql test
function test_framework {
    # Start app
    cd $1
    ./start.sh
    cd ../

    # Start test
    cd crud-mysql-performance-test
    ./run-test.sh $1
    cd ../

    # Stop app
    cd $1
    ./stop.sh
    cd ../
}

echo "app,method,total request,request/sec,failed request" > crud-mysql-performance-test/summary-crud-mysql.csv

# Start test
#----------------------------------------
test_framework crud-mysql-go-gingonic
test_framework crud-mysql-java-loom
test_framework crud-mysql-java-spring-boot
test_framework crud-mysql-java-vertx
# ----------------------------------------
