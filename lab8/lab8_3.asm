;avem un text si scriem in fisier numai vocalele 
bits 32 

global start        

; declare external functions needed by our program
extern exit, fopen, fprintf, fclose, fread,printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll 
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
	d times 100 db 0 


    nume_fisier db "vocale.txt", 0  ; numele fisierului care va fi creat
    mod_acces db "r", 0          ; modul de deschidere a fisierului - 
                                 ; w - pentru scriere. daca fiserul nu exista, se va crea      
    k dd 0                                        
    descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    format dw "Number of odd numbers  = %d",0
    len equ 100                     ; numarul maxim de elemente citite din fisier intr-o etapa
    buffer resb len                 ; sirul in care se va citi textul din fisier
                                    
; our code starts here
segment code use32 class=code
    start:

        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2;we open the file
        
        cmp eax, 0                  ;if there was an error while reading we jump to final
        je final
        
        mov [descriptor_fis], eax ;we move the value of the descriptor into a variable
            
        bucla:
        
            push dword [descriptor_fis]
            push dword 1
            push dword 1
            push dword buffer
            call [fread];we read every character from the file and put it into the buffer
            add esp, 4*4
            cmp eax, 0
            je cleanup
            
            cmp dword[buffer],'a'
        je rr 
        cmp dword[buffer],'A'
        je rr 
        cmp dword[buffer],'e'
        je rr 
        cmp dword[buffer],'E'
        je rr 
        cmp dword[buffer],'i'
        je rr
        cmp dword[buffer],'I'
        je rr
        cmp dword[buffer],'o'
        je rr
        cmp dword[buffer],'O'
        je rr
        cmp dword[buffer],'u'
        je rr
        cmp dword[buffer],'U'
        je rr 
        jmp bucla
           
rr:       inc byte[k]
JMP bucla

      cleanup:
      
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        push dword[k]
        push dword format
        call [printf];we call the function
        add esp, 4 * 2    ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
      final:
      

        push    dword 0      
        call    [exit]       