# HW1_2 Program Description: Translate the following C code to MIPS. 
# Assume that i is in $a0, k is in $a1, the base address of A is in $s6. 
# Author: Ivan Zelenkov
# Creation Date: 02/24/2022

# public int quizFunc(int i, int k) {
# 	while(A[i] >= k) {
# 		i = i - 1;
# 	}
# 	return i;
# }

quizFunc:
	Loop: sll $t1, $a0, 2		# Temporary reg $t1 = i * 4 
		  add $t1, $t1, $s6		# $t1 = address of A[i]
		  lw  $t0, 0($t1)		# Temporary reg $t0 = A[i]
		  
		  blt $t0, $a1, Exit	# If A[i] < k, then jump to Exit
		  
		  subi $a0, $a0, 1		# i = i - 1
		  
		  j Loop				# go to Loop
		  
	Exit:
		add $v0, $a0, $zero			# initialize a return value register $v0 by value of i
		jr $ra						# return to the caller