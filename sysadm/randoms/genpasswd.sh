#!/bin/bash


read x
read y
read z
read w
X=$(echo $x | cut -c 1)
Y=$(echo $y | cut -c 2)
Z=$(echo $z | cut -c 3)
W=$(echo $w | cut -c 4)
echo ""$X""$Y""$Z""$W""
