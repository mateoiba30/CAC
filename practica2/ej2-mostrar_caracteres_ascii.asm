ORG 1000H
MSJ DB 01H	

ORG 2000H
MOV BX, OFFSET MSJ; puntero al inicio del mensaje
MOV AL, 1;cantidad de caracteres de mensaje

FOR: INT 7;escribo
MOV DL,[BX]
INC DL;paso al sig caracter, no se puede hacer INC [BX]
MOV [BX],DL;cambio valor en memoria
CMP DL, 0FFH;me fijo si termine
JNZ FOR;si no da cero, si no son iguales

INT 0
END