#!/bin/bash

function main()
{
	for SITE in `cat $1`; do
		GOUT=`getent hosts $SITE`
		STATUS=`printf $?`
		if [ $STATUS -gt 0 ]; then
			printf "$SITE ERROR\n"
		else 
			MOBILE=$(hasMobile $SITE)
			IPS=`echo "$GOUT" | wc -l`
			printf "$SITE $IPS $MOBILE\n"
		fi
	done
}

function hasMobile()
{
	getent hosts "m.$1" >> /dev/null
	STATUS=`printf $?`
	if [ $STATUS -eq 0 ]; then
		echo "MOBILE"
        fi
}

while getopts f: OPT; do
	case "${OPT}" in
		f) FILENAME="${OPTARG}"
		main $FILENAME ;;
	esac
done
exit 0
