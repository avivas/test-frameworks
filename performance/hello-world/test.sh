#!/bin/bash

# Set config to test
ulimit -n 100000

# Run hello world test

function test_framework {
    # Start app
    cd $1
    ./start.sh
    cd ../

    # Start test
    cd hello-world-performance-test
    ./test.sh $1
    cd ../

    # Stop app
    cd $1
    ./stop.sh
    cd ../
}

# Create summary file
echo "app,total request,request/sec,failed request" > hello-world-performance-test/summary-hello-world.csv


# Start test
#----------------------------------------
test_framework hello-world-go-gingonic
test_framework hello-world-java-loom
test_framework hello-world-java-spring-boot
test_framework hello-world-java-vertx
# ----------------------------------------

