;[2*(a+b)-5*c]*(d-3)
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  db 10
	b  db 40
    c  db 10
    d  dw 23
segment  code use32 class=code ; code segment
start:
    mov AL,[a];we move a into AL
    add AL,[b];we add a with b
    mov CL,2;we memorise 2 in CL
    mul CL;we multiply AL with 2 
    mov BL,AL ; we move AL into bl 
    mov AX,[c];we move C into ax 
    mov CX,5;we move into cx 5
    mul CX;we multiply ax(c) with 5(being CX)
    sub BL,AL;we substract the 2 multiplications
    mov AL,BL  ;we move the value into AL
    mov BL,[d];we move into BL the value of D
    sub BL,3;we subtract d with 3 
    mul BL;we multiply AL with BL getting the computation
    push dword [0]
    call [exit]
