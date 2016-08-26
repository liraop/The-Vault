#!/bin/bash

URL=$1
GETTIME="grep -oh "[0-2][0-9]:[0-5][0-9]:[0-5][0-9]""
GETRTT="grep -o 'RTT:[0-9].[0-9]\{1,3\}' | cut -d: -f2 "

CURLGET=`curl --silent -Iw RTT:%{time_total} $URL`

RTT=`echo $CURLGET | eval $GETRTT `
printf "$RTT\n"

SERVERTIME=`echo $CURLGET | eval $GETTIME`
printf "$SERVERTIME\n"

LOCALTIME=`uptime | eval $GETTIME`
printf "$LOCALTIME\n"
