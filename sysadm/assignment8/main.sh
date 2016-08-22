#!/bin/bash


###
### in case of URL file
###
###

function fileInput()
{
	for SITE in `cat $1`; do
		getStatus $SITE
	done
}

###
### get the URL's information
###
###

function getStatus()
{
		URL=$1
		GOUT=`getent hosts $URL`
                STATUS=`printf $?`
                if [ $STATUS -gt 0 ]; then
                        printf "$URL ERROR\n"
                else
                        MOBILE=$(hasMobile $URL)
                        IPS=`echo "$GOUT" | wc -l`
                        printf "$URL $IPS $MOBILE\n"
                fi
}

###
### check if URL has 'm.' domain
###
###

function hasMobile()
{
	getent hosts "m.$1" >> /dev/null
	STATUS=`printf $?`
	if [ $STATUS -eq 0 ]; then
		echo "MOBILE"
        fi
}

while getopts "f:" OPT; do
	case "${OPT}" in
		f) FILENAME="${OPTARG}"
		fileInput $FILENAME ;;
	esac
done

if [ $# -ne 0 ]; then
	getStatus $1
fi

exit 0
