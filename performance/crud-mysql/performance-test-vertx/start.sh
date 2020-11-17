#!/bin/sh

 docker run --name crud-mysql-vertx -p 23306:3306 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=crud -e MYSQL_USER=user -e MYSQL_PASSWORD=password -v $PWD/src/main/sql:/docker-entrypoint-initdb.d -d mysql:8.0.22 