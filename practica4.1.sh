#!/bin/bash

cd /proc
sudo su
awk 'BEGIN{system("date")}' > /home/mem_lliure.lst
for i in {60..1}; do
	awk '/MemTotal/{memt=$2; print memt};/MemFree/{memf=$2; print memf; exit}' meminfo >> /home/mem_lliure.lst
	awk '{print $1}{exit}' loadavg >> /home/mem_lliure.lst #imprimim la carrega del sistema de l'ultim minut
	awk 'BEGIN{FS=","}/dev/&&/size/{tmp=$3;print tmp}' mounts | awk 'BEGIN{FS="="}NR==1{print $2}' >> /home/mem_lliure.lst #imprimeix la memoria utilitzada i la disponible del sistema de fitxers montat
	sleep 1
done
awk 'BEGIN{system("date")}' >> /home/mem_lliure.lst
exit 0
