#!/bin/bash

function createCopy()
{
	SOURCE=$1
	TARGET=$2
	rsync -ar $1 $2
}

if [ "$#" -eq 2 ];
then

elif [ "$#" -eq 3 ];
then
	if [ "$1" == "-z" ];
	then

	else
	fi

fi
