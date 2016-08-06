#!/bin/bash

URL="uol.com.br"
PING1=$(ping -c 10 $URL)
#sleep 10
#PING2=$(ping -c 10 -s 64 $URL)

echo "$PING1" | grep -o "time=[0-9]\{1,4\}.[0-9]\{3\}" | cut -d"=" -f2 | sort -nr
