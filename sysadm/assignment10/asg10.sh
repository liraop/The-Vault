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

while IFS='' read -r line || [[ -n "$line" ]]; do
	CODE=$(echo "$line" | cut -d" " -f1)
	METHOD=$(echo "$line" | cut -d" " -f2)
	FILE=$(echo "$line" | cut -d" " -f3)
	
done < "$1"
