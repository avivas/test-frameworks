#!/bin/sh

read CURRENT_PID < ./hello-world-java-loom.pid
kill -9 $CURRENT_PID