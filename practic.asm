bits 32 

global start        

extern exit, fopen, fprintf, fclose, fread,printf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll 
import printf msvcrt.dll

segment data use32 class=data
	d times 100 db 0 
    nume_fisier db "cv.txt", 0  
    mod_acces db "r", 0                                               
    cont dd 0
   ; k2 dd 0
   ; k3 dd 0 
    fw dd 0
    ok dd 0
    ddd times 199 db 0
    prop dd 0
    descriptor_fis dd -1         
    format dw "%c",0
    len equ 1000                    
    buffer resb len 
    format2 dw "Propozitia %d:",0
    format1 dw "Nr cuvinte:%d Primul cuvant are litere %d",0
    format4 dw "%s",0
    sss dw 'Ana'
    s dw 3
    nl dw 0Ah,0
segment code use32 class=code
    start:
      push dword mod_acces
      push dword nume_fisier
     call [fopen]
     add esp, 4*2;
     cmp eax, 0                  
     je final
     mov ECX,0
     mov [descriptor_fis], eax 
     inc dword [prop]
     push dword[prop]
    push dword format2
      call [printf]
      add esp, 4 * 2 
        mov ECX,100
        bucla:
            
            DEC ECX
            push dword [descriptor_fis]
            push dword 1
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            cmp eax, 0
            je cleanup
            cmp dword[buffer],' '
            jne icr
            inc dword [cont]
            inc dword[ok]
            icr:
            cmp dword[ok],0
            jne ffs
            ;mov dword[ddd+icr],dword[buffer]
            inc dword[fw]
            ffs:
            cmp dword[buffer],'.'
            je println
            push dword[buffer]
            push dword format
            call [printf]
            add esp, 4 * 2
            jmp f
             println:
            inc dword [cont]
            push dword[buffer]
           push dword format
            call [printf]
            add esp, 4 * 2
            push dword[fw]
            push dword [cont]
           push dword format1
            call [printf]
             add esp, 4 * 3
            AND dword[cont],0
           push nl
            call [printf]
              AND dword[ok],0
              
              
              mov ecx, s
            mov EBX, sss
            mov esi, EBX  
            add eax, ecx
            mov edi, EBX
            dec edi       
            shr ecx, 1    
            reverseLoop:
            mov al, [esi] 
        mov bl, [edi]
        mov [esi], bl 
        mov [edi], al
        inc esi       
        dec edi
        dec ecx       
        jnz reverseLoop
        mov [sss],ECX
          push dword[sss] 
           push format4 
            call [printf]
            add esp, 4 * 2

          AND dword[fw],0
             inc dword [prop]
            cmp dword[prop],2
            jg f
            push dword[prop]
           push dword format2
            call [printf]
           add esp, 4*2
           mov EAX,10
         
        f:
        jnz bucla
            

    cleanup:
      
        ;push dword [descriptor_fis]
        call [fclose]
       ; add esp, 4
        ;push dword[k]
      ;  push dword format
      ;  call [printf]
       ; add esp, 4 * 2    
      final:
      

        push    dword 0      
        call    [exit]       