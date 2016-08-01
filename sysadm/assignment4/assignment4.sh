#!/bin/bash

command=$(echo $@ | cut -d" " -f1)
args=$(echo $@ | cut -d" " -f2-)

strace -T -o out $command $args &> /dev/null				## default output to null, save strace out to file
sout=$(cat out | tr '\n' '\n' | grep ' = [0-] <') 			## get strace output without distortions nor useless lines

(echo "$sout" | awk '{print $NF,$0}' | sort -nr | cut -f2- -d' ' | head -n 3) 	## awk - print last column as first followed by the entire print;  sort -nr (numeric - reverse sorting); cut the modification made for sorting 
