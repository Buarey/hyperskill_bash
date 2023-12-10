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
	echo "Enter an arithmetic operation:"
	read first_int calc_type scnd_int


}

integer_check () {
if [[ ! $first_int =~ $re ]] || [[ ! $scnd_int =~ $re ]] || [[ -z $first_int ]] || [[ -z $scnd_int ]]; then 
	echo "Operation check failed!"
else 
#	echo "Operation check passed!"
	math

fi
}

math () {
	result=$(bc <<< "$first_int $calc_type $scnd_int")
	echo $result
}

##########

#main

read_int
integer_check