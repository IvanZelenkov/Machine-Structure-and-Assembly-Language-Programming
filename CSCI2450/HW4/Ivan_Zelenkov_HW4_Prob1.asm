; Homework 4
; Filename: Ivan_Zelenkov_HW4_Prob1.asm
; Program Description: Create a program that functions as a simple Boolean calculator for 32-bit integers.
; Author: Ivan Zelenkov
; Creation Date: 04/28/2021
; Class: CSCI2450
; Instructor: Shaikh M. Arifuzzaman

INCLUDE Irvine32.inc

.data
CalculatorUI BYTE "|=====================================|", 0dh, 0ah
			 BYTE "|    32-bit Boolean Calculator        |", 0dh, 0ah
			 BYTE "|=====================================|", 0dh, 0ah
			 BYTE "|1. x AND y                           |", 0dh, 0ah
			 BYTE "|2. x OR y                            |", 0dh, 0ah
	         BYTE "|3. NOT x                             |", 0dh, 0ah
			 BYTE "|4. x OR y                            |", 0dh, 0ah
		     BYTE "|5. Exit calculator                   |", 0dh, 0ah
			 BYTE "|=====================================|", 0dh, 0ah
			 BYTE "|Please select 1,2,3,4 or 5:          |", 0dh, 0ah
			 BYTE "|=====================================|", 0

integer1     BYTE "Enter the first integer: ", 0
integer2     BYTE "Enter the second integer: ", 0
result       BYTE "Result: ", 0
messageAND   BYTE "Calling Process 1 (x AND y)", 0
messageOR    BYTE "Calling Process 2 (x OR y)", 0
messageNOT   BYTE "Calling Process 3 (NOT x)", 0
messageXOR   BYTE "Calling Process 4 (x XOR y)", 0
messageInput BYTE "Input (1 - 5):", 0
messageEXIT  BYTE "Calling Process 5 (Exit Program)", 0

.code 
main PROC 
UserInteface:
	mov edx, OFFSET CalculatorUI ; display a Calculator Interface
	call WriteString		
	call Crlf					

UserInput:
	call Crlf
	mov edx, OFFSET messageInput
	call WriteString
	call Crlf

	call ReadChar				; read inpute from user of type character

	cmp al, '5'					; if user's input AL > 5, then let take input again
	ja UserInput

	cmp al, '1'					; if user's input AL < 1, then let take input again
	jb UserInput 

	cmp al, '1'					; if user's input AL = 1, then jump to AND operation
	je AND_Op

	cmp al, '2'					; if user's input AL = 2, then jump to OR operation
	je OR_Op

	cmp al, '3'					; if user's input AL = 3, then jump to NOT operation
	je NOT_Op

	cmp al, '4'					; if user's input AL = 4, then jump to XOR operation
	je XOR_Op

	cmp al, '5'					; if user's input AL = 5, then jump to Quit operation
	je Quit						

AND_Op:							; AND operation
	mov edx, OFFSET messageAND	; diplay message of AND operation
	call WriteString		
	call Crlf

	pushad						; push all registers onto stack
	mov edx, OFFSET integer1	; ask user to type the first integer
	call WriteString			; display prompt1 string in console for user
	call ReadHex				; read user's input (first integer)
	mov ebx, eax				; move user's input first integer to EBX

	mov edx, OFFSET integer2	; ask user to type the second integer
	call WriteString			; display prompt2 string in console for user
	call ReadHex				; read user's input (second integer)

	AND eax, ebx				; AND opeartion for two integers

	mov edx, OFFSET result		; display user the text "Result: "
	call WriteString			; dispaly result string in console
	call WriteHex				; dispaly value of result after the entire AND operation
	call Crlf					; new line
	popad						; save and restore all registers
	jmp UserInput				; jump back to the UserInput operation

OR_Op:							; OR operation
	mov edx, OFFSET messageOR	; diplay message of OR operation
	call WriteString		
	call Crlf

	pushad						; push all registers onto stack
	mov edx, OFFSET integer1	; ask user to type the first integer
	call WriteString			; display prompt1 string in console for user
	call ReadHex				; read user's input (first integer)
	mov ebx, eax				; move user's input first integer to EBX

	mov edx, OFFSET integer2	; ask user to type the second integer
	call WriteString			; display prompt2 string in console for user
	call ReadHex				; read user's input (second integer)

	OR eax, ebx					; OR opeartion for two integers

	mov edx, OFFSET result		; display user the text "Result: "
	call WriteString			; dispaly result string in console
	call WriteHex				; dispaly value of result after the entire AND operation
	call Crlf					; new line
	popad						; save and restore all registers
	jmp UserInput				; jump back to the UserInput operation

NOT_Op:							; NOT operation
	mov edx, OFFSET messageNOT	; diplay message of NOT operation
	call WriteString		
	call Crlf

	pushad						; push all registers onto stack
	mov edx, OFFSET integer1	; ask user to type the first integer
	call WriteString			; display prompt1 string in console for user
	call ReadHex				; read user's input (first integer)
	mov ebx, eax				; move user's input first integer to EBX

	mov edx, OFFSET integer2	; ask user to type the second integer
	call WriteString			; display prompt2 string in console for user
	call ReadHex				; read user's input (second integer)

	NOT eax						; AND opeartion for two integers

	mov edx, OFFSET result		; display user the text "Result: "
	call WriteString			; dispaly result string in console
	call WriteHex				; dispaly value of result after the entire AND operation
	call Crlf					; new line
	popad						; save and restore all registers
	jmp UserInput				; jump back to the UserInput operation

XOR_Op:							; XOR operation
	mov edx, OFFSET messageXOR	; diplay message of XOR operation
	call WriteString		
	call Crlf

	pushad						; push all registers onto stack
	mov edx, OFFSET integer1	; ask user to type the first integer
	call WriteString			; display prompt1 string in console for user
	call ReadHex				; read user's input (first integer)
	mov ebx, eax				; move user's input first integer to EBX

	mov edx, OFFSET integer2	; ask user to type the second integer
	call WriteString			; display prompt2 string in console for user
	call ReadHex				; read user's input (second integer)

	XOR eax, ebx				; AND opeartion for two integers

	mov edx, OFFSET result		; display user the text "Result: "
	call WriteString			; dispaly result string in console
	call WriteHex				; dispaly value of result after the entire AND operation
	call Crlf					; new line
	popad						; save and restore all registers
	jmp UserInput				; jump back to the UserInput operation

Quit:							; Quit operation
	call Crlf					; new line
	exit						; exit from program

main ENDP
END main 