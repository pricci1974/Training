##############################################
# Program Name: Shapes
# Programmer: Peter Ricci
# Date 2/10/2020
#############################################
# Functional Description:
# A program to calculate the area of a circle, square or rectangle.
# read in from the keyboard as x,y coordinates as follows:
# x1, x2, x3, x4
#############################################
# Algorithm will come later
############################################
# Cross References:
# s0: x1,
# s1: y1,
# s2: x2,
# s3: y2,
# s4: (x2 - x1)^2
# s5: (y2 - y1)^2
# s6: 100000
# s7: 314156
###########################################

	.data	# Data declaration section

Menu: .asciiz	"\n Please choose from the following:
				 \n To quit enter 0 
                 \n To calculate the area of a circle enter 1
				 \n To calculate the area of a square enter 2
				 \n To calculate the area of a rectangle enter 3\n"
Promptx1:  .asciiz "\nEnter the value for x1: "
Prompty1:  .asciiz "\nEnter the value for y1: "
Promptx2:  .asciiz "\nEnter the value for x2: "
Prompty2:  .asciiz "\nEnter the value for y2: "
ResultCir: .asciiz "\nThe area of the circle is: "
ResultSqr: .asciiz "\nThe area of the square is: "
ResultRec: .asciiz "\nThe area of the rectangle is: "

Bye: 	.asciiz "\n ****** Have a good day ******"
	.globl	main
	.text

main:		# Start of code section
menu:	li  $v0, 4 #system call to print string
	la  $a0, Menu # load address of Menu to $a0
	syscall    # Display the menu

	li	$v0, 5		#system call code for Read Integer
	syscall			#reads the value of menu choice into $v0
	move $t9, $v0    # moves the value to $t9
	blez	$t9, End 	#branch to end if $v0 <= 0 otherwise continue
	
	li  $v0, 4 #system call to print string
	la  $a0, Promptx1 # load address of Menu to $a0
	syscall      # display the prompt
	li	$v0, 5		#system call code for Read Integer
	syscall			#reads the value of x1
	move $s0, $v0   #moves the value from $v0 to $s0
	
	li  $v0, 4 #system call to print string
	la  $a0, Prompty1 # load address of Menu to $a0
	syscall      # display the prompt
	li	$v0, 5		#system call code for Read Integer
	syscall			#reads the value of y1
	move $s1, $v0   #moves the value from $v0 to $s1
	
	li  $v0, 4 #system call to print string
	la  $a0, Promptx2 # load address of Menu to $a0
	syscall      # display the prompt
	li	$v0, 5		#system call code for Read Integer
	syscall			#reads the value of x2
	move $s2, $v0   #moves the value from $v0 to $s2
	
	li  $v0, 4 #system call to print string
	la  $a0, Prompty2 # load address of Menu to $a0
	syscall      # display the prompt
	li	$v0, 5		#system call code for Read Integer
	syscall			#reads the value of y2
	move $s3, $v0   #moves the value from $v0 to $s3
	
	li  $s7, 314156 # Load PI to $s7
	li  $s6, 100000 # Load 100000 to $s6 for calculating final answer with PI
	
	addi $t8, $t9, -2  #add -2 to $t9, results to $t8 to be used for ease of branching.
	bgtz $t8, rectangle # branch to rectangle if greater than 0
	beqz $t8, square    # branch to square if equal to 0
	bltz $t8, circle    # branch to circle if greater than 0
	
	
	
circle:	#Circle loop
    sub $t0, $s2, $s0  #x2 - x1
    sub $t1, $s3, $s1  #y2 - y1
    mult $t0, $t0 #(x2 - x1) squared
    mflo $s4 #(x2 - x1) squared moved to $s4
    mult $t1, $t1 #(y2 - y1) squared
    mflo $s5 #(y2 - y1) squared moved to $s5
    add  $t0, $s4, $s5 #(x2 - x1) squared +  (y2 - y1) squared
	mult $t0, $s7  # (x2 - x1) squared +  (y2 - y1) squared  * 314156
	mflo $t3 # move results from LO to $t3
	div $t3, $s6  # divide results by 100000 for final answer
	mflo $t3 # move results from LO to $t3
	li $v0, 4 #system call to print string
	la $a0, ResultCir #load address of resultCir to $a0
	syscall #Display ResultCir
	li $v0, 1 # System call to print integer
	move $a0, $t3 #move answer to be printed to $a0
    syscall	#Display the area of the circle
	b  menu  # branch to main
	
square:	#Square
	mult $s4, $s5 #multiply (x2 - x1)^2 * (y2 - y1)^2
	mflo $t0 # move results from LO to $t0
	li $v0, 4 #system call to print string
	la $a0, ResultSqr #load address of ResultSqr to $a0
	syscall  # Display ResultSqr
	add $t0, $s4, $s5 #Add (x2 - x1)^2 + (y2 - y1)^2
	li $v0, 1 # System call to print integer
	move $a0, $t0 #move answer to be printed to $a0
	syscall   #Display the area of the square
	b menu
    
rectangle:	#Rectangle
	sub $t0, $s2, $s0  #x2 - x1
    sub $t1, $s3, $s1  #y2 - y1
	mult $t0, $t1
	mflo $t3
	li $v0, 4 #system call to print string
	la $a0, ResultRec #load address of ResultRec to $a0
	syscall
	li $v0, 1 # System call to print integer
	move $a0, $t3 #move answer to be printed to $a0
	syscall   #Display the area of the rectangle
	b menu
    	
End:	li	$v0, 4		#System call code for Print String
	la	$a0, Bye	#load addrss of msg into $a0
	syscall			#print the string
	li	$v0, 10		#terminate program run and
	syscall			#return control to the system
# END OF PROGRAM