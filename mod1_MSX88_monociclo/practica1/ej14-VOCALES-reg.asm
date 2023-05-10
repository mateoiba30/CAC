ORG 1000H
CADENA DB "fweAfga"
CAD_VOCALES DB "aeiouAEIOU"
AUX DB ?

ORG 3000H; recibe el puntero a inicio en BX
VOCALES:MOV DH, 0;contador de vocales
MOV CX, OFFSET CAD_VOCALES

REP2:MOV AL, [BX]; AL tiene el valor a analizar de CADENA
PUSH BX
PUSH CX
CALL ES_VOCAL; quiero que no me modifique BX ni CX, el resto pueden cambiar
POP CX
POP BX

CMP DL, 0FFH
JNZ SALTO2
INC DH
SALTO2:INC BX
CMP BX, CX
JNZ REP2; reitero en dos los caracteres
RET

ES_VOCAL:MOV BX, CX; AL recibe el valor del caracter a comparar
MOV DL,0
MOV CL, 10; cant de vocales
REP:CMP [BX], AL
JNZ SALTO
MOV DL, 0FFH
JMP FIN
SALTO:INC BX
DEC CL
JNZ REP
FIN:RET

ORG 2000H;CAR POR VALOR
MOV BX, OFFSET CADENA
CALL VOCALES; en DH guarda el contador
HLT
END
