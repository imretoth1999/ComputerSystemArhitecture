;256*1
;Se da octetul A. Sa se obtina numarul intreg n reprezentat de bitii 2-4 ai lui A. Sa se obtina apoi in B octetul rezultat prin rotirea spre dreapta a lui A cu n pozitii. Sa se obtina dublucuvantul C:
;bitii 8-15 ai lui C sunt 0
;bitii 16-23 ai lui C coincid cu bitii lui B
;bitii 24-31 ai lui C coincid cu bitii lui A
;bitii 0-7 ai lui C sunt 1
;result 00011111000111110000000011111111b
bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 
extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
     a db 00011111b
     b db 0b
     c dd 0b

segment  code use32 class=code ; segmentul de cod
start:
      mov EAX,0;EAX = 00000000h
      mov EBX,0;EBX = 00000000h;
      mov ECX,0;we empty the registers ECX = 00000000h
      mov CL,[a];we move a into CL  ECX = 0000001Fh
      and CL,00011100b  ;we need only the 2 -4 bytes ;CL = 1Ch
      ror CL,2
      mov BL,[a];we move into BH a; EBX=0000001Fh
      ror BL,CL ;we rotate BH with the number formet with the 2-4 bytes ; BL=F1h 
      mov [b],BL ;we move the result into [b] 
      mov AL,[a] ; We put a into AL ;EAX = 0000001Fh
      mov EBX,0 ; we empty EBX; EBX=00000000h
      mov BL,[b] ; we put into BL EBX=000000F1h
      mov ECX,0;we empty ECX  ECX=00000000h
      or ECX, 00000000000000000000000011111111b;we need first 7 to be 1 ECX= 000000FFh
      and EBX,00000000000000000000000011111111b;we take EBX EBX=000000F1h
      rol EBX,16;we rotate it EBX=00F10000h
      or ECX,EBX;we add it ; ECX = 00F100FFh
      and EAX,00000000000000000000000011111111b;we take [a] EAX= 0000001Fh
      rol EAX,24;we rotate it ;EAX=1F000000h
      or ECX,EAX ;we add it ECX=1FF100FFh
      mov [c],ECX;we move it into [c] 
	push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of