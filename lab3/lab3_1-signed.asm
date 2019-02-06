;(a+b)-(a+d)+(c-a) - signed
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  db 10
	b  dw -20
    c  dd -50
    d  dq -20 
segment  code use32 class=code ; code segment
start:
    mov AL,[a];AL has a
    cbw ;convert byte to word
    add AX,[b];we do a+b
    cwd ;we convert the result to dword
    push dx;we push DX:AX
    push ax
    pop EAX; we transform dx:ax to eax
    mov EBX,EAX;we move eax to ebx bc we have a better plan for EAX
    mov ECX,[d];we move ECX
    mov AL,[a];we move a to AL
    cbw;we convert the byte to word
    cwd;we convert the word to doublew
    push dx;we push the pair DX:AX
    push ax 
    pop EAX ;we get EAX
    add EAX,ECX ;we add EAX with ECX
    sub EBX,EAX;we subtract EBX from EAX (a+b) from (a+d)
    mov AL,[a];we move the byte a into AL
    cbw ;we conver tto word
    cwd ;we convert to doublew
    push DX;we push the pair
    push AX
    pop EAX ;we pop the result
    mov ECX,[c];we move C into ECX
   sub ECX,EAX ;we subtract from c the EAX
   add EBX,ECX;we add EBX with the result from the previous command

    
    push dword 0
    call [exit]