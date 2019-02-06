;Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze produsul lor si sa se afiseze in urmatorul format: "<a> * <b> = <result>"
;Exemplu: "2 * 4 = 8"
;Valorile vor fi afisate in format decimal (baza 10) cu semn.
bits 32 
global start
; declararea functiilor externe folosite de program
extern exit, printf, scanf ; adaugam printf si scanf ca functii externa            
import exit msvcrt.dll    
import printf msvcrt.dll    ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll     ; similar pentru scanf
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	a dd 1
    b dd 0
    c dd 0
    format dw "%d * %d  = %d",0
    message db "Input the second number",0
    f1 dw "%d",0
segment code use32 class=code
start:
    
    push dword message;we print the message
    call [printf];we call the external function
    add esp,4*1;we empty the stack
    push dword b ; we push the scanf
    push dword f1 ;we push the scanf
    call [scanf] ; we call the function scanf
    add esp,4*2
    mov EAX,0
    mov EAX,[a] ;we move into eax de value
    imul dword[b] ; we multiply with the other value
    mov [c],EAX ; we move into the new value the calculated value
        push dword[c] ;we push the parameters of the printf function
        push dword[b]
        push dword[a]
        push dword format
        call [printf];we call the function
        add esp, 4 * 4     ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        push dword 0; push the parameter for exit onto the stack
        call [exit]; call exit to terminate the program

