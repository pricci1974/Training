##############################################
# Program Name: Carry
# Programmer: Peter Ricci
# Date 2/28/2020
#############################################
# Functional Description:
# A program that adds two integers and
# counts the number of times a 1 is carried during
# the addition (If the addition was done on paper)
#############################################
# Algorithm will come later
############################################
# Cross References:
# $s0 the number 10 used for splitting integer
# $s1 flag used to stop dividing the first integer
# $s2 flag used to stop dividing the first integer
# $s3 flag used to indicate whether or not a carry occurred
# $s4 used to store the sum of integer one and two
# $t0 used for the menu choices, to store the first integer and its quotient
# $t1 used to store the second integer and its quotient
# $t2 used to store the mod of the first integer and for calculating the sum
# $t3 used to store the mod of the second integer and as a control for multiply loop
# $t5 used to count cycles
# $t7 used to add 1st and 2nd quotients to check for division completion
# $t8 used in calulating whether or not a carry occurred during addition	
# $t9 tracks the number of carries
###########################################

	.data	# Data declaration section

Welcome: .asciiz	"This program adds two integers, gives the sum, and counts the number of carries.\n
Written by Peter Ricci\n
Version February 2020\n"

Welcome1: .asciiz    "\nEnter the first integer and press enter
(To quit press 0 then enter):"
 
Welcome2: .asciiz	"Enter the second integer and press enter:"
Result: .asciiz "\nThe number of carries were:"
Result2: .asciiz "The answer is:"	
TryAgain: .asciiz "\n\nDan, would you like to run the program again?
\nEnter 1 for yes or 0 for no: "


Bye: 	.asciiz "\n ****** Have a good day ******"
	.globl	main
	.text
 
main:	# Start of code section
	li $v0, 4				    # System call to print string
	la $a0, Welcome				# Load address of Welcome to $a0
	syscall   					# Display the string
menu:	# Starting point for multiple runs of the program 
	li $v0, 4				    # System call to print string
	la $a0, Welcome1			# Load address of Welcome1 to $a0
	syscall   					# Display the string
	li $v0, 5					# System call code for Read Integer
	syscall						# Reads the value of menu choice/first integer into $v0
	move $t0, $v0   			# Moves the value to $t0
	beqz $t0, End 				# Branch to end if $t0 = 0 otherwise continue
	li $s0, 10 					# Stores 10 in $s0 for splitting numbers
	li $s1, -1 					# Used as a finish indicator for first integer division
	li $s2, -1 					# Used as a finish indicator for second integer division
	li $s3, -1 					# Used as a indicator for carrying over the 1
	li $s4, 0                   # $s4 set to 0, important for multiple program runs
	li $t9, 0					# $t9 set to 0, important for multiple program runs
	li $t5, 0					# Set cycle counter to 0
	li $v0, 4 					# System call to print string
	la $a0, Welcome2 			# Load address of Welcome2 to $a0
	syscall    				  	# Display the string
	li $v0, 5					# System call code for Read Integer
	syscall						# Reads the value of $v0
	move $t1, $v0  				# Moves the value from $v0 to $t1
SplitNumbers: # Primary loop to split the numbers and do the math
	addiu $t5, 1				# Increment cycle counter
Divide1:	# Divide up the first integer                                                 
	beqz $s1, Divide2  			# Checks flag $s1 
    div $t0, $s0 				# Divide 1st integer                    
	mfhi $t2 					# Move mod to $t2                          
	mflo $t0 					# Move quotient to $t0                     
	beqz $t0, DoneWith1 		# Once quotient is 0, branch to DoneWith1                                
Divide2:	# Divide up the second integer                        
	beqz $s2, KeepSplitting 	# Checks flag $s2 
 	div $t1, $s0 				# Divide 2nd integer                    
	mfhi $t3 					# Move mod to $t3                          
	mflo $t1 					# Move quotient to $t1                          
	beqz $t1, DoneWith2 		# Once quotient is 0, branch to DoneWith2
KeepSplitting:	# Point to return to counting after division is finished
	add $t8, $t2, $t3  			# Add the digits $t2 and $t3
	move $t2, $t8				# Move the sum to $t2
	move $t3, $t5               # Move value from $t5 to $t3
	addi $t3, $t5, -1			# Subtract 1 from counter, used to control multiplication loop
	beqz $t3 SkipMultiplyer		# Branch skips the multiply loop on first run. Basically an if statement.
								# no need to multiply first digit of sum.
Multiplyer:	# This loop multiplies a digit by 10, n number of times based on the position of the digit
    mult $t2, $s0				# Multipies $t2 by $s0
	mflo $t2					# Results moved from LO to $t2
	addiu $t3, -1				# Decrement counter of loop, control # of times to multiply digit by 10
	bgtz $t3, Multiplyer		# Branch to continue multiplying digit
SkipMultiplyer:	# Essentially an else part of if statement. Allows program to bypass multiplyer
	add $s4, $s4, $t2			# Increments $s4 by $t2
	beqz $s3, PreviousCarry		# Check carry flag branch if $s3 = 0
ContinueSplit:	# Used as part of counting number of carries without affecting division and multiplication	
	addi $t8, -10  				# Take the sum and subtract 10
	bgez $t8, CounterUp 		# Go to CounterUp if $t8 - 10 is > 0 indicating a carry has occurred
	add $t7, $t0, $t1 			# Adds both quotients	
	li $t2, 0  					# Resets $t2 to 0
	li $t3, 0  					# Resets $t3 to 0
	bgtz $t7, SplitNumbers  	# Continue in the loop until $t7 = 0. Which is when both integers 
								# have been completely divided up
	b Results					# Branch to Results.
CounterUp:	# This loop increments number of carries						
	addi $t9, $t9, 1  			# Increment $t9 by 1
	li $s3, 0  					# Trigger the carry over flag 
	b ContinueSplit 			# Continue splitting the numbers	
DoneWith1:	# This loop triggers flag to stop dividing the 1st integer when it reaches 0
    addi $s1, $s1, 1 			# Increments flag $s1 to 0
    b Divide2 					# Branch to Divide2
DoneWith2:	# This loop triggers flag to stop dividing the 2nd integer when it reaches 0
    addi $s2, $s2, 1 			# Increments counter $s2 to 0
    b KeepSplitting				# Returns to beginning of math portion
PreviousCarry:	# This loop adds one to a digit to account for carrying a one in addition
	addi $t8, 1					# Adds 1 to $t8
	addi $s3, 1 				# Reset previous carry flag to 0
	b ContinueSplit				# Branch to ContinueSplit
Results:	# This loop displayes the results
	li $v0, 4					# System call to print string
	la $a0, Result2				# Load address of Result2 to $a0
	syscall						# Prints the string
	li $v0, 1					# System call to print integer
	move $a0, $s4				# Moves #s4 to $a0
	syscall						# Prints the integer
	li $v0, 4 					# System call to print string
	la $a0, Result				# Load address of Result to $a0
	syscall						# Prints the string
	li $v0, 1					# System call to print integer
	move $a0, $t9				# Moves $t9 to $a0
	syscall						# Prints the integer
	li $v0, 4					# System call to print string
	la $a0, TryAgain			# Load address of TryAgain to $a0
	syscall						# Prints the string
	li	$v0, 5					# System call code for Read Integer
	syscall						# Reads the value of menu choice
	move $t0, $v0				# Moves $v0 to $t0
	bgtz $t0, menu				# Branch to menu to continues to end of program
End:	# Ending loop
	li	$v0, 4					# System call code for Print String
	la	$a0, Bye				# Load addrss of Bye into $a0
	syscall						# Print the string
	li	$v0, 10					# Terminate program run and
	syscall						# return control to the system
# END OF PROGRAM