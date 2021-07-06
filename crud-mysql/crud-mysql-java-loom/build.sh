#!/bin/bash

echo "Using java 17 loom"
. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.7.lm-open < /dev/null
sdk use maven 3.6.3 < /dev/null


echo "Building crud-mysql-java-loom"
mvn clean package

 