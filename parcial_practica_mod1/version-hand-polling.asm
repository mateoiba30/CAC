;HAND Y POLLING -> NO HAY INTERRUPCIONES, ME DEBO ENCARGAR DE BUSY PERO NO DE STROBE
HAND EQU 40H; DATOS ESTADO

ORG 1000H
CADENA DB "ABDef"
FIN DB ?

ORG 3000H

SELECCIONADO:MOV DH,0
CMP DL,41H
JS FIN1
CMP DL,5BH
JNS FIN1
MOV DH,1H
FIN1:RET

CONF_HND:PUSH AX
IN AL,HAND+1
AND AL, 01111111B;DESACTIVAR INTS,A STROBE NO LO TOCO
OUT HAND+1,AL
POP AX
RET

ORG 2000H
CALL CONF_HND
MOV BX, OFFSET CADENA
MOV CL, OFFSET FIN - OFFSET CADENA

POLL:IN AL,HAND+1
AND AL,1
JNZ POLL;SI NO ES CERO, SI NO ESTÁ BUSY SIGO ESPERANDO

MOV DL,[BX]
CALL SELECCIONADO;BX TIENE LA DIR DEL CARACTER, LE MANDO POR DL EL CARACTER, CL ES EL CONTADOR, DH INDICA SI ES MAY O MIN
CMP DH,1H
JNZ MINUSCULA
MOV AL,[BX]
OUT HAND,AL;MANDO A IMPRIMRI
MINUSCULA:INC BX
DEC CL
JNZ POLL

INT 0
END