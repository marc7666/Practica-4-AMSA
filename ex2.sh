#!/bin/bash

if [[ $# -eq 0 ]]
then
	rm -rf pids.txt
	touch pids.txt
	ps -e | awk '/[^0-9]/ {print $1 >> "pids.txt"}'
	echo "Conseguits els pids"
	rm -rf MEM.user
	touch MEM.user
	cat pids.txt | awk 'BEGIN {nomp = $0}/[^A-Z]/ {system("./ex2.sh " $1 " >> MEM.user")}'
	cat MEM.user | awk -F , 'BEGIN {max_mv = 0; max_mr = 0; max_tu = 0; max_ts = 0;
								ps_mv = 0; ps_mr = 0; ps_tu = 0; ps_ts = 0;
								tot_mv = 0; tot_mr = 0; tot_tr = 0; tot_ts = 0}
							/a*/ {tot_mv=tot_mv+$2;tot_mr=tot_mr+$3;tot_tu=tot_tu+$4;
								tot_ts=tot_ts+$5;
								if (max_mv<$2) {max_mv=$2; ps_mv=$1;};
								if (max_mr<$3) {max_mr=$3; ps_mr=$1;};
								if (max_tu<$4) {max_tu=$4; ps_tu=$1;};
								if (max_ts<$5) {max_ts=$5; ps_ts=$1;};}
							END { print "PID amb mes MV: " ps_mv;
								print "PID amb mes MR: " ps_mr;
								print "PID amb mes TU: " ps_tu;
								print "PID amb mes TS: " ps_ts;
								print "Mitjana de MV: " tot_mv/NR;
								print "Mitjana de MR: " tot_mr/NR;
								print "Mitjana de TU: " tot_tu/NR;
								print "Mitjana de TS: " tot_ts/NR;}'
else
	echo -n $1 "," >> MEM.user
	if [ -f /proc/$1/status ]
	then
		cat /proc/$1/status | awk 'BEGIN {ORS = ""; mv = ""; mr = ""}
									/^VmSize/ { mv = $2 }
									/^VmRSS/ { mr = $2 }
									END { print mv ", " mr ", "}'
		cat /proc/$1/stat | awk 'BEGIN {tu = ""; ts = ""}
									/a*/ {tu = $14; tr = $15}
									END { print tu ", " tr}'
	fi						
fi
	
