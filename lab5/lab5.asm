;Se dau doua siruri de octeti S1 si S2 de aceeasi lungime. Sa se construiasca sirul D astfel: fiecare element de pe pozitiile pare din D este suma elementelor de pe pozitiile corespunzatoare din S1 si S2, iar fiecare element de pe pozitiile impare are ca si valoare diferenta elementelor de pe pozitiile corespunzatoare din S1 si S2. 
bits 32 
global start        
extern exit,printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	s db 1,2,3,4 ; declararea sirului initial s
	l equ $-s ; stabilirea lungimea sirului initial l
    s1 db 5,6,7,8
	d times l db 0 ; rezervarea unui spatiu de dimensiune l pentru sirul destinatie d si initializarea acestuia

segment code use32 class=code
start:
	mov ecx, l ;ECX=4h
    mov esi,0;ESI = 0h
    jecxz End
    Repeat:
            mov EAX,0;EAX = 0h
            mov EBX,0;EBX = 0h
            mov AL,[s+esi];AL =00000001h
            mov BL,[s1+esi] ;BL= 00000005h
            mov EDX,ESI;EDX = 0h
            shr DL,1; EDX= 0h,CF = 0
            jc odd ; if its odd the carry flag is 1
            jnc even ;if its even the carry flag is 0
odd:        sub AL,BL ;AL =000000FCh AL= 0000000FCh
JMP final
even:       add AL,BL ;AL=00000006h AL = 000000000Ah
final:
    mov [d+esi],AL ;d[0] = 6 d[1] = FC d[2] = A; d[3] = FC 
    inc ESI   ; ESI = 1;ESI = 2;ESI=3;ESI=4


    loop Repeat
    End:    
	push dword 0 ; push the parameter for exit onto the stack
	call [exit] ; call exit to terminate the program