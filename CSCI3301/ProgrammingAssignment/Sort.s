# Program Description: program sorts a set of given integers using the bubble sort algorithm.
# Author: Ivan Zelenkov
# Creation Date: 05/07/2022

.data # .data is the section where all variables are located

# .align is used for the arrangement of data in memory, and specifically deals with 
# the issue of accessing data as proper units of information from main memory
.align 4

# ascizz - store the string in the Data segment and add null terminator
Array: .space 700
FunctionName: .asciiz "******** SORT FUNCTION ********\n"
EnterArraySize: .asciiz "Enter size of array: "
EnterNumbersMessage: .asciiz "Enter numbers below\n"
EnterIntegerMessage: .asciiz "Enter Integer: "
OutputOriginalArray: .asciiz "Original array: "
PrintNumberMessage: .asciiz " "
OutputResultArray: .asciiz "\nHere is the sorted list in ascending order: "
EmptyArrayMessage: .asciiz "Error: empty array\n"

.text # .textiiz  is the section where the code is located
.globl main # .globl tells the assembler that the main symbol will be accessible from outside the current file

main:
	li $v0, 4			# print function name
	la $a0, FunctionName	
	syscall
	
        li $v0, 4
        la $a0, EnterArraySize  # message to input array size value
        syscall
	li $v0, 5
	syscall
	move $s0, $v0 			# get array size value
	
	beq $s0, $zero, IllegalArgumentException	

	li $v0, 4
	la $a0, EnterNumbersMessage # message to tell the user the next step
	syscall

	addi $t0, $zero, 0		# initialize couter $t0 = 0

inputNumber:
	bge $t0, $s0, printSortThenPrint # if $t0.value >= array.length, then branch on done
	li $v0, 4
	la $a0, EnterIntegerMessage	 # message to enter a number
	syscall
	li $v0, 5
	syscall

	sll $t1, $t0, 2			# calculate address reg $t2 = i * 4
	add $t3, $v0, $zero		# assign input value to $t3 register
	sw $t3, Array($t1)		# store value into an array using a specific address
	addi $t0, $t0, 1		# increment $t0

	j inputNumber 			# jump back to inputNumber to read another number

printSortThenPrint:
	subi $s0, $s0, 1		# decrease array length value by 1 due to zero-based array indexing

	li $v0, 4
	la $a0, OutputOriginalArray # message user what values contain the original array
	syscall
	jal printArray			# jump to print an original array

	la $a0, Array			# load Array address into $a0
	addi $a1, $s0, 1 		# assign array length value to $a1 register
	
	jal bubbleSort			# jump to sort an array using bubble sort

	addi $s5, $s0, 1 		# get number of elements in array = array.length + 1

	li $v0, 4
	la $a0, OutputResultArray       # output a sorted array of numbers
	syscall
	jal printArray 			# jump to print ordered array

	j exit 

bubbleSort:
	add $t0, $zero, $zero 	        # initialize couter $t0 = 0

outerLoop:
	addi $t0, $t0, 1 		# increment counter by 1
	bgt $t0, $a1, endSort 	        # if $t0 (counter) > $a1 (array.length), then branch to endSort

	add $t1, $a1, $zero		# assign array.length from $a1 to $t1 register

innerLoop:
	bge $t0, $t1, outerLoop         # counter >= array.length

	addi $t1, $t1, -1 		# decrement array.length

	mul $t4, $t1, 4 		
	addi $t3, $t4, -4 		
	add $t7, $t4, $a0 		# table[j] element address equals $t4 + $a0
	add $t8, $t3, $a0 		# table[j - 1] element address equals $t3 + $a0
	lw $t5, 0($t7)			# load value to register $t5 from table[j] cell
	lw $t6, 0($t8)			# load value to register $t6 from table[j - 1] cell

	bgt $t5, $t6, innerLoop	        # if $t5 > $t6, then branch on innerLoop

swap:
	sw $t5, 0($t8)			# otherwise, swap $t5 and $t6, so the predecessor is less than the successor
	sw $t6, 0($t7)
	j innerLoop			# jump to innerLoop to check next pair of elements

endSort:
	jr $ra

printArray:
	la $t0, Array 			# load Array address into $t0
	add $t1, $zero, $zero

printNumber:
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, PrintNumberMessage      # print number
	syscall
	addi $t0, $t0, 4		# calculate address reg $t0 = i * 4
	addi $t1, $t1, 1		# increment counter
	slt $t2, $s0, $t1		# if array.length < counter, then $t2 = 1
	beq $t2, $zero, printNumber	# if there are numbers left in the array, then go to the next iteration 
	jr $ra
	
IllegalArgumentException:
	li $v0, 4			# print error message
	la $a0, EmptyArrayMessage	
	syscall
	
	j exit
	
exit:
	li $v0, 10			# exit
	syscall
