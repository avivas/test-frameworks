#!/bin/sh

docker stop crud-spring-boot_mysql_1
docker rm crud-spring-boot_mysql_1

read CURRENT_PID < ./crud-mysql-spring-boot.pid

kill -9 $CURRENT_PID