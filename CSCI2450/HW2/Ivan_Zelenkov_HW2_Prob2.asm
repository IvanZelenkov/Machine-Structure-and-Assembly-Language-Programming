; HW2 Problem 2 (Ivan_Zelenkov_HW2_Prob2.asm)
; Program  Description: evaluate the following expression varA = (varA + varB) - (-varC + varD++)
; Author: Ivan Zelenkov
; Creation Date: 03/08/2021
; Class: CSCI2450
; Instructor: Shaikh M. Arifuzzaman

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
	varA byte 15
	varB byte 7
	varC byte 8
	varD byte 10

.code
main PROC
	mov	AL, varA		; AL = varA
	add	AL, varB		; AL = varA + varB
	
	neg varC			; -varC
	mov BL, varC		; BL = varC

	inc varD			; varD++
	add BL, varD		; BL = -varC + varD++

	sub AL, BL			; result = AL - BL

	invoke ExitProcess,0
main ENDP
END main