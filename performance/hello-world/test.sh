#!/bin/sh

# Set config to test
ulimit -n 100000

# Run hello world test


# Start hello-world-go-gingonic
#----------------------------------------
cd hello-world-go-gingonic
./start.sh
cd ../

# Start test
cd hello-world-performance-test
./start.sh
mv summary.json summary-hello-world-go-gingonic.json
cd ../

# Stop hello-world-go-gingonic
cd hello-world-go-gingonic
./stop.sh
# ----------------------------------------
