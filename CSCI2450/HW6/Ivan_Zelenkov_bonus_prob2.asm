; Bonus
; Program Description: Fibonacci Generator
; Author: Ivan Zelenkov
; Creation Date: 05/05/2021
; Class: CSCI2450
; Instructor: Shaikh M. Arifuzzaman


;.386
;.model flat, stdcall
;.stack 4096
;ExitProcess PROTO, dwExitCode:DWORD

INCLUDE Irvine32.inc

.data
array DWORD 1, 1
lastValue DWORD 2971215073
N DWORD 47 - 2

.code
main PROC

  mov esi, OFFSET array         ; pass the pointer to the array
  add esi, TYPE array           ; add ESI and the size, in bytes, of the "representing" type of an array
  add esi, TYPE array           ; add ESI and the size, in bytes, of the "representing" type of an array
  mov ecx, N                    ; pass the number of values which will be generated

L1:
    call FibonacciGenerator
    add esi, TYPE array         ; store the values in an array of doubleword
    loop L1

INVOKE ExitProcess,0
main ENDP

;--------------------------------------------------
FibonacciGenerator PROC     
; Procedure that produces N values in the Fibonacci number series 
; Returns: EAX value
;--------------------------------------------------
    mov eax, [esi - 4]    
    mov ebx, [esi - 8]
    add eax, ebx            ; first = previous + second
    mov [esi], eax          ; save fibonacci value into esi
    ret                     ; return value of EAX              
FibonacciGenerator ENDP
END main