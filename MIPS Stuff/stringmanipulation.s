################################################################
# Program Name: String Manipulation
# Programmer: Peter Ricci
# Date 3/28/2020
################################################################
# Functional Description:
# This program takes two values and prints out the sets of bits,
# determines if an element is a member of a given set,
# determines the union and intersection of two sets.
################################################################
# Algorithm will come later
################################################################
# Cross References:
# $t0	Maximum number for loops
# $t1	Number used as a "mask" for operations
# $t2   Index number used to point to the bit number
# $t3	Used to store user input of test element
# $t4   Used in and/or operations
# $t5   Register to hold either $s1 or $s1 for testing
# $t6	Used as a flag for determining which set to test
# $t7	Used to check user input 
# $s1	Test set 1
# $s2	Test set 2	
# $s4	Used to store return address of main part of program
# #s5	Used to store call addresses
# $a1   Used as an argument for moving the bit in the "mask"
################################################################

	.data	# Data declaration section

Welcome: 	 .asciiz	"\n This program demontrates bit string
				 \n manipulation, logical operators, and functions.\n"
Space:		 .asciiz  " " 	
Set1:		 .asciiz "\nThese are the elements of set 1: "
Set2:		 .asciiz "\nThese are the elements of set 2: "
EnterNum:    .asciiz "\n\nEnter an integer between 1 and 32 to see if it is in one of the sets: "
Yes1:     	 .asciiz "Is an element of set 1.\n"
No1:     	 .asciiz  "Is not an element of set 1.\n"
Yes2:    	 .asciiz "Is an element of set 2.\n"
No2:    	 .asciiz  "Is not an element of set 2.\n"
Yes:		 .asciiz "Is an element of set "
No:          .asciiz "Is not an element of set "
Union:		 .asciiz "\nThis is the union of both sets:\n"		
Intersection:.asciiz "\n\nThis is the intersection of both sets:\n"	 
TryAgain:    .asciiz "\n\nWould you like to run the program again?(1-yes or 0-no)"
WrongInput:	 .asciiz "\nNumber out of range. Must be between 1 and 32!"	
Bye: 		 .asciiz "\n ****** Have a good day ******"


	.globl	main
	.text

main:	
	li $t7, -32					#Load -32 to $t7
	li $t0, 33 					#Loop max    
	li $s1, 0x24924924	 		#Test number 1
	li $s2, 0xaaaaaaaa   		#Test number 2
	la $a0, Welcome				#Load Welcome message
	jal PrintWords				#Call to print messages and return
# This section calculates and prints set 1	
	la $a0, Set1				#Load Set1 message
	jal PrintWords				#Call to print messages and return
	jal Reset					#Call to reset inportant registers and return
	move $t5, $s1				#Move Test number 1 to $t5
	la $s5, CalculateSet		#Load address of CalculateSet1
	jalr $s4, $s5   			#Jump to $s5, perform functions and return
# This section calculates and prints set 2
	la $a0, Set2				#Load Set2 message
	jal PrintWords				#Call to print messages and return
	move $t5, $s2				#Move Test number 2 to $t5
	jalr $s4, $s5 		    	#Jump to $s5, perform functions and return
#This section reads user input, checks it for proper range, then determines 
#if the element is part of the sets	
	la $a0, EnterNum			#Load EnterNum message
	jal PrintWords				#Call to print messages and return
	li $v0, 5					#System call code to read integer
	syscall						#Read integer
	blez $v0, Wrong				#Branch to Wrong if user input is < 1
	add $t7, $t7, $v0 			#Add user input to -32 store in $t7
	bgtz $t7, Wrong				#Branch to Wrong if user input was > 32
	move $t3, $v0				#Move user input to $t3
	move $t5, $s1				#Move Test number 1 to $t5
	li $t6, 1					#Set $t6 to 1 to denote testing set 1
	la $s5, InSet				#Load address of InSet
	jalr $s4, $s5 				#Jump to $s5, perform functions and return
	jal Reset					#Call to reset inportant registers and return
	move $t5, $s2				#Move Test number 2 to $t5
	li $t6, 0					#Set $t6 to 0 to denote testing set 2
	jalr $s4, $s5   			#Jump to $s5, perform functions and return
	jal Reset					#Call to reset inportant registers and return
#This section calulates and prints the union of both sets	
	la $a0, Union				#Load Union message
	jal PrintWords				#Call to print messages and return
	la $s5, UnionOfSets			#Load address of UnionOfSets
	jalr $s4, $s5  				#Jump to $s5, perform functions and return
	jal Reset					#Call to reset inportant registers and return
#This section calulates and prints the intersection of both sets	
	la $a0, Intersection		#Load Intersection message
	jal PrintWords				#Call to print messages and return
	la $s5, IntersectOfSets		#Load address of IntersectOfSets
	jalr $s4, $s5   	   		#Jump to $s5, perform functions and return
#This section reloads the program or terminates it.	
	la $a0, TryAgain			#Load TryAgain message
	jal PrintWords				#Call to print messages and return
	li $v0, 5					#System call code to read integer
	syscall						#Read integer
	bnez $v0, main				#Branch to main if user entered 0 otherwise continue
	j End						#jump to End

	


#Function to determine elements of set 
CalculateSet:
	and $v1, $t1, $t5 			#And the mask with set1
	move $a0, $t2 				#Move the value of $t2 to $a0
	jal Print					#Call to print the integer 
	addi $t2, 1					#Increase Loop Counter
	sll $t1, $t1, 1				#SLL mask
	bne $t0, $t2 CalculateSet	#Continue in loop until $t2 equals $t0 
	jal Reset					#Call to reset inportant registers and return
	j $s4						#Return to main function

#Function to determine whether or not integer is in a set 
InSet:
	move $t2, $t3				#Set index to user input
	addi $a1, $t3, -1  			#Set $a1 to 1 less than user input.
	sll $t1, $t1, $a1			#SLL mask based on calibrated user input
	and $t7, $t1, $t5 			#And the mask with set 
	addi $v1, 1					#Add 1 to $v1 to bypass skip print feature
	move $a0, $t3				#move user input to $a0
	jal Print					#Call to print the user input value
	beqz $t7 NotInSet			#Branch to NotIn1 if and returns 0
	beqz $t6, SecondYes			#Branch to load Yes2 message
	la $a0, Yes1				#Load Yes1 message
	b PrintYes					#Branch to print yes message
SecondYes:						#Point to load and print Yes2
	la $a0, Yes2				#Load Yes1 message
PrintYes:						#Point to print yes message
	jal PrintWords				#Call to print messages and return
	j $s4						#Return to main function
NotInSet:						#Part of function dealing with # not in set
	beqz $t6, SecondNo			#Branch to SecondNo if element is not in set 2	
	la $a0, No1					#Load No1 message
	b PrintNo					#Branch to print no message
SecondNo:						#Point to load and print 2nd no message
	la $a0, No2					#Load No2 message
PrintNo:						#Point to print no messages
	jal PrintWords				#Call to print messages and return
	j $s4						#Return to main function	
	
	
#Function to reset Loop index and mask	
Reset:
	li $t2, 1					#Loop index set to 1
	li $t1, 0x00000001  		#The mask set to 0x00000001
	jr $ra						#Return to main function
	
#Function to determine the union	
UnionOfSets:
	and $v1, $t1, $s1 			#And the mask with set1
	and $t4, $t1, $s2 			#And the mask with set2
	or $v1, $v1, $t4			#Or the results
	move $a0, $t2 				#Move Loop index to $a0
	addi $t2, 1					#Increase Loop Counter
	sll $t1, $t1, 1				#SLL mask
	jal Print					#Call to print integer function
	bne $t0, $t2 UnionOfSets	#Continue in loop until $t2 equals $t0
	j $s4						#Return to main function

#Function to determine intersection of sets	
IntersectOfSets:
	and $v1, $t1, $s1 			#And the mask with set1
	and $t4, $t1, $s2 			#And the mask with set2
	and $v1, $v1, $t4			#And the results
	move $a0, $t2 				#Move Loop index to $a0
	addi $t2, 1					#Increase Loop Counter
	sll $t1, $t1, 1				#SLL mask
	jal Print					#Call to print integer function
	bne $t0, $t2 IntersectOfSets#Continue in loop until $t2 equals $t0
	j $s4						#Return to main function
	
# Function to print messages
PrintWords:
	li $v0, 4					#System call code to print String
	syscall						#Print String
	jr $ra						#jump to return address

# Function to print integers with a space after each	
Print:
	beqz $v1 SkipPrint			#branch to skip print if $v1 is 0
	li $v0, 1					#System call code to print integer
	syscall						#Print integer	
	li $v0, 4					#System call code to print String
	la $a0, Space				#Load address of Space
	syscall						#Print String (space)
SkipPrint:						#Part os Print function to avoid printing in loop
	jr $ra						#jump to return address	

# Function to alert user to improper input then continues on and ends the program
Wrong:
	la $a0, WrongInput			#Loads WrongInput message
	jal PrintWords				#Call to print messages and return
	
#End of the program 
End:
	la	$a0, Bye				#load addrss of msg into $a0
	jal PrintWords				#Call to print Bye message
	li	$v0, 10					#terminate program run and
	syscall						#return control to the system
	