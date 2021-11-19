#!/bin/bash
total=$(free -m | grep Mem: | awk '$1=="Mem:"{print$2}')
used=$(free -m | grep Mem: | awk '$1=="Mem:"{print$3}')
us=$(bc<<<"scale=2;$used*100/$total")
date=$(who -b | awk '{print$3}')
time=$(who -b | awk '{print$4}')
LVM=$(sudo lvscan | grep -c ACTIVE)
LVMyn=$(if [ $LVM -eq 0 ]; then echo no; else echo yes; fi)
MemRall=$(df | grep root | awk '{print$2}')
MemRus=$(df | grep root | awk '{print$3}')
MemHall=$(df | grep home | awk '{print$2}')
MemHus=$(df | grep home | awk '{print$3}')
MemAll=$(($MemRall / 1024 + $MemHall / 1024))
MemUsed=$(($MemRus / 1024 + $MemHus / 1024))
MemUsage=$(bc<<<"scale=2;$MemUsed*100/$MemAll")
IP=$(hostname -I)
MAC=$(ip link show | grep link/ether | awk '{print$2}')
wall "
#Architecture:    $(uname -a)
#CPU physical:    $(nproc --all)
#vCPU:            $(cat /proc/cpuinfo | grep processor | wc -l)
#Memory Usage:    $used/"$total"MB ($us%)
#Disk Usage:      $MemUsed/$(bc<<<"scale=1;$MemAll/1000")Gb ($MemUsage%)
#CPU load:        $(top -bn1 | grep %Cpu | awk '{print$2}')%
#Last boot:       $date $time
#LVM use:         $LVMyn
#Connections TCP: $(netstat -ant | grep -c ESTABLISHED) ESTABLISHED
#User log:        $(who | wc -l)
#Network:         IP $IP ($MAC)
#Sudo:            $(cat /var/log/sudo/sudo.log | grep -c COMMAND) cmd"
