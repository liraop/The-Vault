#!/bin/bash

if [ "$#" -eq 1 ]; then
	EXER="$1"

	TESTSET=$(ls *.in | grep "EXERCICIO_$1")
	echo "$TESTSET"
	
	

fi


if [ "$#" -eq 2 ]; then
	HW="$2"
	EXER="$1"
	
	### question number to be tested
	### 
	TMP=$(echo $HW | cut -d"_" -f1-2)

	### tests for the question in the folder
	###
	TESTSET=$(ls *.in | grep $TMP)

	echo "$HW:"
	
	for test in $TESTSET
	do
		TESTID=$(echo $test | cut -d'_' -f3 | cut -d'.' -f1)
		echo "-SAIDA PARA ENTRADA $TESTID:"

		TESTRESULT=$(sh $HW `cat $test`)
		echo "$TESTRESULT"

		OUTFILE=$(echo $test | cut -d"." -f1)
		echo $TESTRESULT > $OUTFILE.out

		echo "DIFERENCA PARA A SAIDA ESPERADA:"
		DIFF=$(diff "$test" "$OUTFILE.out")
		echo $DIFF
	done	
fi


