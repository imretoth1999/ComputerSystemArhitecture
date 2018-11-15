;c-(d+a)+(b+c)- unsigned 
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  db 10
	b  dw 20
    c  dd 50
    d  dq 20 
segment  code use32 class=code ; code segment
start:
    mov AL,[a];we move a to AL
    mov AH,0;we make AL an word
    mov DX,0;now we make it as dw
    push DX;we push the pair
    push AX 
    pop EAX;we pop the result
    add EAX,[d];we add the result with [d]
    mov EBX,EAX;we move EAX to ebx so we can use eax once again
    mov EAX,[c];we move c into eax
    sub EAX,EBX;we subtract EBX from C
    mov EBX,EAX;we move EAX(the result) to ebx
    mov AX,[b];we move b to ax
    mov DX,0;we make the pair DX:AX 
    push DX;we push the pair
    push AX 
    pop EAX;we pop the result 
    add EAX,[c];we add the result with c
    add EBX,EAX;we add the result with EBX and store the result in EBX
    push dword 0
    call [exit]