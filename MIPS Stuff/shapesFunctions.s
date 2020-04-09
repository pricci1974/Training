##############################################
# Program Name: Shapes Functions
# Programmer: Peter Ricci
# Date : 3/9/2020
#############################################
# Functional Description:
# This program reads Fahrenheit as a double input and
# converts it to Celsius
#############################################
# (x2 - x1)^2 + (y2 - y1)^2 * PI area of circle
# (x2 - x1)^2 + (y2 - y1)^2 area of square
# (x2 - x1) * (y2 - y1) area of rectangle
############################################
# Cross References:
# f2 and f3: x1
# f4 and f5: y1
# f6 and f7: x2
# f8 and f9: y2
# f10 and f11: used in various calculations
# f14 and f15: used in various calculations 
# f16 and f17: used in various calculations
# f18 and f19: used in GetDistance
# f20 and f21: used in various calculations
# s0: Used as a return address in for each shape
# s1: Used as a return from GetDistance
# s2: Used as a return from GetDistance
# s3: Used as a return from GetSides 
###########################################

	.data	# Data declaration section
PI: .double 3.14159265359



Welcome: .asciiz "This program calculates the area of a circle, square and rectangle.\n"
Promptx1:  .asciiz "\nEnter the value for x1: "
Prompty1:  .asciiz "\nEnter the value for y1: "
Promptx2:  .asciiz "\nEnter the value for x2: "
Prompty2:  .asciiz "\nEnter the value for y2: "
ResultsCir: .asciiz "\nThe area of the circle is: "
ResultsSqr: .asciiz "\nThe area of the square is: "
ResultsRec: .asciiz "\nThe area of the rectangle is: "
Bye: 	.asciiz "\n ****** Have a good day ******"
	.globl	main
	.text

main:	# Start of code section
	li $v0, 4				#System call code for Print String
	la $a0, Welcome			#Load Welcome message
	syscall					#Display Welcome message
	la $a0, Promptx1		#Load Promptx1
	syscall					#Display Promptx1
	li $v0, 7				#System call code to read double
	syscall					#Read double send to $f0
	mov.d $f2, $f0			#x1
	li $v0, 4				#System call code for Print String
	la $a0, Prompty1		#Load Prompty1
	syscall					#Display Promptx1
	li $v0, 7				#System call code to read double
	syscall					#Read double send to $f0
	mov.d $f4, $f0			#y1
	li $v0, 4				#System call code for Print String
	la $a0, Promptx2		#Load Promptx2
	syscall					#Display Promptx2
	li $v0, 7				#System call code to read double
	syscall					#Read double send to $f0
	mov.d $f6, $f0			#x2
	li $v0, 4				#System call code for Print String
	la $a0, Prompty2		#Load Prompty2
	syscall					#Display Prompty2
	li $v0, 7				#System call code to read double
	syscall					#Read double send to $f0
	mov.d $f8, $f0			#y2
	jal Circle				#Jump to Circle and return
	jal Square				#Jump to Square and	return
	jal Rectangle			#Jump to Rectangle and return
	j End					#Jump to End
Circle:	#Circle functions
	la $s0, GetDistance	    #Load address of GetDistance to s0
	jalr $s1, $s0			#Jump to GetDistance, return address set to s1
	l.d $f10, PI			#Load the double value of PI to f10
	mul.d $f16, $f20, $f10	#Multiply f20 by f10 store value in f16
	li $v0, 4				#System call code for Print String
	la $a0, ResultsCir		#Load ResultsCir message
	syscall					#Display message
	mov.d $f12, $f16		#Move f16 to f12 to be printed
	li $v0, 3				#System call code for Print Double
	syscall					#Display double value stored in f12
	jr $ra					#return to the address stored in ra(main)
Square:	#Square functions
	la $s0, GetDistance	   	#Load address of GetDistance to s0
	jalr $s1, $s0			#Jump to GetDistance, return address set to s1
	li $v0, 4				#System call code for Print String
	la $a0, ResultsSqr		#Load ResultsSqr message
	syscall					#Display message
	mov.d $f12, $f20		#Move f20 to f12 to be printed
	li $v0, 3				#System call code for Print Double
	syscall					#Display double value stored in f12
	jr $ra					#return to the address stored in ra(main)
Rectangle:	#Rectangle functions
	la $s0, GetSides		#Load address of GetSides to s0
	jalr $s3, $s0			#Jump to GetSides, return address set to s3
	mul.d $f16, $f10, $f14	#Multiply f10 by f14 store results in f16
	li $v0, 4				#System call code for Print String
	la $a0, ResultsRec		#Load ResultsRec message
	syscall					#Display message
	mov.d $f12, $f16		#Move f16 to f12 to be printed
	li $v0, 3				#System call code for Print Double
	syscall					#Display double value stored in f12
	jr $ra					#return to the address stored in ra(main)
GetDistance: #Distance functions
	la $s2, GetSides		#Load address of GetSides to s2
	jalr $s3, $s2			#Jump to GetSides, return address set to s3	
	mul.d $f16, $f10, $f10	#Multiply f10 by f10 store results in f16
	mul.d $f18, $f14, $f14	#Multiply f14 by f14 store results in f16
	add.d $f20, $f16, $f18	#Add f16 and f18 store results in f20
	jr $s1					#Jump to the address stored in s1
GetSides: #Sides functions
	sub.d $f10, $f6, $f2	#x2 - x1
	sub.d $f14, $f8, $f4	#y2 - y1
	jr $s3					#Jump to the address stored in s3
	
End: # Ends program
	li $v0, 4				#System call code for Print String
	la $a0, Bye				#Load address of Bye into $a0
	syscall					#Print the string
	li	$v0, 10				#Terminate program run and
	syscall					#return control to the system
# END OF PROGRAM