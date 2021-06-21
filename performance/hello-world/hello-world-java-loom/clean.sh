#!/bin/bash

rm -f hello-world-java-loom.pid

source $HOME/.sdkman/bin/sdkman-init.sh
sdk use java 17.ea.7.lm-open
sdk use maven 3.6.3 
mvn clean
