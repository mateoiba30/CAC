HAND EQU 40H;defino etiquetas
PIC EQU 20H
N_HND EQU 10

ORG 40
IP_NHND DW RUT_HND

ORG 1000H
NUMS DB "?????"
FIN DB ?

ORG 3000H

HAB_HAND:CLI
MOV AL,80H
OUT HAND+1,AL
STI
RET

DESHAB_HAND:IN AL, HAND+1
AND AL,07FH
OUT HAND+1,AL
RET

CONF_PIC:CLI
PUSH AX
MOV AL, 0FBH
OUT PIC+1,AL
MOV AL, N_HND
OUT PIC+6, AL
POP AX
STI
RET

RUT_HND:PUSH AX
CMP CH,0
JNZ REVERSA

MOV AL,[BX]
INC BX
OUT HAND,AL
DEC CL

CMP CL,0
JNZ FIN2
DEC BX;BX SE HABÍA PASADO POR 1 CARACTER
NOT CH;INDICO CAMBIO DEL RECORRIDO
MOV CL, OFFSET FIN - OFFSET NUMS;reinicio contador para ir en reversa
JMP FIN2

REVERSA:MOV AL,[BX];BX YA APUNTA AL FINAL
DEC BX
OUT HAND, AL
DEC CL

FIN2:MOV AL, 20H
OUT PIC, AL
POP AX

;CMP CL,0 ;NECESARIO PARA QUE TERMINE SI TENGO UN ERIFERICO RAPIDO
;JNZ FIN3
;JMP FIN4

FIN3:IRET

LEER_CARACTERES:PUSH BX
PUSH DX

MOV DL,0
MOV BX, OFFSET NUMS
REP:INT 6
INC BX
INC DL
CMP DL,CL
JNZ REP

POP DX
POP BX
RET

ORG 2000H
MOV CL, OFFSET FIN - OFFSET NUMS;CONTADOR DE CARACTERES
MOV BX, OFFSET NUMS
CALL LEER_CARACTERES
CALL CONF_PIC
CALL HAB_HAND

ESPERAR:CMP CL,0H
JNZ ESPERAR

FIN4:CALL DESHAB_HAND;para que no me interrumpa mas

INT 0
END