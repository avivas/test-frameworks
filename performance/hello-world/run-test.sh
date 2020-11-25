#!/bin/bash

if [ -d "$HOME/.sdkman/" ] ; then
  echo "Using installed sdk"
#  . ~/.bashrc
else
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

source $HOME/.sdkman/bin/sdkman-init.sh

sdk default java 15.0.1.hs-adpt
sdk default maven 3.6.3


cd hello-world-spring-boot
mvn package
java -jar target/hello-world-spring-boot-1.0.jar -Xms210M -Xmx210M -Xss180k  & HELLO_WORLD_SPRING_PID=$!
cd ..

cd hello-world-vertx
mvn package
java -jar target/hello-world-vertx-1.0.jar       -Xms135M -Xmx135M -Xss180k & HELLO_WORLD_VERTX_PID=$!
cd ..

sleep 5

echo "Hello World: Spring"
autocannon -c 5000 -a 100000 http://localhost:8080/
echo "Hello World: Vertx" 
autocannon -c 5000 -a 100000 http://localhost:8081/

kill -9 $HELLO_WORLD_SPRING_PID
kill -9 $HELLO_WORLD_VERTX_PID