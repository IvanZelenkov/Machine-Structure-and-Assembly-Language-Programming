# Program Description: program should be able to calculate factorial from user integer input.
# Author: Ivan Zelenkov
# Creation Date: 05/01/2022

# .data is the section where all variables are located
.data

# .align is used for the arrangement of data in memory, and specifically deals with 
# the issue of accessing data as proper units of information from main memory
.align 4

# ascizz - store the string in the Data segment and add null terminator
FunctionName: .asciiz  "******** FACTORIAL FUNCTION ********\n"
Enter: .asciiz "Enter value of n: "
Result: .asciiz "Result: "
NegativeNumberMessage: .asciiz  "Error: Negative value is not defined\n"
BoundaryMessage: .asciiz "Error: Result is larger than 32 bits\n"

.text	# .textiiz  is the section where the code is located
.globl main # .globl tells the assembler that the main symbol will be accessible from outside the current file

main:
	li $v0, 4             # print function name
	la $a0, FunctionName
	syscall
    
    	li $v0, 4             # print a message for the user
    	la $a0, Enter
    	syscall

    	li $v0, 5             # get input value n
	syscall
    
	add $a0, $v0, $zero   # pass argument to factorial function
	jal factorial

	li $v0, 4             # print result for the user
	la $a0, Result
	syscall

	li $v0, 1             # print result
	add $a0, $v1, $zero
	syscall

	j exit

factorial:
	addi $sp, $sp, -8     # adjust stack for 2 items
	sw   $ra, 4($sp)      # save return address
	sw   $a0, 0($sp)      # save argument (~push)
	slti $t0, $a0, 0      # test for n < 0
	beq  $t0, 1, NegativeNumberException 
	addi $t1, $t1, 12     # $t1 = $t1 + 12
	bgt  $a0, $t1, BoundaryException # test for n > 12
	slti $t0, $a0, 1      # test for n < 1, where n = 0
	beq  $t0, $zero, else
	addi $v1, $zero, 1    # if so, result is 1
	addi $sp, $sp, 8      # pop 2 items from stack
	jr   $ra              # and return
	
else: 
	addi $a0, $a0, -1     # else decrement n  
	jal  factorial        # recursive call
	lw   $a0, 0($sp)      # restore original n
	lw   $ra, 4($sp)      # and return address
	addi $sp, $sp, 8      # pop 2 items from stack
	mul  $v1, $a0, $v1    # multiply to get result
	jr   $ra              # and return
	
NegativeNumberException:
	li $v0, 4             # print function name
    	la $a0, NegativeNumberMessage
    	syscall
    
    	j exit
    
BoundaryException:
	li $v0, 4             # print function name
	la $a0, BoundaryMessage
	syscall
    
   	j exit
    
exit: 
	li $v0, 10            # exit
    	syscall
