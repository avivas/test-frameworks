#!/bin/bash

source  ~/.gvm/scripts/gvm
gvm use go1.16.5

echo "Building crud-mysql-go-gingonic"
go build .