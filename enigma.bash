#!/bin/bash
#global variables
re='^[A-Z ]+$'
re2='^[0-9]$'
re3='^[A-Z]$'

#functions
valid_msg () {
echo "Enter a message:"
read -r input


if [[ "$input" =~ $re ]]; then
    echo "This is a valid message!"
else
    echo "This is not a valid message!"
fi

}

ascii_conv () {

echo "Enter an uppercase letter:"
read -r letter
echo "Enter a key:"
read -r key


if [[ "$letter" =~ $re3 ]] && [[ $key =~ $re2 ]]; then
    
	
	value=$(printf "%d\n" "'$letter")
	encoded_letter=$(( $value + $key ))
	
	if [[ $encoded_letter -gt 90 ]]; then 
		reverse=$(( $encoded_letter - 26 ))
		char=$(printf "%b\n" "$(printf "\\%03o" "$reverse")")
	else	
		char=$(printf "%b\n" "$(printf "\\%03o" "$encoded_letter")")
	fi
	
	echo "Encrypted letter: $char"
else
    echo "Invalid key or letter!"
fi



}

#main

#valid_msg

ascii_conv
