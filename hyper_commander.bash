#!/bin/bash

#Menu items as string variables
menu_name="Hyper Commander"
option_zero="0: Exit"
option_one="1: OS info"
option_two="2: User info"
option_three='3: File and Dir operations'
option_four="4: Find Executables"
line_begin='|'
line_end="|"

hello() {
	echo "Hello $USER!"
}

draw_line() {

	for (( i=0; i<29; i++ ))
	do
		echo -n -
	done
	echo -
}

#function generating space between menu item and end line
white_space() {
	space=' '
	n=${#1}
	x=$(( 25-$n ))

	for (( i=0; i<$x; i++ ))
	do
		echo -n "$space"
	done
#	echo $x
}

full_menu () {

draw_line
echo $line_begin $menu_name "$(white_space "$menu_name")"  $line_end
echo $line_begin $option_zero "$(white_space "$option_zero")" $line_end 
echo $line_begin $option_one "$(white_space "$option_one")" $line_end
echo $line_begin $option_two "$(white_space "$option_two")" ${line_end}
echo $line_begin $option_three "$(white_space "$option_three")"${line_end}
echo $line_begin $option_four "$(white_space "$option_four")" $line_end
draw_line

}

hello
full_menu
read input

while [ $input != "0" ]
do
	case $input in

		"0")
			echo "Farewell!"
			echo 
			;;
			
		"1")
			uname -n -o		
			full_menu
			read input
			;;
		"2")
			whoami
			full_menu
			read input
			;;
		"3" | "4")
			echo "Not implemented!"
			echo
			full_menu
			read input
			;;
		* )
			echo "Invalid option!"
			echo
			full_menu
			read input
			;;
	esac
done
echo "Farewell!"
