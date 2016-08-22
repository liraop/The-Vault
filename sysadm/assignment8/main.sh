#!/bin/bash

function main
{
	for SITE in `cat $1`; do
		GOUT=`getent hosts $SITE`
		STATUS=`printf $?`
		if [ $STATUS -gt 0 ]; then
			printf "$SITE ERROR\n"
		else 
			IPS=`printf "$GOUT" | wc -l`
			printf "$SITE $IPS\n"
		fi
	done
}

while getopts f: OPT; do
	case "${OPT}" in
		f) FILENAME="${OPTARG}"
		main $FILENAME ;;
	esac
done

exit 0
