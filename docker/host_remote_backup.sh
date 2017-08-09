#!/bin/sh
#
# exporting dockers containers as images
#

#
# export container $1 with sufix $2
# to target $3
#
exportContainer () {
	NAME=$1

	printf "%s\n" "Exporting container $NAME"	

	docker export $1 > "$3/$1$2.tar"
		printf %"s\n" "$1$2.tar"
}


## list of running containers
CLIST=$(docker ps | rev | cut -d" " -f1 | rev | tr "\n" " " | cut -d" " -f2-)

mkdir /tmp/dockerbkp

for CONTAINER in $CLIST 
do
	## seconds since unix time
	DATE=$(date +%s)
	exportContainer $CONTAINER $DATE "/tmp/dockerbkp"
done

### current date
DATE=$(date +%d%m%y)

if [ "$#" -eq 0 ]; then
	exit 0
elif [ "$#" -eq 1 ]; then
	if [ "$1" != "-c" ]; then
		printf "Invalid option"
	else
		printf "%s\n" "Compressing backup files..."
 
		tar -caf "/tmp/docker_backup$DATE.tar.bz2" /tmp/dockerbkp &> /dev/null
	fi

fi
