#!/bin/sh

docker stop crud-vertx_mysql_1

read CURRENT_PID < ./crud-mysql-vertx.pid

kill -9 $CURRENT_PID