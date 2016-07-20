#!/bin/bash

## awk - pattern scanning and processing language
## ps - report a snapshot of the current processes

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

## in a percentage it is impossible to be above of 100.0%
## that is why MAX value is set 100.0 and MIN 0
MAXCPU=0
MINCPU=100.0
MAXMEM=0
MINMEM=100.0

while [ $COUNTER -le $SAMPLES ]
do
	## identify process by user column match 
	## and gather information

	RUN=$(ps aux |
	awk '{if ($1 == "'"$P_USER"'") {
			processes++;
			run_cpu += $3;
			run_mem += $4;
			vmSize += $5}}
		END {print run_cpu,run_mem,processes,vmSize}')

	## a) b)

	echo "### BEGIN RUN $COUNTER ###"
	RUNCPU=$(echo $RUN | cut -d" " -f1)
	echo "Sample CPU usage "$RUNCPU"%"
	RUNMEM=$(echo $RUN | cut -d" " -f2)
	echo "Sample memory usage "$RUNMEM"%"
	echo "### END RUN $COUNTER ###"

	### extra features ###

        PROCESSES=$(echo $RUN | cut -d" " -f3)
	VSZ=$(echo $RUN | cut -d" " -f4)

	AVERAGE_CPU_LOAD=$(echo "$RUNCPU $PROCESSES" | awk '{ print $1/$2}')
        AVERAGE_MEM_LOAD=$(echo "$RUNMEM $PROCESSES" | awk '{ print $1/$2}')
	## get vsz average and convert to MB
	AVERAGE_VSZ_LOAD=$(echo "$VSZ $PROCESSES" | awk '{ print ($1/$2)/1024}')

	### end of extra features ###

	## c) d)

	MAXCPU=$(echo "$RUNCPU $MAXCPU" | awk '{ max = ($1 > $2 ? $1 : $2) } {print max}')
	MAXMEM=$(echo "$RUNMEM $MAXMEM" | awk '{ max = ($1 > $2 ? $1 : $2) } {print max}')
	MINCPU=$(echo "$RUNCPU $MINCPU" | awk '{ min = ($1 < $2 ? $1 : $2) } {print min}')
        MINMEM=$(echo "$RUNMEM $MINMEM" | awk '{ min = ($1 < $2 ? $1 : $2) } {print min}')

	COUNTER=$((COUNTER+1))
	if [ $COUNTER -le $SAMPLES ]; then
		sleep $SAMPLING_TIME
	fi
done
echo "CPU usage - Max:"$MAXCPU"% Min:"$MINCPU"%"
echo "Memory usage - Max:"$MAXMEM"% Min:"$MINMEM"%"

### extra feature ###

echo "Total processes: "$PROCESSES""
echo "Average CPU load by processes: "$AVERAGE_CPU_LOAD""
echo "Average MEM load by processes: "$AVERAGE_MEM_LOAD""
echo "Average virtual memory size by processes: "$AVERAGE_VSZ_LOAD"MB"
