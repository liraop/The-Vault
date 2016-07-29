#!/bin/bash

if [ "$#" -gt 0 ]; then
        EXER="EXERCICIO_$1"
        TESTSET=$(ls *.in | grep "$EXER")

	if [ "$#" -eq 2 ]; then
		ASSIGNSET="$2"
	else
	        ASSIGNSET=$(ls *.sh | grep "$EXER")
	fi
else 
        ASSIGNSET=$(ls EXERCICIO*.sh )
fi	

for assign in $ASSIGNSET
do
		TESTPATTERN=$(echo $assign | cut -d"." -f1 | cut -d"_" -f1-2)		# pattern to match tests in folder
		TESTSET=$(ls *.in | grep $TESTPATTERN) 					# set of tests found in folder
		ASSIGNID=$(echo $assign | cut -d"." -f1)
		echo "$ASSIGNID:"
		for test in $TESTSET
                do
			TESTID=$(echo $test | cut -d'_' -f3 | cut -d'.' -f1)
                        echo "-SAIDA PARA ENTRADA $TESTID:"

                        TESTRESULT=$(sh $assign `cat $test`)				# run script with test input
                        echo -e "$TESTRESULT \n"

                        OUTFILE=$(echo $test | cut -d"." -f1)				# test output
                        echo $TESTRESULT > $OUTFILE.out

                        echo "DIFERENCA PARA A SAIDA ESPERADA:"
                        DIFF=$(diff "$test" "$OUTFILE.out")				# diff from test output vs expected output
                        echo -e "$DIFF\n"
	done
done
