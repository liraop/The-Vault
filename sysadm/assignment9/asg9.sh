#!/bin/bash


### 
### funciontion to convert HH:MM:SS into seconds
###
function convertToSeconds()
{
	echo $1 | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }'
}

URL=$1
GETTIME="grep -oh "[0-2][0-9]:[0-5][0-9]:[0-5][0-9]""			### pattern to grep time
GETRTT="grep -o 'RTT:[0-9].[0-9]\{1,3\}' | cut -d: -f2 "		### rtt(operation total time) pattern

CURLGET=`curl --silent -Iw RTT:%{time_total} $URL` 			### curl with http header and total operation time in seconds

### extra feature
### check if domain exists
if [ $? -gt 0 ]; then
	printf "Domain is offline or does not exist. Try another one\n"
	exit 1
fi

RTT=`echo $CURLGET | eval $GETRTT `
printf "$RTT\n"								### curl get operation total time in seconds

SERVERTIME=`echo $CURLGET | eval $GETTIME`
printf "$SERVERTIME\n"							### http header server time

LOCALTIME=`date | eval $GETTIME`
printf "$LOCALTIME\n"							### current localtime

LTS=`convertToSeconds $LOCALTIME`
STS=`convertToSeconds $SERVERTIME`

echo "$LTS $STS" | awk -F'-' '{print $1-$2}'				### local time - server time in seconds
exit 0
