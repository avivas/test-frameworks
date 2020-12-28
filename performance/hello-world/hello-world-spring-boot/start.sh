#!/bin/sh

 docker run --name crud-mysql -p 13306:3306 -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=crud -e MYSQL_USER=user -e MYSQL_PASSWORD=password -d mysql:8.0.22 