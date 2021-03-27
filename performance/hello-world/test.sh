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
    ./start.sh
    mv summary.json summary-$1.json
    cd ../

    # Stop app
    cd $1
    ./stop.sh
    cd ../
}

# Start test
#----------------------------------------
test_framework hello-world-go-gingonic
test_framework hello-world-java-loom
# ----------------------------------------
