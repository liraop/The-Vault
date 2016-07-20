#!/bin/bash
COUNTER=1

if [ $# -eq 3 ]; then
	if [ $1 -le 0 -o $2 -le 0 ] || $(test -z $3); then
		exit 1
	fi
	
	SAMPLES=$1
	SAMPLING_TIME=$2
	P_USER=$3
else 
	read SAMPLES
	read SAMPLING_TIME
	read P_USER
	
fi

MAXCPU=0
MINCPU=100.0
MAXMEM=0
MINMEM=100.0

while [ $COUNTER -le $SAMPLES ]
do

	RUN=$(ps aux | 
	awk '{ processes=0;
		if ($1 == "'"$P_USER"'") {
			processes++;	
			run_cpu += $3;
			run_mem += $4;}
		} 
		END {print run_cpu,run_mem,processes}')

	echo "### BEGIN RUN $COUNTER ###"
	RUNCPU=$(echo $RUN | cut -d" " -f1)
	echo "Sample CPU usage "$RUNCPU"%"
	RUNMEM=$(echo $RUN | cut -d" " -f2)
	echo "Sample memory usage "$RUNMEM"%"
	echo "### END RUN $COUNTER ###"

	MAXCPU=$(echo "$RUNCPU $MAXCPU" | awk '{ max = ($1 > $2 ? $1 : $2) } {print max}')
	MAXMEM=$(echo "$RUNMEM $MAXMEM" | awk '{ max = ($1 > $2 ? $1 : $2) } {print max}')

	MINCPU=$(echo "$RUNCPU $MINCPU" | awk '{ min = ($1 < $2 ? $1 : $2) }  {print min}')
        MINMEM=$(echo "$RUNMEM $MINMEM" | awk '{ min = ($1 < $2 ? $1 : $2) }  {print min}')

	


	COUNTER=$((COUNTER+1))
	if [ $COUNTER -le $SAMPLES ]; then
		sleep $SAMPLING_TIME
	fi
done
echo "CPU usage - Max:"$MAXCPU"% Min:"$MINCPU"%"
echo "Memory usage - Max:"$MAXMEM"% Min:"$MINMEM"%"

### extra feature ###
