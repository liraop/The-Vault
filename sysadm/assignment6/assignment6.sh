#!/bin/bash

medianAverage(){
	local PING=$1

	TIMECOLUMM=$(echo "$PING" | grep -o "time=[0-9]\{1,4\}.[0-9]\{3\}" | cut -d"=" -f2 | sort)
	MEDIAN=$(echo "$TIMECOLUMM" | sed -n 5,6p | awk '{sum += $1} END {print sum/2}')
	AVERAGE=$(echo "$TIMECOLUMM" | tail -n 3 | awk '{sum += $1} END {print sum/3}')
	
	### extra feature - average of faster replies 

	FASTERAVERAGE=$(echo "$TIMECOLUMM" | head -n 3 | awk '{sum += $1} END {print sum/3}')
	
	echo "Pings max (slower) average time: $AVERAGE ms"
	echo "Pings median: $MEDIAN ms"
	echo "Pings min (faster) time: $FASTERAVERAGE ms"
}


URL="uol.com.br"

echo -n "Pinging default size"
PING1=$(ping -c 10 $URL)
medianAverage "$PING1"

sleep 10

echo -n "Pinging packet size = 64"
PING2=$(ping -c 10 -s 64 $URL)
medianAverage "$PING2"


### 1) X = ping's target address/domain 
###    Y = actual IP that is responding the ICMP request (DNS trasnlation) 
###    Z = ping packet size
###    W = the total packet size, which means, Z (ping packet size) added 20 bytes of IP header and 
###	   8 bytes for ICMP header

### 2)	A = reply's packet size
###	B = domain that is responding the ICMP request
###	C = the actual IP address of the domain (DNS translation)
###	D = icmp_seq is an "id" for the request. Each ICMP reply shall match its request, e.g. the
###	   first request shall receive the reply with  icmp_seq=1 
###	E = TTL (time-to-live) is the "lifespan" of a ping request to reach the destination. At each 
###	   router, this number is drecremented by one. If it reaches 0, the packet is discarded.
###	F = delay time from sending sending the ping and receiving the response

### 3)	X is a domain name, it can be represented by a farm/cluster of hosts as a measure to improve 
###	reliability, security and/or performance. Thus, the domain name of the response (B) can be 
### 	different. So B is the actual DNS's server domain that replies the request for google.com. 
