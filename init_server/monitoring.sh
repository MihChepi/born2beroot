#!/bin/bash

round()
{
	echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};

total=$(free -m | grep Mem: | awk '{print$2}')
used=$(free -m | grep Mem: | awk '{print$3}')
procOfUse=$( round $used*100/$total 2)

date=$(who -b | awk '{print$3}')
time=$(who -b | awk '{print$4}')

MemAll=$(df --total | grep total | awk '{print$2}')
MemAll=$(echo "$MemAll / 1024" | bc)
MemUsed=$(df --total | grep total | awk '{print$3}')
MemUsed=$(echo "$MemUsed / 1024" | bc)
procMemUsage=$( round $MemUsed*100/$MemAll 2)

LVM=$(lvscan | grep -c ACTIVE)
isLVM=$(if [ $LVM -eq 0 ]; then echo no; else echo yes; fi)

IP=$(hostname -I)
MAC=$(ip link show | grep link/ether | awk '{print$2}')

wall "
#Architecture:    $(uname -a)
#CPU physical:    $(nproc --all)
#vCPU:            $(cat /proc/cpuinfo | grep processor | wc -l)
#Memory Usage:    $used/$total"MB" ($procOfUse%)
#Disk Usage:      $MemUsed/$(round $MemAll/1000 1)Gb ($procMemUsage%)
#CPU load:        $(top -bn1 | grep %Cpu | awk '{print$2}')%
#Last boot:       $date $time
#LVM use:         $isLVM
#Connections TCP: $(netstat -ant | grep -c ESTABLISHED) ESTABLISHED
#User log:        $(who | wc -l)
#Network:         IP $IP ($MAC)
#Sudo:            $(cat /var/log/sudo/sudo.log | grep -c COMMAND) cmd"
