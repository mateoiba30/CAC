ORG 1000H
L_A DB 41H;valor de A
L_a DB 61H; valor de a	
;la ultima letra a imprimir es la z de valor 90=5AH

ORG 2000H
MOV BX, OFFSET L_A; puntero al inicio del mensaje
MOV AL, 1;cantidad de caracteres de mensaje
MOV AH, L_a;
SUB AH, L_A; AH tiene la dif de caracteres entre may y min

FOR: INT 7;escribo mayuscula
MOV DL,[BX]
MOV DH, DL;dh tiene una copia de dl
ADD DL, AH;dl tiene la minuscula
MOV [BX], DL;cambio valor en memoria
INT 7;imprimo minuscula

MOV DL, DH;recupero el valor de la mayuscula
INC DL;paso al sig caracter, no se puede hacer INC [BX]
MOV [BX],DL;cambio valor en memoria

CMP DL, 5BH;me fijo si termine con (z + 1) porque arriba incrementé
JNZ FOR;si no da cero, si no son iguales, repito

INT 0
END