#!/bin/sh

cd crud-mysql-go-gingonic
./build.sh
cd ..

cd crud-mysql-java-loom
./build.sh
cd ..

cd crud-mysql-java-spring-boot
./build.sh
cd ..

cd crud-mysql-java-vertx
./build.sh
cd ..