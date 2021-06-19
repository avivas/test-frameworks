
#!/bin/sh

rm -f ./hello-world-go-gingonic.pid

source  ~/.gvm/scripts/gvm
gvm use go1.16.5

echo "Build hello-world-go-gingonic"
go build .

echo "Start hello-world-go-gingonic"
./hello-world-go-gingonic &

echo $! > ./hello-world-go-gingonic.pid     
sleep 1