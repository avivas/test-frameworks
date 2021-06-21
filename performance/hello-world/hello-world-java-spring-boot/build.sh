#!/bin/bash

. ~/.sdkman/bin/sdkman-init.sh

sdk use java 15.0.1.hs-adpt
sdk use maven 3.6.3

echo "Build hello-world-java-spring-boot"
mvn clean package
