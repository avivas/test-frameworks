
#!/bin/sh

rm -f ./hello-world-go-gingonic.pid

echo "Start hello-world-go-gingonic"
./hello-world-go-gingonic &

echo $! > ./hello-world-go-gingonic.pid     
sleep 1