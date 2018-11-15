;(a+b)-(a+d)+(c-a)


bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
	a  db 10
	b  db 40
    c  db 30
    d  db 20
segment  code use32 class=code ; code segment
start: 
	mov AL,[a];we put a in AL
    add AL,[b];we add a +b and store it in AL
    mov BL,[d] ;We move D into AL
    add BL,[a] ; We add d + a and store it in BL
    mov CL,[c] ; we move c into CL
    sub CL,[a] ; we substract c- a and store it in CL
    sub AL,BL ;we subtract Al - BL 
    add AL,CL; we add (c-a)and store it in AL 
	
	push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of
;the program
