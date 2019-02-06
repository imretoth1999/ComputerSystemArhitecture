;x+a/b+c*d-b/c+e; a,b,d-byte; c-word; e-doubleword; x-qword 10 + 100  + 30
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  db 40
	b  db 20
    d  db 10
    c dw 10
    e dd 30
    x dq 10
segment  code use32 class=code ; code segment
start:
    mov EAX,0;we empty EAX
    mov AL,[a] ;we add a into all EAX = 00000028h
    mov AH,0;we convert it to word
    div byte [b];we divide by byte b EAX=00000002h
    mov AH,0;we empty AH 
    mov EDX,0;we empty EDX
    add EAX,dword[x];we add the first half to eax EAX=0000000Ch
    adc EDX,dword[x+4];we add the second to edx EDX=00000000h
    mov ECX,EAX;we move them to ECX:EBX ECX = 0000000Ch
    mov EBX,EDX ; EBX = 00000000h
    mov EAX,0;we empty
    mov EDX,0
    mov AL,[d];we move d into al EAX=0000000Ah
   ; mov DX,[c]
    mul word[c];we multiply with the word c ;  EAX= 00000064h
    add ECX,EAX ;we add the result ECX=00000070h
     adc EBX,EDX ;we add the results with carry EBX=00000000h
     mov EAX,0;we empty both registers
     mov EDX,0;we empty edx
     mov AL,[b];we move b to al EAX = 00000014h
     div word [c];we divide the word EAX=00000002h
     mov EDX,0;we empty edx
     sub ECX,EAX ;we subtract the results ECX = 0000006Eh
     sbb EBX,0 ;we subtract with borrow EBX= 00000000h
     add ECX,[e];we add e with ECX ECX=0000008Ch
     adc EBX,0;we add with carry EBX=00000000h

    push dword 0
    call [exit]