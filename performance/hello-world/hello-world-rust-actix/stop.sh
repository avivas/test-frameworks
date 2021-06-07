#!/bin/bash

echo "Stop hello-world-rust-actix"
read CURRENT_PID < ./hello-world-rust-actix.pid
kill -9 $CURRENT_PID