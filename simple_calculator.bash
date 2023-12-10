#!/bin/bash

#global variables
re='^[0-9]+$'
re2='^[-+]?[0-9]+\.?[0-9]*$'
calc_type=""
first_int=""
scnd_int=""

#################

#functions

read_int () {
	echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a operation_history.txt
	read first_int calc_type scnd_int 
	echo $first_int $calc_type $scnd_int >> operation_history.txt

}

integer_check () {
if [[ ! $first_int =~ $re ]] || [[ ! $scnd_int =~ $re ]] || [[ -z $first_int ]] || [[ -z $scnd_int ]]; then 
	echo "Operation check failed!" | tee -a operation_history.txt
else 
#	echo "Operation check passed!"
	math 

fi
}

math () {
	result=$(bc <<< "$first_int $calc_type $scnd_int")
	echo $result | tee -a operation_history.txt
}

##########

#main
touch operation_history.txt

echo "Welcome to the basic calculator!" | tee -a operation_history.txt

read_int

while [[ $first_int != "quit" ]] 
do 
	integer_check
	read_int
done

echo "Goodbye!" | tee -a operation_history.txt