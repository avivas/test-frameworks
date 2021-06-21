#!/bin/bash

. ~/.sdkman/bin/sdkman-init.sh
sdk use java 15.0.1.hs-adpt

echo "Build hello-world-java-vertx"
mvn clean package