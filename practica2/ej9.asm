
MOV BX,DX
PUSH DX
ORG 1000H
MSJ DB  "ACCESO PERMITIDO"
MSJ2 DB "ACCESO DENEGADO "
CLAVE DB "1234";las claves hacerlas caracteres!!!

ORG 1500H
NUM DB "XXXX"; TABLA DE CARACTERES

ORG 2000H
MOV DX, OFFSET NUM
MOV CX, OFFSET CLAVE

MOV DX,0
FOR:INT 6;leo num
INC BX
INC DL
CMP DL,4H
JNZ FOR
POP DX;recupero el valor del offset

MOV BX,0
WHILE:PUSH BX;guardo contador de vueltas
MOV BX, CX
MOV AH, [BX]
MOV BX, DX
MOV AL, [BX]
CMP AH,AL;comparo caracter a caracter de num y clave
JNZ FALSO;caracter distinto
INC DX;avanzo de caracter
INC CX;avanzo de caracter
POP BX
INC BX
CMP BX,4H;me fijo si termine las vueltas
JNZ WHILE

MOV BX, OFFSET MSJ;si son iguales
JMP MENSAJE
FALSO:MOV BX, OFFSET MSJ2;si no son iguales

MENSAJE:MOV AL,16
INT 7
INT 0
END