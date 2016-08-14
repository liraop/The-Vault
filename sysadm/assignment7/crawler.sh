#!/bin/bash

SITES=`cat $1`


for site in $SITES;
do
	STATUS=$(curl -s --head $site | head -n 1 | cut -d" " -f2)
	if [ $STATUS != "400" ]; then
		SITE=`wget -q $site`
		for palavra in `cat $2`;
		do 
			RESULTT=$(echo $SITE | grep $palavra)
		done
		if [[ -z $RESULT ]]; then
	fi
	printf "$site $STATUS \n"
done
