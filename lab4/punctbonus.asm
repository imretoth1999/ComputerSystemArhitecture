;avem un text si scriem in fisier numai vocalele 
bits 32 

global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    text db "Doua puncte in plus va rog", 0    ; textul care va fi scris in fisier
	l equ $-text ; stabilirea lungimea sirului initial l
	d times 100 db 0 ; rezervarea unui spatiu de dimensiune l pentru sirul destinatie d si initializarea acestuia

    nume_fisier db "ana.txt", 0  ; numele fisierului care va fi creat
    mod_acces db "w", 0          ; modul de deschidere a fisierului - 
                                 ; w - pentru scriere. daca fiserul nu exista, se va crea      
                                        
    descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
                                    
; our code starts here
segment code use32 class=code
    start:
        ; apelam fopen pentru a crea fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva
        mov EDX,0
        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        cmp eax, 0
        je final
        mov ECX,l
        mov esi,text
        check:
        mov EAX,0
        lodsb
        cmp AL,'a'
        je rr 
        cmp AL,'A'
        je rr 
        cmp AL,'e'
        je rr 
        cmp AL,'E'
        je rr 
        cmp AL,'i'
        je rr
        cmp AL,'I'
        je rr
        cmp AL,'o'
        je rr
        cmp AL,'O'
        je rr
        cmp AL,'u'
        je rr
        cmp AL,'U'
        je rr 
        jmp no
        
        rr:
        mov [d+edx], EAX
        inc edx 

        no:
        loop check
        push dword d
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*2
        
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
      final:
        
        ; exit(0)
        push    dword 0      
        call    [exit]       