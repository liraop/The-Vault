#!/bin/bash

SITES=`cat $1`

if [ $# -gt 1  ]; then
        WORDS=`cat $2`
	WORDSTATUS="OK!"
fi


for url in $SITES;
do
        COUNTER=0
        TOTAL=0
        STATUS=$(curl --silent --head $url | head -n 1 | cut -d" " -f2) # site status
        SITE=`wget -qO- $url`                                           # download page and save it on variable
        for word in $WORDS;
        do
                RESULT=$(echo $SITE | grep $word)
                if [ -z "$RESULT" ]; then                               # if the word is not found
                        WORDSTATUS=""                                   # it returns blank
                else
                        COUNTER=$((COUNTER+1))
                fi
                TOTAL=$((TOTAL+1))
		MSG="Words found: $COUNTER out of $TOTAL \n"
        done
        printf "$url $STATUS $WORDSTATUS\n"
        printf "$MSG"					                # extra feature - show found words #
done
