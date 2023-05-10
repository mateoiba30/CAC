ORG 1000H
MSJMAL DB "CLAVE INCORRECTA"
MSJBIEN DB "CLAVE CORRECTA  "
CLAVE DB "1234"
MENSAJE DB "INGRESE CALVE DE 4 CARACTERES: "
NUM DB "????"

ORG 2000H
MOV AL, OFFSET NUM - OFFSET MENSAJE;MANDO MENSAJE
MOV BX, OFFSET MENSAJE
INT 7

MOV CL,4H;LEO CARACTERES
MOV BX, OFFSET NUM
REP1:INT 6
INC BX
DEC CL
JNZ REP1

MOV CX,-1;CORRIMIENTO Y CONTADOR
REP2:INC CX
MOV BX, OFFSET NUM
ADD BX, CX
MOV DH, [BX]

MOV BX, OFFSET CLAVE
ADD BX,CX

CMP DH,[BX]
JZ REP2

CMP CX,4;SI ES 4 ES PORQ COINCIDE
JNZ MAL
MOV BX, OFFSET MSJBIEN

JMP SALTO
MAL:MOV BX, OFFSET MSJMAL

SALTO:MOV AL,OFFSET MSJBIEN - OFFSET MSJMAL
INT 7

INT 0
END