#!/bin/sh
#
# remote access, copy and delete backup. 
# creates respective folders in $1 for 
# each host backed up. 
#
#

HOSTS="10.25.13.251 10.25.13.253"
DATE=$(date +%d%m%y)
TARGET=$1

for HOST in $HOSTS
do
	mkdir -p $TARGET/docker_backups/$HOST/

	ssh fama@$HOST "./host_remote_backup.sh -c"

	printf %"s\n" "Transfering backup file"

	scp fama@$HOST:"/tmp/docker_backup$DATE.tar.bz2" $TARGET/docker_backups/$HOST/

	printf %"s\n" "Cleaning files"

	ssh fama@$HOST "rm -rf /tmp/dockerbkp"
	ssh fama@$HOST "rm /tmp/docker_backup$DATE.tar.bz2"
done
