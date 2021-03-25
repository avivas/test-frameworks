#!/bin/sh

docker stop crud-mysql-go-gingonic_mysql_1
docker rm crud-mysql-go-gingonic_mysql_1

read CURRENT_PID < ./crud-mysql-go-gingonic.pid

kill -9 $CURRENT_PID