##############################################
# Program Name: Carry
# Programmer: Peter Ricci
# Date 2/24/2020
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
###########################################

	.data	# Data declaration section

Welcome: .asciiz	"\n This program adds two integers.
				 \n To quit enter 0 for the first integer. 
                 \n Enter the first integer and press enter:"
				 
Welcome2: .asciiz	"\n Enter the second integer and press enter:"
Result: .asciiz "\n The number of carries were:"
Result2: .asciiz "\n The answer is:"				 

PI:	.double 3.14
Bye: 	.asciiz "\n ****** Have a good day ******"
	.globl	main
	.text
 
main:	
    
#	addiu $sp, $sp, -4	
	li $t0, 10000000
#	li $t5, 9876542
#	sw $t0, ($sp)
#	sw $t5, 4($sp)
#	sw $t0, 8($sp)
#	sw $t5, 12($sp)
#	sw $t0, 16($sp)
	lb $s0, 3($t0)
	lb $t1, 0($sp)
	lb $t2, 1($sp)
	lb $t3, 2($sp)
	lb $t4, 3($sp)
#End of the program 
End:
	li	$v0, 4		#System call code for Print String
	la	$a0, Bye	#load addrss of msg into $a0
	syscall			#print the string
	li	$v0, 10		#terminate program run and
	syscall			#return control to the system
# END OF PROGRAM