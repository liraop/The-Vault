#!/bin/sh
#
# remote access, copy and delete backup. 
#
#

ssh fama@10.25.13.251 "./backup-containers.sh"

DATE=$(date +%d%m%y)

scp fama@10.25.13.251:/tmp/docker_backup$DATE.tar.bz2 ./

ssh fama@10.25.13.251 "rm -rf /tmp/dockerbkp && rm docker_backup$DATE.tar.bz2"
