
 
 


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

CHECK MACRO
    PRNTM MSG5
    INPUTI 
    CMP BH,31
    JZ L1
    INT 21H
ENDM 
        
    CONVERTB MACRO NO
    ENDM 

DATA SEGMENT
    n_line DB 0AH,0DH,"$"   ;for new line
    
    MSG1 DB "HEY ITS THE CALCULATOR WHATS UP$"

    MSG2 DB "SOO LETS START WITH THE BASICS OF WHAT YOU CAN DO WITH IT$"

    MSG3 DB "IT CAN DO A LOT OF THINGS$"

    MSG4 DB "PRESS 1 FOR ADDITION 2 FOR SUBSTRACTION 3 FOR MULTIPLICATION 4 FOR DIVISION 5 FOR MODULUS 6 FOR SQUARE 7 FOR FACTORIAL 8 FOR CONVERSION TO HEXA DECIMAL AND 9 FOR CONVERSION TO BINARY$"    

    MSG5 DB "DO YOU WANT TO CONTINUE PRESS 1 FOR YES ELSE PRESS ANY KEY$"

DATA ENDS 

  

CODE SEGMENT
    PROC PRNT NEAR
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

ENDP
;///////////////////////////////
PRNTL PROC  ;for printing only register like al
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
ENDP    
    ;//////////////////////////////////
     
    FACT PROC NEAR
        
     INPUTB
     
    and bx,0x0f0fh
     
    ROL bh,04
     
    add bl,bh
     
    mov bh,00
     
    MOV CX,BX
    
    MOV AL,CL
    MOV AH,00H
    MOV CX,AX
    
    DEC CX
    DEC CX
    
    L10:
        CMP BL,1H
        JE L100
        DEC BL
        MUL BL
        LOOP L10
        
    L100:
        
     CALL PRNT        
        
    ENDP

    SQUARE PROC NEAR
        
     INPUTB
     
    and bx,0x0f0fh
     
    ROL bh,04
     
    add bl,bh
     
    mov bh,00
     
    MOV CX,BX    
              
     MOV AX,0000H
     MOV AL,CL
     MUL CL
     
      mov bx,ax

      LEA DX,n_line ;lea means least effective address



        MOV AH,9



        INT 21H 

    mov ax,bx
     
     CALL PRNT 
     
     
        
    ENDP
    
    
    
    HEXTODEC PROC NEAR
        
        PUSH BP
        MOV BP,SP
        MOV AX,[BP+4]
        
     CMP AL,0AH
    
    JZ L111
         
    CMP AL,0BH
    
    JZ L222
    
    CMP AL,0CH
    
    JZ L333     
    
    CMP AL,0DH
    
    JZ L444      
    
    CMP AL,0EH
    
    JZ L555 
    
    CMP AL,0FH
    
    JZ L666
    
    
    L111: MOV AL,10H
        JMP L77
    L222: MOV AL,11H
        JMP L77
    L333: MOV AL,12H
        JMP L77
    L444: MOV AL,13H
        JMP L77
    L555: MOV AL,14H
        JMP L77
    L666: MOV AL,15H
        JMP L77  
        
    L77:   
        
        MOV DL,AL
        MOV AH,00H
        MOV BL,10H
        DIV BL 
        
    CMP AH,0AH
    
    JZ L11
         
    CMP AH,0BH
    
    JZ L22
    
    CMP AH,0CH
    
    JZ L33     
    
    CMP AH,0DH
    
    JZ L44      
    
    CMP AH,0EH
    
    JZ L55 
    
    CMP AH,0FH
    
    JZ L66
    
    
    L11: MOV AH,10H
        JMP L7
    L22: MOV AH,11H
        JMP L7
    L33: MOV AH,12H
        JMP L7
    L44: MOV AH,13H
        JMP L7
    L55: MOV AH,14H
        JMP L7
    L66: MOV AH,15H
        JMP L7  
        
    L7:
        
        MOV DH,AH
        MOV AH,00H
        MOV BL,16H
        MUL BL
        MOV DL,DH
        MOV DH,00H
        ADD DX,AX
        MOV AX,DX
        
        CALL PRNT
        
        POP BP
        RET 4
        
    ENDP
    

    ;/////////////////////////////////
    SUBTRACTION PROC NEAR
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
    MOV AX,DX
     mov bx,ax
      LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H 
    mov ax,bx
    CALL PRNTL
    RET
    ENDP
    ;////////////////////////////////////////
    ADDITION PROC NEAR
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
        MOV AX,CX
         mov bx,ax
      LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H 
    mov ax,bx
        CALL PRNT
        RET
     ENDP
 ;///////////////////////////////////////////////
    PROC HEXCON NEAR      ;input in bx
        mov AL,BL
        AND BL,0X0F
        SHR AL,04
        MOV BH,0x0A
        MUL BH
        ADD BL,AL
         ;RETURNS BX
        RET
      ENDP
  ;///////////////////////////////////////////
  PROC DECCON NEAR       ;INPUT IN BX
        MOV AL,BL
        AND BL,0X0F
        SHR AL,04
        MOV BH,0X0F
        MUL BH
        ADD BL,AL        ;RETURN BX
        RET 
  ENDP
  ;////////////////////////////////////////
    PROC MULTIPLY NEAR
     INPUTB

    and bx,0x0f0fh

    ROL bh,04

    add bl,bh

    mov bh,00

    CALL HEXCON
    MOV CX,BX

    INPUTB

    and bx,0x0f0fh
    
    ROL bh,04

    add bl,bh

    mov bh,00
    CALL HEXCON 
    
    MOV AL,CL
    MUL BL
    mov bx,ax
      LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H 
    mov ax,bx 
    CALL PRNT
    RET
    ENDP
    ;//////////////////////////////////////////
    DIVISION PROC NEAR
    INPUTB
    and bx,0x0f0fh

    ROL bh,04

    add bl,bh

    mov bh,00

    CALL HEXCON
    MOV CX,BX

    INPUTB

    and bx,0x0f0fh
    
    ROL bh,04

    add bl,bh

    mov bh,00    
    
    CALL HEXCON
    MOV AX,CX 
    MOV AH,00
    DIV BL
       mov bx,ax
      LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H
    mov ax,bx 
    CALL PRNTL 
    RET
    ENDP
    ;/////////////////////////////
    MODULUS PROC NEAR
    INPUTB
    and bx,0x0f0fh

    ROL bh,04

    add bl,bh

    mov bh,00

    CALL HEXCON
    MOV CX,BX

    INPUTB

    and bx,0x0f0fh
    
    ROL bh,04

    add bl,bh

    mov bh,00    
    
    CALL HEXCON
    MOV AX,CX 
    MOV AH,00
    DIV BL
    MOV AH,AL
    CALL PRNTL 
    RET
        ENDP
        ;/////////////////////////////////////////////
    START:

    MOV AX,DATA

    MOV DS,AX

    PRNTM MSG1

    PRNTM MSG2

    PRNTM MSG3

    PRNTM MSG4
    L1:
    INPUTI
        
        CMP BH,31H
        JZ L2 
         CMP BH,32H
        JZ L3
         CMP BH,33H
        JZ L4
         CMP BH,34H
        JZ L5
        CMP BH,35H
        JZ L6
        ;CMP BH,36H
        ;JZ L7
       ; CMP BH,37H
       ; JZ L8
        CMP BH,38H
        JZ L9
        ;CMP BH,39H
        ;JZ L10
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
    ;SUBTRACTION
    L2: CALL ADDITION
    L3:CALL SUBTRACTION
    L4: CALL MULTIPLY
    L5: CALL DIVISION
    
    L6:CALL MODULUS
    L9:INPUTB

    and bx,0x0f0fh
    
    ROL bh,04

    add bl,bh

    mov bh,00
    CALL HEXCON
    MOV AL,BL
    CALL PRNTL
    
    MOV AH,4CH

    INT 21H

CODE ENDS

    END START
    
