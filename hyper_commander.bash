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
	for (( i=0; i<$1; i++ ))
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

draw_line 29
echo $line_begin $menu_name "$(white_space "$menu_name")"  $line_end
echo $line_begin $option_zero "$(white_space "$option_zero")" $line_end 
echo $line_begin $option_one "$(white_space "$option_one")" $line_end
echo $line_begin $option_two "$(white_space "$option_two")" ${line_end}
echo $line_begin $option_three "$(white_space "$option_three")"${line_end}
echo $line_begin $option_four "$(white_space "$option_four")" $line_end
draw_line 29

}

menu_three() {

draw_line 50
echo "| 0 Main menu | 'up' To parent | 'name' To select |"
draw_line 50

}

dir_list() {
	
	echo
	echo "The list of files and directories:"
	
	arr=(*)
	for item in "${arr[@]}"; do
  		if [[ -f "$item" ]]; then
    		echo "F $item"
 		 elif [[ -d "$item" ]]; then
    	echo "D $item"
  		fi
	done
	echo
}

selector_check() {
			arr=(*)
			for x in "${arr[@]}"; do
					if [[ $selector == "$x" ]]; then
			 			zmienna=$1
					fi
			done

			if [[ $selector == "$zmienna" ]]; then
				
			 			echo "Not implemented!"
						dir_list
						menu_three
						echo 
						read selector
			elif [[ $selector == "up" ]]; then
						echo "Not implemented!"
						dir_list
						menu_three
						echo
						read selector
			else
						echo "Invalid input!"
						dir_list
						menu_three
						echo
						read selector
			fi

}



#main 

hello
full_menu
read input

while [ $input != "0" ]
do
	case $input in

		"0")
			echo "Farewell!"#
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
		"3")
			dir_list
			menu_three			
			read selector
			while [ $selector != "0" ]
			do
				selector_check $selector
			done
			full_menu
			read input
			;;	
		"4")
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
