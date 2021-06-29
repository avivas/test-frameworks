#!/bin/bash

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.2.lm-open < /dev/null
sdk use maven 3.6.3 < /dev/null

echo "Build hello-world-java-loom"
mvn clean package