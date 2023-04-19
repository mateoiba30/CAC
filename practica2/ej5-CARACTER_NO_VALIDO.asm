ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
MSJ2 DB "CARACTER NO VALIDO"
FIN DB ?

ORG 1500H
NUM DB ?;podría declararlo en otro lugar

ORG 3000H;VERIFICO QUE EL CARACTER SESA UN NRO, ENTRE 48 Y 57
ES_NUM:MOV DH, 2FH;esto es el cero -1 
MOV DL,[BX];dl tiene lo ingresado NUM=[BX]
MOV AH,0

WHILE:CMP DH,3AH;si me pasé del 9 no entro
JZ FIN1;si me pasé del 9 salgo del bucle
INC DH;PASO AL SIG NRO
CMP DL,DH;si son iguales termino
JNZ WHILE;si no son iguales repito
MOV AH,0FFH;si es num, ah vale 1
FIN1:RET

ORG 2000H
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ2;tamanio de AMBOS MENSAJES ES 18
INT 7;pido num
MOV BX, OFFSET NUM;pa leer num
INT 6;el la dir que dice bx guarda el num ingresado
CALL ES_NUM

CMP AH,0FFH;da cero si es un numero
JZ SALTO;SI ES CERO, osea si ingrese un numero, NO IMPRIMO NADA
MOV BX, OFFSET MSJ2;si es num
INT 7

SALTO:INT 0
END