#!/bin/sh

cd ./hello-world-go-gingonic/
./build.sh
cd ../

cd hello-world-java-loom
./build.sh
cd ..

cd hello-world-java-spring-boot
./build.sh
cd ..

cd hello-world-java-vertx
./build.sh
cd ..

cd hello-world-rust-actix
./build.sh
cd ..