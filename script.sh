#! /bin/bash
# #!  is called SHE-BANG which denotes the path of the interpretor or shell 
while true
do
printf "Welcome to user management control panel\n"
#printing the selection menu  for user management control panel 
		
	printf "1. User Addition \n"
	printf "2. Password Management\n"
	printf "3. User Modification\n"
	printf "4. User Deletion\n"
	printf "5. Exit \n"
	printf "Enter your option: \t"
#taking the selection option.	
read choice
#switch case is used for the applied options
case $choice in
'1')
	#user Addition section
	printf " ----Welcome to User Addition Section---- \n"	
	#taking the information for the user addition	
	printf " Enter your Login name  :\t" 	
	read p 
	printf " Enter full name : \t"
	read c
#shell is used for execution of command in UNIX
	printf " ---Enter your shell option---: \n"
# printing the various shell options
	printf "1. Bourne shell \n" # it is sh shell which is available in every UNIX
	printf "2. C shell \n" # syntax are based on C
	printf "3. Bash shell \n" # it is bourne again shell. 
	printf "4. tcsh\n" # it is also a cshell but with advanced features
		
	while true #it is the loop for shell option
	do
		read choice 
#taking the options for the available shell
		case $choice in
			'1')
				s="/bin/sh"
				break                      #if any of these 4 value is matched,it will come out of of the shell loop
			;;
			'2')
				s="/bin/csh"
				break
			;;
			'3')
				s="/bin/bash"
				break
			;;
			'4')
				s= "/bin/tcsh"
				break
			;;
			*)
# it is the deafault option. if user press other than 1,2,3, or 4 it will execute
				printf "Invalid choice entered \n" 
				printf "Enter 1 2 3 or 4 \n"
				continue 
		#continue is a loop control statement which is responsible for the current iteration of loop. exit from shell switch loop option and execute next commands 
			;;
		esac #switch case for shell is closed here
	done #exit from shell while loop
	printf "Enter your password: \t" $pass	
	read pass
	printf "Enter your primary group \t"
	read g
# now check group id for that user
		if id -g $g >/dev/null 2>&1; then   
# /dev/null is a special file which is used to discard the output.
# /dev/null 2>&1 is used to discard the output as well as error message.
# the command will execute but it will not shown 
# 1 is STDOUT (standard output) 2 is STDERR (standard error).
# this concept is in IO redirection of UNIX.  
			printf "Group exists- Do not need to add group \n"
		else
#if that id for the group exist, there will no need for creation of new group.
# if that id for the group does not exist, we have to create a new group. 
			groupadd $g
		fi
# as we did for the primary group we have to do same for secondary group as well	
	printf "Enter secondary group \t"
	read g1
		if id -g $g1 >/dev/null 2<&1; then    
 			printf "Group exists- Do not need to add group \n"
		else
#groupadd is the command used to create a group
			groupadd $g1
		fi		
	printf "Enter the inactivity time \t"
	read d
	printf "Enter the expiry date for the user(Date-Month-year) \t"
	read e
# After taking all the information, ask for confirmation
	printf "Please confirm [y/n] \t" $x
	read x
		if [ "$x" = "y" ]; then
		#if the user is confirmed he/she has to press y to proceed
	
			if id -u $p >/dev/null 2>&1; then     
			#it is the same concept of IO reirection of UNIX. but here the user id for the new user is checked. if that id exists

				printf "User already exists"

			$p=""
 		#if that id for new user do not exist , create a new user with applied information
	
			else
				useradd -c "$c" -s "$s" -m -d "/home/$p" -p "$pass" -g "$g" -G $g1 -f "$d" -e "$e" $p 
	
				printf "new user created with \nlogin name $p \nfull name $c \nshell \t $s \n home directory /home/$p \n password $pass \n Primary Group $g \n Secondary Group $g1 \n Inactivity time $d \n Expiry date $e \n"
			fi
# if the user is not confirmed and type anything except y , it will exit from the loop and print the main menu again and print failed
		else
			printf "Failed to create user \n"	
			continue #loop to print the main menu again 
		fi
	continue #exit from the case 1 but to execute the next commands .i.e. again want to user management option. thats why this continue is here.
	break;	# it will responsible to exit from the case 1.
;;
'2')
# it is the password management section 
# display the selection menu 
while true
do
	printf "Welcome to Password Management Section \n"
	printf " 1. to check the status of user\n"
	printf " 2. reset password \n"
	printf " 3. Modify password attributes\n"
	printf " 4. Exit \n"
# input the selected option 
	read choice
# use the switch case to execute 
	case $choice in 
	'1')
		printf "Enter the username \t"
		read p
		# status of user  passwd -S login_name
			passwd -S $p
		continue #loop the password managent loop
	;;
	'2') 
		printf "Enter the username \t"
		read p
		# Reset password .i.e. new password set
			passwd $p
		continue #loop the password management loop
	;;
	'3')	while true
		do
		printf "welcome to password attributes modification \n"
# display the options available .i.e. menu of password modification 
		printf " 1. set minimum days to change password\n"
		printf " 2. set maximum days to change password\n"
		printf " 3. warning date of password expiration\n"
		printf " 4. Inactivity condition for user\n"
		printf " 5. Exit \n"
# take the options for password modification 
			read choice
# use of nested switch case 
		case $choice in
			'1')
				printf "Enter the username \t"
				read p
				printf "Enter the number of minimum days\t"
				read n
					passwd -n "$n" $p
				continue
			;;
			'2')	printf "Enter the username \t"
				read p
				printf "Enter the number of maximum days\t"
				read x
					passwd -x "$x" $p
				continue
			;;
			'3')	printf "Enter the username \t"
				read p
				printf "Enter number of warning date\t"
				read w
					passwd -w "$w" $p
				continue
			;;
			'4')	printf "Enter the username \t"
				read p
				printf "Inactivity condition\t"
				read i
					passwd -i "$i" $p
				continue
			;;
			'5')
				# ----Exit option----
				printf "Are you sure? \n"
				printf "Please confirm [y/n]" $x
				read x
				if [ "$x" = "y" ]; then
					break  #it will exit from the password menu and comes at main menu
				else
					printf "Enter your values again\n"
			 
				fi
				continue #start the loop again
			;;
			*) #default option for password modification 
				printf "Invalid choice entered\n"
				printf "Enter 1 2 3 or 4\n"
				continue  # exit from password modification and execute next commands	
			;;
		esac # close inner switch case.i.e. loop for passwor modication 
	done
	
	;;

	'4')
		# ----Exit option----
		printf "Are you sure? \n"
		printf "Please confirm [y/n]" $x
		read x
		if [ "$x" = "y" ]; then
			break  #it will exit from the password menu and comes at main menu
		else
			printf "Enter your values again\n"
			 
		fi
	continue # exit from case 4
	;;


	*) #default option for password management 
		printf "Invalid choice entered\n"
		printf "Enter 1 2 or 3\n"
		continue  # exit from password managent and execute next commands
	;;
esac # close outer switch case .i.e. for password management 
done # close outer while loop
continue 
break #exit from the case 2
;;
'3')
# ----- user modification section ----
# read the information which needs to be modified
		printf "Welcome to user Modification Section\n"
	 	printf " Enter Login name which you want to modify  :\t" 	
		read p 
		printf " Enter your new Login name  :\t" 	
		read p1 
		printf " Enter new full name : \t"
		read c
		printf " ---Enter new your shell---: \n"
			printf "1. Bourne shell \n"
			printf "2. C shell \n"
			printf "3. Bash shell \n"
			printf "4. tcsh\n"
				while true
				do
					read choice 
#taking the options for the available shell
					case $choice in
					'1')
						s="/bin/sh"
						break
					;;
					'2')
						s="/bin/csh"
						break
					;;
					'3')
						s="/bin/bash"
						break
					
					;;
					'4')
						s= "/bin/tcsh"
						break
					;;
					*)
	# it is the deafault option. if user press other than 1,2,3, or 4 it will execute
						printf "Invalid choice entered \n" 
						printf "Enter 1 2 3 or 4 \n"
						continue 
					;;
				esac #switch case for shell is closed here
			done #end of shell while loop
	printf "Enter your password: \t" $pass	
	read pass
	printf "Enter your primary group \t"
	read g
# see user additon section for more details- io redirection 
		if id -g $g >/dev/null 2>&1; then     
			printf "Group exists- Do not need to add group"
		else
			groupadd $g
		fi
	printf "Enter secondary group \t"
	read g1
		if id -g $g1 >/dev/null 2<&1; then    
 			printf "Group exists- Do not need to add group \n"
		else
#groupadd is the command used to create a group
			groupadd $g1
		fi		
	printf "Enter new inactivity time \t"
	read f

	printf "Enter new expiry date for the user(Date-Month-year) \t"
	read e
# after reading all the information,ask for confirmation 
	printf "Please confirm [y/n] \t" $x
	read x
		if [ "$x" = "y" ]; then #starting of confirmation condition 
	
	#if user type y then modifaction will be done		
	usermod -l "$p1" -c "$c" -s "$s" -p "$pass" -g "$g" -G "$g1" -f "$f" -e "$e" $p
	#display the modified information 	
	printf " user information modified with new\n login name\t $p1 \n full name\t $c \n shell\t $s \n primary group\t $g \n secondary group $g1 \n password\t $pass \n inactivity time\t $f \n expiry date \t $e \n "
		else
#if user is not confirmed then modification will be aborted
			printf " modification can not be done \n"
		fi #end of confirmation condition 
continue
break # exit from case 3
;;
'4')
while true
do
#---- user deletion section ----
	printf "welcome to user deletion section\n"
# display selection options available in user deletion section  
	printf "1. Force removal of file \n"
	printf "2. Removal of home directory \n"
	printf "3. Exit \n"
# read the selection option 
	read choice
#use switch case to execute
	case $choice in 
		'1')
			printf "Enter login name\t"
			read p
#ask for confirmation about the force removal 
			printf "Are you sure? \n"
			printf "Please confirm [y/n]" $x
			read x
				if [ "$x" = "y" ]; then #confirmation condition started
					userdel -f $p
					printf "user successfully deleted\n"
				else
					continue 	 #if user type y then user will be deleted else it will exit
				fi	#end of confirmation condition
			continue
		;;
		'2')
			printf "Enter login name\t"
			read p
			printf "Are you sure? \n"
			printf "Please confirm [y/n]" $x
			read x
				if [ $x == "y" ]; then
					userdel -r $p
					printf "user successfully deleted\n"
				else
					continue	 
				fi
			continue
		;;
		'3')
			printf "Are you sure? \n"
			printf "Please confirm [y/n]" $x
			read x
			if [ "$x" = "y" ]; then
				break  #it will exit from the password menu and comes at main menu
			else
				printf "Enter your values again\n"
			 
			fi
			continue # exit from user deletion menu
		;;
		*) #default option for user deletion section 
			printf "Invalid choice entered\n"
			printf "Enter 1 or 2\n" 
			continue #exit from user deletion section and execute left commands
		;;
	esac # close switch case for user deletion section 
done
continue
break #exit from case 4
;;
'5')
# ----Exit option----
	printf "Are you sure? \n"
	printf "Please confirm [y/n] \t" $x
	read x
	if [ "$x" = "y" ]; then
		exit 0 
	else
		printf "Enter your values again\n"
		continue	 
	fi
	break # exit from case 5
;;
*) # default option for user management section 
	printf "Invalid choice entered\n"
	printf "Enter 1 2 3 or 4\n"
	continue #exit from this switch case and start while loop again 
;;
esac # end of outer switch case .i.e. for the main menu
done #end of while loop

