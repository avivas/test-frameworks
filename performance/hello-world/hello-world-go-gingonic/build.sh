#!/bin/bash

source  ~/.gvm/scripts/gvm
gvm use go1.16.5

echo "Build hello-world-go-gingonic"
go build .
