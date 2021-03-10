#!/bin/sh

read CURRENT_PID < ./hello-world-vertx.pid
kill -9 $CURRENT_PID