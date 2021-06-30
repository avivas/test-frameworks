#!/bin/sh

# Run hello world tests
cd ./hello-world/
./run-test.sh
cd ../

# Run crud mysql tests
cd ./crud-mysql/
./run-test.sh
cd ../
