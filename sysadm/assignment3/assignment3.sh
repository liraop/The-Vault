#!/bin/bash

if [ "$#" -eq 0 ]; then
        ASSIGNSET=$(ls *.sh)
	
	for assign in $ASSIGNSET
	do
		TESTPATTERN=$(echo $assign | cut -d"." -f1 | cut -d"_" -f1-2)
		TESTSET=$(ls *.in | grep $TESTPATTERN)
                
		for test in $TESTSET
                do
			TESTID=$(echo $test | cut -d'_' -f3 | cut -d'.' -f1)
                        echo "-SAIDA PARA ENTRADA $TESTID:"

                        TESTRESULT=$(sh $assign `cat $test`)
                        echo "$TESTRESULT"

                        OUTFILE=$(echo $test | cut -d"." -f1)
                        echo $TESTRESULT > $OUTFILE.out

                        echo "DIFERENCA PARA A SAIDA ESPERADA:"
                        DIFF=$(diff "$test" "$OUTFILE.out")
                        echo $DIFF
		done
        done
fi


if [ "$#" -eq 1 ]; then
	EXER="EXERCICIO_$1"

	TESTSET=$(ls *.in | grep "$EXER")
	ASSIGNSET=$(ls *.sh | grep "$EXER")
	
	for assign in $ASSIGNSET
	do
		ASSIGNID=$(echo $assign | cut -d"." -f1)
		echo "$ASSIGNID"
		for test in $TESTSET
		do
			TESTID=$(echo $test | cut -d'_' -f2 | cut -d'.' -f1)
	                echo "-SAIDA PARA ENTRADA $TESTID:"

	                TESTRESULT=$(sh $assign `cat $test`)
	                echo "$TESTRESULT"

	                OUTFILE=$(echo $test | cut -d"." -f1)
	                echo $TESTRESULT > $OUTFILE.out

	                echo "DIFERENCA PARA A SAIDA ESPERADA:"
	                DIFF=$(diff "$test" "$OUTFILE.out")
	                echo $DIFF
		done	
	done
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


