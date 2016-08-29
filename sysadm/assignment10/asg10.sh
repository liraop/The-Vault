#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
	CODE=$(echo "$line" | cut -d" " -f1)
	METHOD=$(echo "$line" | cut -d" " -f2)
	FILE=$(echo "$line" | cut -d" " -f3)
done < "$1"
