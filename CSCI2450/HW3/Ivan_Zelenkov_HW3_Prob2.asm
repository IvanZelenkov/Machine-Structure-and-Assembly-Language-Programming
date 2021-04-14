; HW3 Problem 2 (Ivan_Zelenkov_HW3_Prob2.asm)
; Program  Description: calculate the sum of an array of 10 32-bit integers using loop(s)
; Author: Ivan Zelenkov
; Creation Date: 03/30/2021
; Class: CSCI2450
; Instructor: Shaikh M. Arifuzzaman

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
numArray DWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.code
main PROC
	mov edi, OFFSET numArray	; move the address of the numArray to edx
	mov ecx, LENGTHOF numArray	; initialize loop counter register ECX to the LENGTHOF numArray
	mov eax, 0					; sum = 0 (the sum of numbers will accumulate in eax)

getSum_loop:					; beginning of loop L
	add eax, [edi]				; add current integer edi to accumulator eax. Also we could write this line as add eax, numArray[edi]
	add edi, TYPE numArray		; points to next element. EDI = EDI + 4
	loop getSum_loop			

	invoke ExitProcess, 0
main ENDP
END main