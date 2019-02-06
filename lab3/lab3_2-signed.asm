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
    mov AL,[a]           ;we move into AL A    EAX = 22AC4A0Ah
    cbw                     
    cwde                    
    cdq                    ;we convert it all to quad;EDX = 00000000h EAX = 0000000Ah
    add EAX,dword[d]          ;we add the part with D EAX = FFFFFFF6h
    adc EDX,dword[d+4]           ;we add the carry flag EDX = FFFFFFFFh
    mov ECX,EAX         ;we move the calculated values into ECX ECX =FFFFFFF6
    mov EBX,EDX         ;we move the other part into EBX EBX =  FFFFFFFFh
    mov EAX,0   ;we empty the quad
    mov EDX,0       ;same
    mov EAX,[c] ;we move c into EAX ; EAX = FFFFFFCEh
    sub EAX,ECX;we subtract c from EBX ; EAX = FFFFFFD8h
    sbb EDX,0;we subtract with carry flag EDX = FFFFFFFFh
    mov ECX,EAX;we move into ebx the cresults ECX=FFFFFFD8h
    mov EBX,EDX ;we moved it into the pear ECX:EBX EBX = FFFFFFFFh
    mov EAX,0;we empty EAX
    mov AX,[b] ;we add AX EAX = 00000014h
    cwde;we convert the w into quad
    add EAX,[c];we add the dw;EAX = FFFFFFE2h
    mov EDX,0;we empty the EDX 
    add EAX,ECX;we add  EAX with ecX EAX = FFFFFFBAh
    adc EDX,EBX ;we add EDX with ecx and the carry EDX = 00000000h
    push dword 0
    call [exit]