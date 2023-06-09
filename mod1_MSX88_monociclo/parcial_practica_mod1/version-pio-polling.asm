PIO EQU 30H; PA PB CA CB
;ES POR POLLING, NO HAY INT -> NO HA PIC
;DEBO MANERJAR EL STROBE Y EL BUSY

ORG 1000H
CADENA DB "ABDde"
FIN DB ?

ORG 3000H

SELECCIONADO:MOV DH,0
CMP DL,41H
JS FIN1
CMP DL,5BH
JNS FIN1
MOV DH,1
FIN1:RET

CONF_PIO:PUSH AX
MOV AL,0FDH
OUT PIO+2,AL
MOV AL,0H
OUT PIO+3,AL
IN AL,PIO
AND AL,11111101B
OUT PIO,AL;DESACTIVO STROBE
POP AX
RET

PULSO:PUSH AX
IN AL,PIO
OR AL,00000010B
OUT PIO,AL;ACTIVO STROBE
IN AL,PIO
AND AL,11111101B
OUT PIO,AL;DESACTIVO STROBE
POP AX
RET

ORG 2000H
CALL CONF_PIO
MOV BX, OFFSET CADENA
MOV CL, OFFSET FIN - OFFSET CADENA;CONTADOR

POLL:MOV AL,PIO
AND AL,1
JNZ POLL;SI NO ES CERO, ESTÁ OCUPADA

MOV DL,[BX]
CALL SELECCIONADO;RECIBE CARACTER EN DL, MODIIFCA DH SI ES CARACTER, A CL QUE ES EL CONTADOR, BX QUE AVAMZA
CMP DH,1H
JNZ MINUSCULA
MOV AL,[BX]
OUT PIO+1,AL
CALL PULSO
MINUSCULA:INC BX
DEC CL
JNZ POLL

INT 0
END