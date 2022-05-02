# HW1_1 Program Description: Translate the following C code to MIPS. 
# Assume that i is in $s1, j is in $s2, the base address of A is in $s6 and B is in $s7. 
# Author: Ivan Zelenkov
# Creation Date: 02/24/2022

# if (i < 10) {
# 	 B[i] = A[3] + j;
# 	 i = i + 1;
# }

addi $t0, $t0, 10	# $t0 = 10

bge $s1, $t0, Exit	# If i is greater than 10, then jump to Exit


lw $t1, 12($s6)	# Temporary reg $t1 gets A[3]
add $t1, $t1, $s2	# Temporary reg $t1 gets A[3] + j

sll $t2, $s1, 2		# Temporary reg $t2 = i * 4
add $t2, $t2, $s7 	# $t2 = address of B[i]

sw $t1, $t2		# Stores A[3] + j back into B[i]

addi $s1, $s1, 1	# i = i + 1

Exit: