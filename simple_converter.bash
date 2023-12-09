#!/bin/bash

#global variables
file_name="definitions.txt"
#

converter () {

if [ $1 == "1" ]; then
	def_check "math" "convert units"
	menu
	read input
elif [ $1 == "2" ]; then 
	def_valid
	menu
	read input
elif [ $1 == "3" ]; then
	def_check "delete" "delete"
	menu
	read input	
fi
}

def_valid () {
	
	
	
	echo "Enter a definition:"
	read string float

	re='^[a-z]+_to_[a-z]+ -?[0-9]+\.?[0-9]*?$'
	full_input="$string $float"

	while [[ ! "$full_input" =~ $re ]]
	
	do

	if [[ ! "$full_input" =~ $re ]]; then
		
		echo "The definition is incorrect!"
		echo "Enter a definition:"
		read string float
		full_input="$string $float"

	fi
	
	done
	
		add_def

}

add_def () {
	
	echo "$full_input" >> "$file_name"
}

delete () {
	read del_line
		
	while [[ $del_line != "0" ]]
	do
		
		if [[ $del_line -gt $line_number ]] || [[ -z $del_line ]]; then
			echo "Enter a valid line number!"
			read del_line
		else
			sed -i "${del_line}d" "$file_name"
			break
		fi	
	done
}

def_check () {

operation=$1
target=$2

file_weight=$(wc -c $file_name | cut -d " " -f 1)
line_number=$(wc -l $file_name | cut -d " " -f 1)

	if [[ $file_weight == "0" ]]; then
			echo "Please add a definition first!"
		else
		
		echo "Type the line number to $target or '0' to return"

			#LIST CONTENTS OF FILE	
			nl -w1 -s'. ' $file_name

			$operation
		fi
}

math () {
re2='^[-+]?[0-9]+\.?[0-9]*$'

read line
		
while [[ $line != "0" ]]
	do
		
		if [[ $line -gt $line_number ]] || [[ -z $line ]] || [[ ! $line =~ $re2 ]]; then
			echo "Enter a valid line number!"
			read line
		else
			to_conv=$(sed "${line}!d" "$file_name" | cut -d " " -f 2) 
			
			echo "Enter a value to convert:"
			read conv_value
			
			while [[ ! "$conv_value" =~ $re2 ]]	
				do
					if [[ ! "$conv_value" =~ $re2 ]]; then
						echo "Enter a float or integer value!"
					read conv_value	
					fi
				done
			result=$(bc <<< "$to_conv * $conv_value")
			echo "Result: $result"
			break
		fi	
done
}

menu () {

	echo "Select an option"
	echo "0. Type '0' or 'quit' to end program"
	echo "1. Convert units"
	echo "2. Add a definition"
	echo "3. Delete a definition"
}

#main
touch $file_name
echo "Welcome to the Simple converter!"
echo
menu
read input
zero="0"
quit="quit"


while [[ $input != $zero || $input != $quit ]]
	do 
case $input in

		"1")

		converter $input

		;;
		"2") 
		
		converter $input
		
		;;
		"3")
		
		converter $input
		
		;;
		"0" | "quit")
		echo "Goodbye!"
		break
		;;
		
		*)
		
		echo "Invalid option!"
		menu
		read input
		
esac

	done
