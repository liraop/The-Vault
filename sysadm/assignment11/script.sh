#!/bin/bash

function getFiles()
{
	HTML=$1
	FILES=`echo "$HTML" | grep '<a href=' | cut -d'"' -f2 | grep -v "/"`
	printf '%b\n' "$FILES"
}

URL=$1
PAGE=`curl -s $1`
getFiles "$PAGE"
