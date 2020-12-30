#!/bin/sh

read CURRENT_PID < ./hello-world-spring-boot.pid
kill -9 $CURRENT_PID