#!/bin/bash

#####
# Script written to automatically adjust nvidia's GPU fan speed.
#
# written by liraop - lirapdo@gmail.com
#
#####

gputemp=`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits`

## enable GPU persistence

startSpeed=`nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits`
case $gputemp in
[0-4][0-9])
   targetSpeed=40
   `nvidia-settings -a [fan:0]/GPUTargetFanSpeed=$targetSpeed`
   ;;
5[0-9])
   targetSpeed=50
   `nvidia-settings -a [fan:0]/GPUTargetFanSpeed=$targetSpeed`
   ;;
6[0-9])
   targetSpeed=60
   `nvidia-settings -a [fan:0]/GPUTargetFanSpeed=$targetSpeed`
   ;;
[7-9][0-9])
   targetSpeed=100
   `nvidia-settings -a [fan:0]/GPUTargetFanSpeed=$targetSpeed`
   ;;
*)
   msg="We can certainly say something is wrong"
   ;;
esac

finalSpeed=`nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits`
msg="Fan speed was $startSpeed%\nFan speed is $finalSpeed%"

printf %b "$msg"
