#!/bin/bash

echo "Build hello-world-rust-actix"
cargo build --release

echo "Start hello-world-rust-actix"
./target/release/hello-world-rust-actix &

echo $! > ./hello-world-rust-actix.pid

sleep 1