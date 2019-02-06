;c-(d+a)+(b+c)
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  dw 10
	b  dw 40
    c  dw 30
    d  dw 20
segment  code use32 class=code ; code segment
start:
    mov AX,[d];we put D in AX bc its a word
    add AX,[a];we add d with a,d being AX
    mov BX,[b];we add in BX b
    add BX,[c];we add BX b +c 
    mov CX,[c];we add in CX c 
    sub CX,AX; we substract ax from c,ax being (d+a)
    add CX,BX;we add c-(d+a) with b+c
    push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of
