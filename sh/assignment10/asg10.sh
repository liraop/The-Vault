#!/bin/bash

###
### check if file is exists
###
function checkFile()
{
	if [[ `ls | grep -wc "$1"` -gt 0 ]]; then
		echo 1					### found
	else 
		echo 0					### not found 
	fi
}

###
### check if code matches file
###
function checkCode()
{
	INCODE=$1
	METHOD=$2
	FILE=$3

	case $METHOD in
		"MD5") OUTCODE=$(md5sum $FILE | cut -d" " -f1) ;;
		"CRC") OUTCODE=$(cksum $FILE | cut -d" " -f1) ;;
		"SHA1") OUTCODE=$(sha1sum $FILE | cut -d" " -f1) ;;
	esac

	if [[ $INCODE = $OUTCODE ]]; then
		echo 1				### codes match
	else
		echo 0				### codes do not match
	fi
}

###
### extra feature - generate code for files in directory
###

function genCodes()
{
	FILE=$1
	RESULT="File name: $FILE\n"
	TMP=`md5sum $FILE | cut -d" " -f1`
	RESULT="${RESULT}MD5: $TMP\n"
        TMP=`sha1sum $FILE | cut -d" " -f1`
	RESULT="${RESULT}SHA1: $TMP\n"
	TMP=`cksum $FILE | cut -d" " -f1`
	RESULT="${RESULT}CRC: $TMP\n"

	printf '%b\n' "$RESULT"
}

###
### extra feature - when 0 inputs
###

if [[ $# -eq 0 ]]; then
	LOCALDIR=`ls -p | grep -v /`
	for FILE in $LOCALDIR
	do
		genCodes $FILE 
	done
	exit 0
fi

###
### end extra feature
###

while IFS='' read -r line || [[ -n "$line" ]]; do
	CODE=$(echo "$line" | cut -d" " -f1)
	METHOD=$(echo "$line" | cut -d" " -f2)
	FILE=$(echo "$line" | cut -d" " -f3)	

	if [[ $(checkFile $FILE) -ne 0 ]]; then
		if [[ $(checkCode $CODE $METHOD $FILE) -ne 0 ]]; then
			printf "OK $FILE\n"
		else
			printf "ERROR $FILE\n"
		fi
	else 
		printf "NOT_FOUND $FILE\n" 
	fi
done < "$1"
