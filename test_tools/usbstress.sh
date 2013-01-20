#!/bin/sh
# Peter Senna Tschudin - peter.senna AT gmail.com - 29/10/2008
# This is useful to test USB stability.
# ./usbstress.sh /dev/sdc1 <- replace sdc1 with your usb storage device
# from https://github.com/petersenna/linux_stuff/tree/master/USB_Storage_Stress_Test

# SIZE * 1024
SIZE=500000

date=`date +"%Y-%m-%d_%H.%M.%S"`
mkdir -p /mnt/$date

umount $1

i=0
dmesg -c 2>&1 1> /dev/null

while [ TRUE ];do
	echo . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
	echo $i-`date +"%Y-%m-%d_%H.%M.%S"`
	let i++
	mount $1 /mnt/$date
	if [ $? != 0 ];then
		exit 1
	fi
	echo HOST to USB:
	dd if=/dev/zero of=/mnt/$date/file bs=1024 count=$SIZE
	sync
	umount $1
	mount $1 /mnt/$date
	if [ $? != 0 ];then
		exit 1
	fi
 
	echo USB to HOST:
	dd if=/mnt/$date/file of=/dev/null bs=1024
	rm -rf /mnt/$date/file
	umount $1

	dmesg -c
done
