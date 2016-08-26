#!/bin/bash

function convertToSeconds()
{
	echo $1 | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }'
}

URL=$1
GETTIME="grep -oh "[0-2][0-9]:[0-5][0-9]:[0-5][0-9]""
GETRTT="grep -o 'RTT:[0-9].[0-9]\{1,3\}' | cut -d: -f2 "

CURLGET=`curl --silent -Iw RTT:%{time_total} $URL`

RTT=`echo $CURLGET | eval $GETRTT `
printf "$RTT\n"

SERVERTIME=`echo $CURLGET | eval $GETTIME`
printf "$SERVERTIME\n"

LOCALTIME=`date | eval $GETTIME`
printf "$LOCALTIME\n"

LTS=`convertToSeconds $LOCALTIME`
STS=`convertToSeconds $SERVERTIME`

echo "$LTS $STS" | awk -F'-' '{print $1-$2}'
