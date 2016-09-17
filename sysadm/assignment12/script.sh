#!/bin/bash

###
### remove bars from paths 
###
function getFinalName()
{
	ABSOLUTE=$1
	echo $1 | rev | cut -d"/" -f1 | rev
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
### check files' version in
### the target folder. 
###
function checkVersion()
{
	FILE=$1
	TARGET=$2
	GREP=`ls $2 | grep $1`
	
	if [[ -z "$GREP" ]]; then
		printf "NADA"
	fi
}

if [ "$#" -eq 2 ]; then
	checkVersion $1 $2
elif [ "$#" -eq 3 ]; then
	if [ "$1" == "-z" ]; then
		echo 0
	else
		echo 1
	fi
fi
