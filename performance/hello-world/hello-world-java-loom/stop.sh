#!/bin/sh

read CURRENT_PID < ./hello-world-java-loom-1.0.pid
kill -9 $CURRENT_PID