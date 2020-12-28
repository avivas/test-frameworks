#!/bin/sh

echo "Spring"
autocannon -c 1000 -a 10000  http://localhost:8080/1
echo "Vertx" 
autocannon -c 1000 -a 10000  http://localhost:8081/1
