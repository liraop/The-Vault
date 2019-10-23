#!/bin/bash

LIMIT=9
for i in $(seq 1 "$LIMIT"); do
	result=$((i*$1))
	echo ""$i"x"$1" = "$result""
done
