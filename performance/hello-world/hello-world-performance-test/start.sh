#!/bin/sh

echo "Hello World: Spring"
autocannon -c 10000 -a 100000 http://localhost:8080/
echo "Hello World: Vertx" 
autocannon -c 10000 -a 100000 http://localhost:8081/
