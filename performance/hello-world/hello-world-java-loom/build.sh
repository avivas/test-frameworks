#!/bin/bash

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.2.lm-open
 
echo "Build hello-world-java-loom"
mvn clean package