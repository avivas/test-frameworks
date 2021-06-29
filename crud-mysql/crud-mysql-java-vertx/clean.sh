#!/bin/bash

./stop.sh

rm -f crud-mysql-vertx.pid

source $HOME/.sdkman/bin/sdkman-init.sh
sdk use java 15.0.1.hs-adpt
sdk use maven 3.6.3 
mvn clean
