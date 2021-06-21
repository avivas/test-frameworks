#!/bin/sh

echo "Stop hello-world-java-vertx"
read CURRENT_PID < ./hello-world-vertx.pid
kill -9 $CURRENT_PID

sleep 1