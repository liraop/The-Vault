#!/bin/bash

###
### got from:
### http://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
###
function isNumber()
{
	 [[ ${1} == *[[:digit:]]* ]]
}

###
### returns the last field of a text
### $1 = delimiter
### $2 = text
###
function getLastDelimField()
{
	TEXT=$2
	echo $2 | rev | cut -d"$1" -f1 | rev
}

###
### function to copy $1 to $2
### $3 = filename
### $4 = id 
###
function createCopy()
{
	SOURCE=$1
	TARGET=$2
	FILENAME=$3
	ID=$4
	FINALTARGET="$TARGET/$FILENAME$ID"

	printf "Criando backup de $SOURCE em $FINALTARGET\n"
	rsync -ar $SOURCE $FINALTARGET
}

###
### check item occurrences in
### the target folder. 
### $1 = item to be counted
### $2 = target folder
###
function checkOccurrences()
{
	FILE=$1
	TARGET=$2
	GREP=`ls $2 | grep ^$FILE$`
	
	if [[ -z "$GREP" ]]; then
		echo -1					## no occurrences on folder
	else
		TMP=$(getLastDelimField "." "$GREP")
		if [[ $(isNumber $TMP) ]]; then
			echo $TMP			## number of occurrences
		else 
			echo 0				## only one occurency
		fi
	fi
}

SOURCEPATH=$1
TARGETPATH=$2
FILENAME=$(getLastDelimField "/" $1)

if [ "$#" -eq 2 ]; then
	OCCURRENCES=$(checkOccurrences $FILENAME $TARGETPATH)
	if [[ $OCCURRENCES -ge 0 ]]; then
		SUFIX=".${OCCURRENCES+1}"
		createCopy $SOURCEPATH $TARGETPATH $FILENAME $SUFIX
	else 
		createCopy $SOURCEPATH $TARGETPATH $FILENAME
	fi
elif [ "$#" -eq 3 ]; then
	if [ "$1" == "-z" ]; then
		echo 0
	else
		printf "Invalid option"
		exit 1
	fi
fi
