#!/bin/bash

###
### returns the last field of a text
### $1 = delimiter
### $2 = text
###
function getLastDelimitedField()
{
	ABSOLUTE=$2
	echo $2 | rev | cut -d"$1" -f1 | rev
}

###
### function to copy $1 to $2
###
function createCopy()
{
	SOURCE=$1
	TARGET=$2
	rsync -ar $1 $2
}

###
### check files' occurrences in
### the target folder. 
###
function checkOccurrences()
{
	FILE=$(getLastDelimitedField / $1)
	TARGET=$2
	GREP=`ls $2 | grep $FILE`
	
	if [[ -z "$GREP" ]]; then
		echo 0			## no occurrences on folder
	else
		echo "$GREP" | rev | cut -d"." -f1 | rev 
	fi
}

if [ "$#" -eq 2 ]; then
	checkOccurrences $1 $2
elif [ "$#" -eq 3 ]; then
	if [ "$1" == "-z" ]; then
		echo 0
	else
		echo 1
	fi
fi
