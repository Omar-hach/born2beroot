#!/bin/bash

echo "#Architecture : $(uname -a)"
echo "#CPU physical : $(lscpu | awk '/^CPU\(s\)/{print$2}')"
echo "#vCPU : $(lscpu | awk '/^Socket/{print$2}')"
echo "#Memory Usage: $(free --mega | awk 'NR==2 {printf "%s/%sMB (%.2f%%)\n", $3, $2, $3/$2*100}')"
echo "#Disk Usage : $(df -BM | awk 'NR>1 {size+=$2; used+=$3} END {printf"%s/%sMB (%.2f%%)\n", used, size, used/size}')"
echo "#CPU load : $(top -b -n 1 | awk 'NR==3{print$2"%"}')"
echo "#Last boot : $(who -b | awk '{print$3" "$4}')"
echo "#LVM use : $(grep "/dev/mapper" /etc/fstab | awk 'NR==1 {if($1 ~ /^\/dev\/mapper\//) print"yes"; else print"no";}')"
echo "#Connections TCP : $(ss -s | awk 'NR==2{print$4" ESTABLISHED"}')" | sed 's/,//g'
echo "#User log : $(who | awk '{print$1}' | sort -u | wc -l)"
echo "#Network : IP $(ip a | grep -A 2 "state UP" | awk 'NR!=1 {print$2}' | awk '{if(NR==1) mac=$1; else ip =$1;} END {printf"IP %s (%s)\n", ip, mac}' | sed 's/\/24//g')"
echo "#Sudo : $(journalctl -q _COMM=sudo | grep COMMAND | wc -l) cmd"
