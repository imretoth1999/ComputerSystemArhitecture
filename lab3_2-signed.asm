;c-(d+a)+(b+c)- signed -40 -30 = -70
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  db 10
	b  dw 20
    c  dd -50
    d  dq -20 
segment  code use32 class=code ; code segment
start:
    mov AL,[a]           ;we move into AL A   
    cbw                     
    cwde                    
    cdq                    ;we convert it all to quad
    add EAX,dword[d]          ;we add the part with D
    adc EDX,dword[d+4]           ;we add the carry flag
    mov ECX,EAX         ;we move the calculated values into EBX
    mov EBX,EDX         ;we move the other part into ECX
    mov EAX,0   ;we empty the quad
    mov EDX,0       ;same
    mov EAX,[c] ;we move c into EAX
    sub EAX,ECX;we subtract c from EBX
    sbb EDX,0;we subtract with carry flag
    mov ECX,EAX;we move into ebx the cresults
    mov EBX,EDX ;we moved it into the pear ECX:EBX
    mov EAX,0;we empty EAX
    mov AX,[b] ;we add AX
    cwde;we convert the w into quad
    add EAX,[c];we add the dw
    mov EDX,0;we empty the EDX
    add EAX,ECX;we add  EAX with eBX
    adc EDX,EBX ;we add EDX with ecx and the carry
    push dword 0
    call [exit]