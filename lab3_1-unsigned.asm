;(a+b)-(a+d)+(c-a)
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
    d  dq 5 
segment  code use32 class=code ; code segment
start:
    mov EAX,0;we empty EAX
    mov AL,[a]; A goes into AL
    add AX,[b] ;AX = a + b 
    mov EBX,0; we empty EBX
    mov ECX,0;we empty ECX
    mov ECX,EAX;we move EAX into ECX
    mov EAX,0;we make EAX 0
    mov EDX,0;we make EDX 0
    mov AL,[a];we move a into AL
    add EAX,dword[d];we add EAX with D
    adc EDX,dword[d+4] ; we add the carry flag
    sub ECX,EAX;we subtract ECX from EAX
    sbb EBX,EDX;we subtract with borrow
    mov EDX,0;we empty EDX
    mov EAX,0;we empty EAX
    mov EDX,[c];we ADD EDX to c
    mov EAX,0;WE make eax empty
    mov AL,[a] ;we move a into AL
    sub EDX,EAX ;we subtrawct 
    add ECX,EDX ;we add 
    adc EBX,0;we add with carry
    push dword 0
    call [exit]