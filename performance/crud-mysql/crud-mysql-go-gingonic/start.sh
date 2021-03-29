
#!/bin/sh

echo "Starting docker crud-mysql-go-gingonic"
cd docker 
docker-compose -p crud-mysql-go-gingonic up -d
cd ../
sleep 10


echo "Building crud-mysql-go-gingonic"
go build .

echo "Starting crud-mysql-go-gingonic"
./crud-mysql-go-gingonic &

echo $! > ./crud-mysql-go-gingonic.pid     
sleep 1