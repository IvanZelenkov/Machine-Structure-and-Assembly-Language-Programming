; HW5
; Program Description: The greatest common divisor (GCD) of two integers is the largest
; integer that will evenly divide both integers. The GCD algorithm involves integer division in a loop,
; described by the following pseudocode.
; Author: Ivan Zelenkov
; Creation Date: 05/05/2021
; Class: CSCI2450
; Instructor: Shaikh M. Arifuzzaman

INCLUDE Irvine32.inc

.data
GCD		BYTE "=====Enter twor integers to calculate Greatest Common Divisor or 0 to quit from calculator=====", 0Ah
prompt  BYTE "Enter the integer: ", 0
result	BYTE "Great Common Divisor (GCD) is: ", 0

.code 
main PROC					; main procedure will execute all essential commands to represent Greatest Common Divisor calculator
	mov edx, OFFSET GCD
	call WriteString
	call ReadInt

L1:
	mov edx, OFFSET prompt
	call WriteString
	call ReadInt
	jz Quit

	mov ebx, eax					

	call WriteString
	call ReadInt
	jz Quit

	call CalculatorGCD

	mov edx, OFFSET result
	call WriteString
	call WriteDec
	call Crlf
	call Crlf
	jmp L1

Quit: 
	INVOKE ExitProcess, 0
main ENDP

;----------------------------------------------
CalculatorGCD PROC
; The GCD algorithm involves integer division in a loop
; Receives: EAX = 1st integer, EBX = 2nd integer
; ECX
; Returns: EAX = Greates Common Divisor
	push ebx		; push ebx register to the stack
	push edx		; push edx register to the stack
	
	cmp eax, 0		; if x >= 0
	jge LX			; otherwise, jump to LX if eax greater or equal to 0
	neg eax			; negate eax value if x was negative
LX:

	cmp ebx, 0		; if y >= 0
	jge LY			; otherwise, jump to LX if eax greater or equal to 0
	neg eax			; negate eax value if x was negative
LY:

do: 
	mov edx, 0
	div ebx			; EDX = EAX % EBX (n = x % y)

	mov eax, ebx	; EAX = EBX (x = y)
	mov ebx, edx	; EBX = EDX (y = n)

	cmp ebx, 0		; while (EBX > 0)
	jg	do			; jump to do loop

	pop edx			; pop edx register from the stack 
	pop ebx			; pop ebx register from the stack 
	ret				; return EAX (x)

CalculatorGCD ENDP

END main 