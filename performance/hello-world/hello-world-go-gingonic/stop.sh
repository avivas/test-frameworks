#!/bin/sh

read CURRENT_PID < ./hello-world-go-gingonic.pid
kill -9 $CURRENT_PID