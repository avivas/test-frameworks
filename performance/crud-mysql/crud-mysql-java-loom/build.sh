#!/bin/bash

echo "Using java 17 loom"
. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.2.lm-open


echo "Building crud-mysql-java-loom"
mvn clean package

 