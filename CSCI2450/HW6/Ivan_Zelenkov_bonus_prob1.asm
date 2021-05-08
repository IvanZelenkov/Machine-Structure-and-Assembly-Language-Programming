; Bonus
; Program Description: Program should be able to validate the 5-digit PIN number.
; Author: Ivan Zelenkov
; Creation Date: 05/05/2021
; Class: CSCI2450
; Instructor: Shaikh M. Arifuzzaman

INCLUDE Irvine32.inc

.data
str1 BYTE "Valid", 0
str2 BYTE "Invalid",0

; two arrays for minimum and maximum range of values
minRangeArr BYTE 5,2,4,1,3
maxRangeArr BYTE 9,5,8,4,6

; instances of four arrays which contain a 5-digit PIN
array1 BYTE 6,4,5,3,5
array2 BYTE 7,3,5,2,4
array3 BYTE 5,4,9,2,6
array4 BYTE 8,4,3,3,5
array5 BYTE 1,4,7,3,3

.code
main PROC
	call Clrscr				; clear the screen

	mov esi, OFFSET minRangeArr	; move minArray offset to the esi
	mov edi, OFFSET maxRangeArr	; move maxArray offset to the edi

	; Check if 64535 is a valid PIN or not
	mov ebx, OFFSET array1
	call Validate_PIN
	; if it returns 0, display a valid message
	.IF eax == 0
		mov edx, OFFSET str1
		call WriteString
		call Crlf
	; if it returns not 0, display a invalid message
	.ELSE
		mov edx, OFFSET str2
		call WriteString
		call Crlf
	.ENDIF ; end of if

	; Check if 54926 is a valid PIN or not
	mov ebx, OFFSET array2
	call Validate_PIN
	; if it returns 0, display a valid message
	.IF eax == 0
		mov edx, OFFSET str1
		call WriteString
		call Crlf
	; if it returns not 0, display a invalid message
	.ELSE
		mov edx, OFFSET str2
		call WriteString
		call Crlf
	.ENDIF ; end of if

	; Check if 73524 is a valid PIN or not
	mov ebx, OFFSET array3
	call Validate_PIN
	; if it returns 0, display a valid message
	.IF eax == 0
		mov edx, OFFSET str1
		call WriteString
		call Crlf
	; if it returns not 0, display a invalid message
	.ELSE
		mov edx, OFFSET str2
		call WriteString
		call Crlf
	.ENDIF ; end of if

	; Check if 84525 is a valid PIN or not
	mov ebx, OFFSET array4
	call Validate_PIN
	; if it returns 0, display a valid message
	.IF eax == 0
		mov edx, OFFSET str1
		call WriteString
		call Crlf
	; if it returns not 0, display a invalid message
	.ELSE
		mov edx, OFFSET str2
		call WriteString
		call Crlf
	.ENDIF ; end of if

	; Check if 14733 is a valid PIN or not
	mov ebx, OFFSET array5
	call Validate_PIN
	; if it returns 0, display a valid message
	.IF eax == 0
		mov edx, OFFSET str1
		call WriteString
		call Crlf
	; if it returns not 0, display a invalid message
	.ELSE
		mov edx, OFFSET str2
		call WriteString
		call Crlf
	.ENDIF ; end of if

	exit ; exit from program
main ENDP

;-------------------------------------------------------------
; Validate_PIN
; Receives: EBX = which contains pointer of array
;			ESI = pointer which has minRangeArr
;			EDI = pointer which has maxRangeArr
; Returns: EAX = position of the digit which was out of range [minRangeArr, maxRangeArr].
;-------------------------------------------------------------
Validate_PIN PROC USES ecx edx esi edi
	mov ecx, 5	; ECX = 5 (loop counter)
	mov eax, 0	; EAX = 0 (clear register EAX)

; checkPIN is a loop to check each digit from PIN
checkPIN:
	mov al, [ebx]
	; if digit in range, then if statement is true and increment each register so it moves forward to check next digit from array of PIN.
	.IF (al >= [esi]) && (al <= [edi])
		inc esi
		inc ebx
		inc edi
	; if digit is out of range 
	.ELSE
		mov eax, 3		; put in eax any value, so when it returns to the main procedure the condition will not be satisfied for the valid PIN.
		sub eax, ecx	; save index of position of the digit which was out of range
		ja return		; jump to checkPIN, so we return to the main procedure
	.ENDIF ; end of if

	loop checkPIN
	mov eax, 0			; if else statement didn't work then the program gets this line and sets EAX to 0, therefore the PIN is valid.

return:
	ret ; return EAX value from Validate_PIN procedure

Validate_PIN ENDP
END main