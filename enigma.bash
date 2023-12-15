#!/bin/bash

#set -euo pipefail 


#global variables
re='^[A-Z ]+$'
#re2='^[0-9]$'
re3='^[A-Z]$'
re4='^[[a-zA-Z.@]+$'

#functions
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

valid_msg () {
echo "Enter a message:"
read -r input


if [[  "$input" =~ $re ]]; then

	touch $file_name
	echo "The file was created successfully!"
	echo $input >> $file_name

else	
    echo "This is not a valid message!"
fi
}

read_file () {
	echo "Enter the filename:"
	read file_name

	if [[ ! -f $file_name ]]; then
		echo "File not found!"
	else
		$1			
	fi	
}

content () {
	echo "File content:"
	cat $file_name
}

caesar () {
cmd=$mode

if [[ $cmd == "3" ]]; then
	message=$(cat $file_name)
	echo $message | tr "[A-Z]" "[D-ZA-C]" >> $file_name.enc
	rm $file_name
	echo "Success"

elif [[ $cmd == "4" ]]; then
	message=$(cat $file_name)
	new_file=$(echo $file_name | cut -d '.' -f 1-2)
	echo $message | tr '[D-ZA-C]' '[A-Z]' >> $new_file
	rm $file_name
	echo "Success"

else
	echo "Invalid command!"
fi
}

encypt () {

echo "Enter password:"
read password
output_file=$file_name.enc
openssl enc -aes-256-cbc -e -pbkdf2 -nosalt -in "$file_name" -out "$output_file" -pass pass:"$password" &>/dev/null
exit_code=$?
#echo $exit_code
if [[ $exit_code -ne 0 ]]; then
echo "Fail"
else
echo "Success"
rm $file_name
fi


}

decrypt () {

echo "Enter password:"
read password
output_file=$(echo $file_name | cut -d '.' -f 1-2)
openssl enc -aes-256-cbc -d -pbkdf2 -nosalt -in "$file_name" -out "$output_file" -pass pass:"$password" &>/dev/null
exit_code=$?
if [[ $exit_code -ne 0 ]]; then
echo "Fail"
else
echo "Success"
rm $file_name
fi

}

#main

echo "Welcome to the Enigma!"

menu
read mode

while [ $mode != "0" ]
do

case $mode in

	"1")
	create_file
	menu
	read mode
	;;
	"2")
	read_file "content"
	menu
	read mode
	;;
	"3")
	read_file "encypt"
	menu
	read mode
	;;
	"4")
	read_file "decrypt"
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
