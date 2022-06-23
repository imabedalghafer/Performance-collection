#!/bin/bash
function collection()
{
    echo "============[START]============"
    echo
    echo "CURRENT TIME AND SYSTEM INFO"
    date
    uname -a
    echo
    echo "Collecing top CPU process"
    echo "# top -n 1 -b | head -16"
    top -n 1 -b | head -16
    echo
    echo "LARGEST CPU USERS"
    echo "# ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10 :"
    ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10
    echo
    echo "LARGEST MEM USERS"
    echo "# ps aux --sort -rss | head -10 :"
    ps aux --sort -rss | head -10
    echo
    echo "FREE MEMORY"
    echo "# free -mh"
    free -mh
    echo
    echo "CURRENT NETWORK CONNECTIONS"
    echo "# netstat -atunp:"
    netstat -atunp
    echo
    echo "CURRENT IP SETTINGS"
    echo "# ip addr:"
    ip addr
    echo
    echo "CURRENT IP ROUTES"
    echo "# ip route:"
    ip route
    echo
    echo "LAST DMESG INFORMATION"
    echo "# dmesg | tail -n 50:"
    dmesg | tail -n 50
    echo
    echo
    echo "Collecing IO stats"
    echo "# iostat 1 10"
    iostat 1 10
    echo
    echo "Collecting IO top info"
    echo "# /sbin/iotop -n 1 -b"
    /sbin/iotop -n 1 -b
    echo
    echo "DISK SPACE"
    echo "# df -h"
    df -h
    echo
    echo "============[END]============"
    echo
}
echo 'Please ensure that iotop is installed ....'
time_in_sec=$1
if [ -z $time_in_sec ]
then
    echo "Please enter the time in seconds .."
    exit 2
fi
echo "Collecting script for $time_in_sec seconds"
temp_drive_raw=$(ls -l /dev/disk/azure/resource-part1  | awk '{print $NF}' | cut -d '/' -f 3)
if [ -z $temp_drive_raw ]
then
    echo "This machine does not have temp drive ..."
    exit 1
fi
echo "Temp drive raw name is $temp_drive_raw"
temp_drive_mount=$(lsblk -n -o MOUNTPOINT /dev/$temp_drive_raw)
echo "Temp drive mount point name is $temp_drive_mount"
echo "Start collecting ...."
for i in $(seq 0 $time_in_sec)
do
    echo "Collecting data ..."
    collection >> $temp_drive_mount/perf_logs 
    echo "Sleeping for 1 second ..."
    sleep 1
done
echo "Done collecting, logs are in location $temp_drive_mount/perf_logs"