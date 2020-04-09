#
# DESCRIPTION:	Demonstrates the use of loading (lb)
#				and storing bytes (sb).
#
#
		.data
		
msg0:	.asciiz			"Demo Program: Loading and Storing Bytes\n\n"
nt:		.asciiz			"\n\nNormal Termination\n"
ar1:	.word 	he, how, out, oh
		.globl main
		.text

main:
		li		$v0, 4
		la		$a0, msg0
		syscall

		##################### Program Here ###################
		
		la      $s5, ar1
		li		$s0, 0x10010000
		li		$t6, 20
		
		lb		$t0, 0x00($s0)	# Loading a byte from Mem to Reg
		lb		$t1, 0x01($s0)
		lb		$t2, 0x02($s0)
		lb		$t3, 3($s0)

		li		$s1, 0x10010040
		
		li 		$v0, 4
		move    $a0, $s5
		syscall
		
Loop:					# Demo to loop through memory
		
		sw		$t1, ($s1)		# Store words. Words are 4bytes or 32 bits
		addi	$t6, -1			# loop count down variable
		addiu 	$s1, 4			# Since s1 is a memory location, adds 4 to it
		bgez 	$t6, Loop		# continue to loop until t6 < 0.
		

		sb		$t0, 0($s1)		# Storing a byte from Reg to Mem
		sb		$t1, 1($s1)
		sb		$t2, 2($s1)
		sb      $t3, 3($s1)

		######################################################
		

		li		$v0, 4
		la		$a0, nt
		syscall
		
		li		$v0, 10
		syscall	