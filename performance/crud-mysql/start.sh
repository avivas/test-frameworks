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
    ./test.sh $1
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


# Merge results
#cd crud-mysql-performance-test



#cat summary-delete-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-delete-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-delete-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-delete-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv

#echo >> summary-crud-mysql.csv
#cat summary-get-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-get-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-get-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-get-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv

#echo >> summary-crud-mysql.csv
#cat summary-post-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-post-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-post-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-post-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv

#echo >> summary-crud-mysql.csv
#cat summary-put-crud-mysql-java-vertx.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-put-crud-mysql-go-gingonic.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-put-crud-mysql-java-loom.csv >> summary-crud-mysql.csv
#echo >> summary-crud-mysql.csv
#cat summary-put-crud-mysql-java-spring-boot.csv >> summary-crud-mysql.csv

# Remove csv files
#rm summary-delete-crud-mysql-java-vertx.csv 
#rm summary-delete-crud-mysql-go-gingonic.csv
#rm summary-delete-crud-mysql-java-loom.csv 
#rm summary-delete-crud-mysql-java-spring-boot.csv 
#rm summary-get-crud-mysql-java-vertx.csv 
#rm summary-get-crud-mysql-go-gingonic.csv
#rm summary-get-crud-mysql-java-loom.csv 
#rm summary-get-crud-mysql-java-spring-boot.csv
#rm summary-post-crud-mysql-java-vertx.csv
#rm summary-post-crud-mysql-go-gingonic.csv
#rm summary-post-crud-mysql-java-loom.csv
#rm summary-post-crud-mysql-java-spring-boot.csv
#rm summary-put-crud-mysql-java-vertx.csv
#rm summary-put-crud-mysql-go-gingonic.csv
#rm summary-put-crud-mysql-java-loom.csv
#rm summary-put-crud-mysql-java-spring-boot.csv