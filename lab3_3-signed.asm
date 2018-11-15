;x+a/b+c*d-b/c+e; a,b,d-byte; c-word; e-doubleword; x-qword 
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  db 40
	b  db 20
    d  db -10
    c dw 10
    e dd -30
    x dq -10
segment  code use32 class=code ; code segment
start:
    mov EAX,0;we empty EAX
    mov AL,[a] ;we add a into all
    cbw;we convert it to word
    idiv byte [b];we divide by byte b
    cwd
    cdq
    add EAX,dword[x];we add the first half to eax
    adc EDX,dword[x+4];we add the second to edx
    mov ECX,EAX;we move them to ECX:EBX
    mov EBX,EDX
    mov EAX,0;we empty
    mov EDX,0
    mov AL,[d];we move d into al
   ; mov DX,[c]
   cbw 
   cwde
    imul word[c];we multiply with the word c
    add ECX,EAX ;we add the result
     adc EBX,EDX ;we add the results with carry
     mov EAX,0;we empty both registers
     mov EDX,0;we empty edx
     mov AL,[b];we move b to al
     cwde
     idiv word [c];we divide the word
     sub ECX,EAX ;we subtract the results
     sbb EBX,0 ;we subtract with borrow
     add ECX,[e];we add e with ECX
     adc EBX,0;we add with carry

    push dword 0
    call [exit]