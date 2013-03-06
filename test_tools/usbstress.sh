#!/bin/sh
# Origin from Peter Senna Tschudin - peter.senna AT gmail.com - 29/10/2008
# Origin source: https://github.com/petersenna/linux_stuff/tree/master/USB_Storage_Stress_Test
# This is useful to test USB stability.
# ./usbstress.sh /dev/sdc1 <- replace sdc1 with your usb storage device
# SIZE=10000 ./usbstress.sh /dev/sdc1 <- change test size to 10000KB

# SIZE * 1024
# default SIZE is 50000 KB
if [ -z "$SIZE" ]; then
        SIZE=50000
fi

date=`date +"%Y-%m-%d_%H.%M.%S"`
mkdir -p /tmp/mnt/$date

umount $1

i=0
dmesg -c 2>&1 1> /dev/null

while [ TRUE ];do
	echo "======================================================="
	echo $i-`date +"%Y-%m-%d_%H.%M.%S"`
	i=`expr $i + 1`
	mount $1 /tmp/mnt/$date
	if [ $? != 0 ];then
		exit 1
	fi
	echo HOST to USB:
	dd if=/dev/zero of=/tmp/mnt/$date/file bs=1024 count=$SIZE
	sync
	umount $1
	mount $1 /tmp/mnt/$date
	if [ $? != 0 ];then
		exit 1
	fi
 
	echo USB to HOST:
	dd if=/tmp/mnt/$date/file of=/dev/null bs=1024
	rm -rf /tmp/mnt/$date/file
	umount $1

	echo "== kernel message =="
	dmesg -c
done
