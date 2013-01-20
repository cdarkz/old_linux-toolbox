#!/bin/sh
# ./ping_test.sh ip_address

IP=$1
COUNT=1000
SIZE_GROUP="32 64 128 256 512 1024 2048 4096 8192 16384 32768 65500"

test -z $IP && echo "Please assign IP address" && exit

for size in $SIZE_GROUP
do
	echo "########################################"
	ping -s $size -c $COUNT -q $IP
	echo ""
done
