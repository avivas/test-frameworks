#!/bin/sh

docker stop crud-java-loom_mysql_1

read CURRENT_PID < ./crud-mysql-java-loom.pid

kill -9 $CURRENT_PID