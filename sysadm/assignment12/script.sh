#!/bin/bash

if [ "$#" -eq 2 ];
then
	SOURCE=$1
	TARGET=$2
elif [ "$#" -eq 3 ];
then
	if [ "$1" == "-z" ];
	then
		printf "geras"
	else 
		exit 0
	fi

fi
