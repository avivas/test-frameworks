#!/bin/bash

rm -f ./hello-world-rust-actix.pid

echo "Start hello-world-rust-actix"
./target/release/hello-world-rust-actix &

echo $! > ./hello-world-rust-actix.pid

sleep 1