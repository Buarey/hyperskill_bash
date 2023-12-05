#!/bin/bash

converter () {
echo "Enter a definition:"
read string float

re='^[a-z]+_to_[a-z]+ -?[0-9]+\.?[0-9]*?$'
full_input="$string $float"
#echo $full_input

if [[ "$full_input" =~ $re ]]; then
#	echo "The definition is correct!"
	echo "Enter a value to convert:"
	read conv_value
	re2='^[-+]?[0-9]+\.?[0-9]*$'	

while [[ ! "$conv_value" =~ $re2 ]]	
	do
		if [[ ! "$conv_value" =~ $re2 ]]; then
			echo "Enter a float or integer value!"
			read conv_value	
		fi
	done
	
	result=$(bc <<< "$float * $conv_value")
	echo "Result: $result"

else
    echo "The definition is incorrect!"
fi

}

menu () {

	echo "Select an option"
	echo "0. Type '0' or 'quit' to end program"
	echo "1. Convert units"
	echo "2. Add a definition"
	echo "3. Delete a definition"

}

#main
echo "Welcome to the Simple converter!"
echo
menu
read input
zero="0"
quit="quit"


while [[ $input != $zero || $input != $quit ]]
	do 
case $input in

		"1" | "2" | "3")
		echo "Not implemented"
		menu
		read input
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
