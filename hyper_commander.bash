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

file_menu() {

draw_line 68
echo "| 0 Back | 1 Delete | 2 Rename | 3 Make writable | 4 Make read-only |"
draw_line 68

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

file_operations() {

	dir_list
	file_menu
	read f_input 
	
	while [ $f_input != "0" ]
	do
	if [[ "$f_input" == "1" ]]; then
		rm  $zmienna
		echo "$zmienna has been deleted."
		break
	elif [[ "$f_input" == "2" ]]; then
		echo "Enter the new file name:"
		read new_name
		mv $zmienna $new_name
		echo "$zmienna has been renamed as $new_name"
		break
	
	elif [[ "$f_input" == "3" ]]; then
	
		chmod a=rw $zmienna
		echo "Permissions have been updated."
		ls -l $zmienna
		break
	
	elif [[ "$f_input" == "4" ]]; then
		chmod o=r $zmienna
		echo "Permissions have been updated."
		ls -l $zmienna
		break
	else
		file_menu 
		read f_input
	fi
	done
}

selector_check() {
change_dir="up"

arr=(*)
	for x in "${arr[@]}"; do
		if [[ $selector == "$x" ]]; then
			zmienna=$x
		fi
	done

if [[ "$selector" == "$zmienna" ]]; then
	if [[ -f "$zmienna" ]]; then
	
	#tutaj czesc kodu trzeba zrobiÄ‡
		file_operations
	
	elif [[ -d "$zmienna" ]]; then
		cd "$selector"
	fi	
	dir_list
	menu_three
	echo 
	read selector
elif [[ "$selector" == "$change_dir" ]]; then
	cd ..
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

exec_op() {
	
	echo "Enter an executable name:"
	read exec_name
	which_out=$(which "$exec_name")
		
	if [ -n "$which_out" ]; then
		echo "Located in: $which_out"
		echo
		echo "Enter arguments: "
		read args
		$exec_name $args
	else 
		echo "The executable with that name does not exist!"
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
		
			#implementacja wyszukiwania exec—w
			exec_op
#			echo "Not implemented!"
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
