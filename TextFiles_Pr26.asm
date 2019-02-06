bits 32

global start


extern exit, fprintf, fopen, fread, fclose, scanf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll
import scanf msvcrt.dll


segment data use32 class=data
    file_name db "Pr26Lab8.txt", 0   
    access_mode db "a", 0                                  
    file_descriptor dd -1  
    format db "%s",0    
    string dd 0
; our code starts here
segment code use32 class=code
    start:
     push dword access_mode     
     push dword file_name
     call [fopen]
     add esp, 4*2                ; clean-up the stack
     mov [file_descriptor], eax  ; store the file descriptor returned by fopen
     cmp eax, 0 ; check if fopen() has successfully created the file (EAX != 0)
     je final
     cld
     repeta:
       
        push dword string
        push dword format
        call [scanf]
        add esp,4*2
        cmp eax,0
        je final
        lea ESI,[string]
        nextchar:
            mov EBX,0
            lodsb
            cmp AL,'$'
            je final
            cmp AL,0
            je afterjmp
            cmp AL,'A'
            jl afterinc
            cmp AL,'Z'
            jg afterinc
            inc EBX
            afterinc:
            cmp EBX,1
            jne afterfile
            push dword string
            push dword [file_descriptor]
            call [fprintf]
            add esp, 4*2
            jmp repeta
            afterfile:
            inc ESI
            jmp nextchar
            afterjmp:
            jmp repeta
            
    
    
    
    final:
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        push dword 0      
        call [exit]