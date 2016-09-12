#!/bin/bash

###
### download files
###
function getFiles()
{
	URL=$1
	FILES=$2
	
	for FILE in $FILES
	do
		wget -q $URL$FILE
	done
}


###
### filter files from folders 
###
function filterFiles()
{
	HTML=$1
	FILES=`echo "$HTML" | grep '<a href=' | cut -d'"' -f2 | grep -v "/"`
	printf '%b\n' "$FILES"
}

URL=$1
PAGE=`curl -s $1`
FILES=$(filterFiles "$PAGE")
getFiles $URL "$FILES"
