
PRNT MACRO REG

 MOV AX,REG 

call printw

int 0x20

printw:

 push ax

 shr ax, 8

 call printb

 pop ax

 push ax

 and  ax, 0xff

 call printb

 pop ax

 ret

printb:

  push ax

  shr al, 4

  call printasc

  pop ax

  and al, 0xf

  call printasc

  ret

printasc:

  add al, 0x30

  cmp al, 0x39

  jle printasc_e

  add al, 0x7

  printasc_e:

  mov dl, al

  mov ah, 0x2

  int 0x21

  ret   

ENDM
PRNTL MACRO REG ;for printing only register like al
    MOV AL,REG
    CALL printb1
    INT 0X20
    printb1:
  push ax
  shr al, 4
  call printasc1
  pop ax
  and al, 0xf
  call printasc1
  ret
printasc1:
  add al, 0x30
  cmp al, 0x39
  jle printasc_e1
  add al, 0x7
  printasc_e1:
  mov dl, al
  mov ah, 0x2
  int 0x21
  ret   
ENDM


PRNTM MACRO MSG

    MOV AH,09H

    LEA DX,MSG

    INT 21H 

    LEA DX,n_line

    MOV AH,9

    INT 21H    

ENDM

 INPUTB MACRO  ;FOR YOU TO TAKE INPUT IT WILL TAKE  INPUT OF NUMBER OF 2 DIGIT PLEASE MENTION IN FUNCTION

   mov ah,1    ;input function

   int 21h

   mov bh,al   ;save the value from input

   MOV AH,1

   INT 21H

   MOV BL,AL  ;THE INFO IS STORED IN BX REGISTER

 ENDM

 INPUTI MACRO 

   MOV AH,1

   INT 21H

   MOV BH,AL

ENDM

    ADDITION MACRO
        INPUTB

    and bx,0x0f0fh

    ROL bh,04

    add bl,bh

    mov bh,00

    MOV CX,BX

    INPUTB

    and bx,0x0f0fh
    
    ROL bh,04

    add bl,bh

    mov bh,00

        MOV AX,CX

        ADD AL,BL

        DAA

        MOV CL,AL

        MOV AL,AH

        ADC AL,BH
        
        DAA

        MOV CH,AL

        PRNT CX

    ENDM
    SUBTRACTION MACRO
    INPUTB 
    and bx,0x0f0fh

    ROL bh,04

    add bl,bh

    mov bh,00

    MOV CX,BX

    INPUTB

    and bx,0x0f0fh
    
    ROL bh,04

    add bl,bh
    mov bh,00
    MOV AX,CX
     SUB AL,BL
     DAS
     MOV DL,AL
     MOV AL,AH
     SBB AL,BH 
     DAS
     MOV DH,AL
     MOV CX ,0000H
     SBB CX,CX 
    PRNT DX
ENDM
    
    CONVERTB MACRO NO
    ENDM 

DATA SEGMENT

    n_line DB 0AH,0DH,"$" 

    MSG1 DB "HEY ITS THE CALCULATOR WHATS UP$"

    MSG2 DB "SOO LETS START WITH THE BASICS OF WHAT YOU CAN DO WITH IT$"

    MSG3 DB "IT CAN DO A LOT OF THINGS$"

    MSG4 DB "PRESS 1 FOR ADDITION 2 FOR SUBSTRACTION 3 FOR MULTIPLICATION 4 FOR DIVISION 5 FOR MODULUS 6 FOR SQUARE 7 FOR FACTORIAL 8 FOR CONVERSION TO HEXA DECIMAL AND 9 FOR CONVERSION TO BINARY$"    

    MSG5 DB "DO YOU WANT TO CONTINUE PRESS 1 FOR YES ELSE PRESS ANY KEY$"

DATA ENDS 

  

CODE SEGMENT

    START:

    MOV AX,DATA

    MOV DS,AX

    PRNTM MSG1

    PRNTM MSG2

    PRNTM MSG3

    PRNTM MSG4

    INPUTI 

        ;mov ax, 0x1234

        ;PRNT AX

        ;for input of variable

    ;INPUTB

    ;and bx,0x0f0fh

    ;ROL bh,04

    ;add bl,bh

    ;mov bh,00

    ;MOV CX,BX

    ;INPUTB

    ;and bx,0x0f0fh
    
    ;ROL bh,04

    ;add bl,bh

    ;mov bh,00

    ;ADDITION
    SUBTRACTION
    
     

    MOV AH,4CH

    INT 21H

CODE ENDS

    END START
    
