#!/bin/bash
#global variables
re='^[A-Z ]+$'
re2='^[0-9]$'
re3='^[A-Z]$'
re4='^[[a-zA-Z.@]+$'

#functions
valid_msg () {
echo "Enter a message:"
read -r input


if [[  "$input" =~ $re ]]; then

	touch $file_name
	echo "The file was created successfully!"
	echo $input >> $file_name

else	
    echo "This is not a valid message!"
 #	break
 #   menu
 #   read mode
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

caesar () {
echo "Type 'e' to encrypt, 'd' to decrypt a message:"
echo "Enter a command:"
read cmd

if [[ $cmd == "e" ]]; then
	valid_msg
	echo "Encrypted message:"
	echo $input | tr "[A-Z]" "[D-ZA-C]"

elif [[ $cmd == "d" ]]; then
	valid_msg
	echo "Decrypted message:"
	echo $input | tr '[D-ZA-C]' '[A-Z]'

else
	echo "Invalid command!"
fi

}

menu () {
echo "0. Exit"
echo "1. Create a file"
echo "2. Read a file"
echo "3. Encrypt a file"
echo "4. Decrypt a file"
echo "Enter an option:"
}

create_file () {
	echo "Enter the filename:"
	read file_name

	if [[ ! $file_name =~ $re4 ]]; then
		echo "File name can contain letters and dots only!"

	else
		valid_msg
		
	fi	
} 

read_file () {
	echo "Enter the filename:"
	read file_name

	if [[ ! -f $file_name ]]; then
		echo "File not found!"

	else
		echo "File content:"
		cat $file_name
		
	fi	



}

#main

echo "Welcome to the Enigma!"

menu
read mode

while [[ $mode != "0" ]]

do

case $mode in

	1)
	create_file
	menu
	read mode
	;;
	2)
	read_file
	menu
	read mode
	;;
	3)
	echo "Not implemented!"
	menu
	read mode
	;;
	4)
	echo "Not implemented!"
	menu
	read mode
	;;
	*)
	echo "Invalid option!"
	menu
	read mode
	;;
esac

done

echo "See you later!"
