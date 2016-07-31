#!/bin/bash

### grep - text utility to search patterns in text files, printing out matches
### wc - text utility to count words, lines or even characters 
### cat - concatenate files and print on the standard output

## input text file
DATA=calgary_access_log

## a) amount of local requests 

SOUT=$(cat $DATA | grep "local - -" | wc -l)
echo "Local requisitions:$SOUT"

## b) amount of remote requests

SOUT=$(cat $DATA | grep "remote - -" | wc -l)
echo "Remote requisitions: $SOUT"

## c) average of local requisitions time

LOCALTIME=$(cat $DATA | grep "local - -" | cut -d : -f 2)
COUNT=0
HOURS=0

for hour in $LOCALTIME; do
	hour=${hour#0}
	COUNT=$((COUNT + 1))
	HOURS=$((HOURS+$hour))
done

echo "Average local requisition time:$((HOURS/COUNT))"


## d) average of remote requisitions time

REMOTETIME=$(cat $DATA | grep "remote - -" | cut -d : -f 2)
COUNT=0
HOURS=0

for hour in $REMOTETIME; do
        hour=${hour#0}
        COUNT=$((COUNT + 1))
        HOURS=$((HOURS+$hour))
done

echo "Average remote requisition time:$((HOURS/COUNT))"

#### 6 - extra feature

# amount of GET requests 
SOUT=$(cat $DATA | grep "GET" | wc -l)
echo "Total GET requests:$SOUT"

# amount of POST requests
SOUT=$(cat $DATA | grep "POST" | wc -l)
echo "Total POST requests:$SOUT"

# amount of HEAD requests
SOUT=$(cat $DATA | grep "HEAD" | wc -l)
echo "Total HEAD requests:$SOUT"
