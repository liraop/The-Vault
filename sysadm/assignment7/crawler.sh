#!/bin/bash

SITES=`cat $1`

if [ $# -gt 1  ]; then
	WORDS=`cat $2`
else 
	WORDS=""
fi

WORDSTATUS="OK!"

for url in $SITES;
do
	COUNTER=0
	TOTAL=0
	STATUS=$(curl --silent --head $url | head -n 1 | cut -d" " -f2)	# site status
	SITE=`wget -qO- $url`						# download page and save it on variable
	for word in $WORDS;
	do
		RESULT=$(echo $SITE | grep $word)
	        if [[ -z $RESULT ]]; then				# if the word is not found
			WORDSTATUS=""					# it returns blank
		else 
			COUNTER=$((COUNTER+1))
		fi
		TOTAL=$((TOTAL+1))
	done
	printf "$url $STATUS $WORDSTATUS\n"
	printf "Words found: $COUNTER out of $TOTAL \n"			# extra feature - show # of found words
done
