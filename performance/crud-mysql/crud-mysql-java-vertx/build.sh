#!/bin/bash

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 15.0.1.hs-adpt < /dev/null
sdk use maven 3.6.3 < /dev/null

echo "Build crud-mysql-java-spring-boot"
mvn clean package
