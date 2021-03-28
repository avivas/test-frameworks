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
    ./start.sh
    mv summary-post.json   summary-post-$1.json
    mv summary-put.json    summary-put-$1.json
    mv summary-get.json    summary-get-$1.json
    mv summary-delete.json summary-delete-$1.json
    cd ../

    # Stop app
    cd $1
    ./stop.sh
    cd ../
}

# Start test
#----------------------------------------
test_framework crud-mysql-go-gingonic
test_framework crud-mysql-java-loom
test_framework crud-mysql-java-spring-boot
test_framework crud-mysql-java-vertx
# ----------------------------------------
