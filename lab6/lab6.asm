;Se da un sir de octeti s. Sa se construiasca sirul de octeti d, care contine pe fiecare pozitie numarul de biti 1 ai octetului de pe pozitia corespunzatoare din s.
bits 32 
global start        
extern exit,printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	s db 11b,111b,0b,1b ; declararea sirului initial s
	l equ $-s ; stabilirea lungimea sirului initial l
	d times l db 0 ; rezervarea unui spatiu de dimensiune l pentru sirul destinatie d si initializarea acestuia

segment code use32 class=code
start:
    mov EAX,0
    mov EDX,0
    mov ECX,l;we put the lenght in L
       ; mov ax, data
     ; this is the source string 
  ;  lea di,res ; this is the destination string 
    mov ESI,s;we move s into esi 

  ;  mov EBX,0
   ; check:
    ;    mov EDX,0; we enoty edx
     ;   lodsb ;we ge the number
      ;  
       ; POPCNT EDX,EAX;we find the number of ones
       ; mov [d+EBX],EDX ;we move into the new vector the number
       ; inc EBX ;we increment ebx
        
    ;loop check;we loop
    mov EAX,10b+10b
    push dword 0 ; push the parameter for exit onto the stack
	call [exit] ; call exit to terminate the program