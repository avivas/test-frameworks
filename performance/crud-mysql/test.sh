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
    ./start.sh $1

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


# Merge results
cd crud-mysql-performance-test

echo "app,method,total request,request/sec,failed request" > summary-crud-mysql.csv

cat summary-delete-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-delete-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-delete-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-delete-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv

echo >> summary-crud-mysql.csv
cat summary-get-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-get-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-get-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-get-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv

echo >> summary-crud-mysql.csv
cat summary-post-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-post-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-post-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-post-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv

echo >> summary-crud-mysql.csv
cat summary-put-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-put-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-put-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
echo >> summary-crud-mysql.csv
cat summary-put-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv