HAND EQU 40H;defino etiquetas

ORG 1000H
MSJ DB "INGENIERIA E ";defino mensajes a imprimir
DB "INFORMATICA"
FIN DB ?

ORG 2000H
IN AL, HAND+1;CONFIGURO HAND
AND AL, 7FH;comparo el valor del handshake con 01111111-> desactiva linea int
OUT HAND+1, AL

MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN-OFFSET MSJ

POLL: IN AL, HAND+1
AND AL, 1; se fija si el bit 0 está prendido (en lectura indica si está BUSY al ser 1)
JNZ POLL; repite hasta que la impresora esté lista

MOV AL, [BX]
OUT HAND, AL; al reg de dato le mando caracter a imprimir
INC BX; voy al sig caracter
DEC CL;decremento contador de caacteres restantes
JNZ POLL

INT 0
END