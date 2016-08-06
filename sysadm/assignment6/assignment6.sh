#!/bin/bash

calcule(){
local PING=$1

TIMECOLUMM=$(echo "$PING" | grep -o "time=[0-9]\{1,4\}.[0-9]\{3\}" | cut -d"=" -f2 | sort)
MEDIAN=$(echo "$TIMECOLUMM" | sed -n 5,6p | awk '{sum += $1} END {print sum/2}')
AVERAGE=$(echo "$TIMECOLUMM" | tail -n 3 | awk '{sum += $1} END {print sum/3}')

echo "Pings max avarage time: $AVERAGE ms"
echo "Pings median: $MEDIAN ms"
}

URL="uol.com.br"
PING1=$(ping -c 10 $URL)
sleep 10
PING2=$(ping -c 10 -s 64 $URL)

calcule "$PING1"
calcule "$PING2"
