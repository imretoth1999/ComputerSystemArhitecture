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
    mov EAX,0;we empty EAX EAX=00000000h
    mov EBX,0;we empty EBX=00000000h
    mov EDX,0
    mov AL,[a] ;we add a into all EAX = 00000028h
    cbw;we convert it to word EAX= 00000028h
    idiv byte [b];we divide by byte b EAX=00000002h
    cwd
    cdq;EAX=00000002h EDX=00000000h
    add EAX,dword[x];we add the first half to eax;EAX=FFFFFFF8h
    adc EDX,dword[x+4];we add the second to edx;EDX = FFFFFFFFh
    mov ECX,EAX;we move them to ECX:EBX ECX = FFFFFFF8hh
    mov EBX,EDX;EBX = FFFFFFFFh
    mov EAX,0;we empty
    mov EDX,0
    mov AL,[d];we move d into al EAX=000000F6h
   ; mov DX,[c]
   cbw 
   cwde;EAX=FFFFFFF6h
    imul word[c];we multiply with the word c EAX= FFFFFF9Ch EDX=0000FFFF
    add ECX,EAX ;we add the result ECX=FFFFFF94h
     adc EBX,EDX ;we add the results with carry EBX=0000FFFFh
     mov EAX,0;we empty both registers
     mov EDX,0;we empty edx
     mov AL,[b];we move b to al; EAX=00000014h
     cwde;
     idiv word [c];we divide the word
     sub ECX,EAX ;we subtract the results ; ECX=00000002h
     sbb EBX,0 ;we subtract with borrow EBX=0000FFFFh
     add ECX,[e];we add e with ECX ECX=FFFFFF74h
     adc EBX,0;we add with carry EBX=00010000h

    push dword 0
    call [exit]