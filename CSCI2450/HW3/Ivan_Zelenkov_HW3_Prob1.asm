; HW3 Problem 1 (Ivan_Zelenkov_HW3_Prob1.asm)
; Program  Description: reverse a string
; Author: Ivan Zelenkov
; Creation Date: 03/30/2021
; Class: CSCI2450
; Instructor: Shaikh M. Arifuzzaman

INCLUDE Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
source BYTE "abcdefghij", 0			; source array which contains the string type of BYTE

.code
main PROC
	mov esi, 0						; start of string index
	mov edi, LENGTHOF source - 2	; end of string index
	mov ecx, SIZEOF source / 2		; return the number of bytes in an operand => loop counter

	mov edx, OFFSET source			; move the address of the source to edx
	call WriteString				; call function from Irvine library to output source array
	call Crlf						; call new line function from Irvine library
	call Crlf

swap_loop:							; beginning of loop swap_loop
	mov al, source[esi]				; move first element from left side to al
	mov bl, source[edi]				; move last element from left side to bl
	mov source[esi], bl				; move element from bl to the first cell of the source
	mov source[edi], al				; move element from al to the last cell of the source
	inc esi							; increment extended source index
	dec edi							; decrement destination index
	
	mov edx, OFFSET source			; move the address of the source to edx
	call WriteString				
	call Crlf

	loop swap_loop					; end of the loop swap_loop

	invoke ExitProcess, 0
main ENDP
END main