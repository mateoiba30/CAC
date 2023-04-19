ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?
CERO DB "CERO  "
UNO DB "UNO   "
DOS DB "DOS   "
TRES DB "TRES  "
CUATRO DB "CUATRO"
CINCO DB "CINCO "
SEIS DB "SEIS  "
SIETE DB "SIETE "
OCHO DB "OCHO  "
NUEVE DB "NUEVO "

ORG 1500H
NUM DB ?;podría declararlo en otro lugar

ORG 2000H

REPETIR:MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ;tamanio de MENSAJE ES 18
INT 7;pido num

MOV BX, OFFSET NUM
INT 6;leo num
MOV CL,[BX];CL tiene lo ingresado
MOV CH,0
SUB CX,30H;paso del valor del caracter al valor del numero ;INGRESO CARACTERES, NO NUMEROS

CMP CX, 0H
JZ SALTO
MOV DX,0; PONER CONTADOR EN DX Y PUSH Y POP
JMP SALTO2
SALTO:INC DX;cuento ceros seguidos
SALTO2:PUSH DX

MOV AH,0H;contador de vueltas
MOV DH,0
MOV DL, CL;DL tiene una copia, mientras CX guarda la suma
FOR:ADD CX,DX;OPERO CON 2 REGISTROS POR SI EL NUMERO CRECE MUCHO
INC AH
CMP AH,5H;LA PRIMERA VUELTA YA MULTIPLICA POR 2
JNZ FOR;si no es la sexta rep repito
POP DX

MOV AL,6H;tamanio de los otros mensajes
MOV BX, OFFSET CERO
ADD BX, CX;si le sumo 6n cambio al mensaje del numero n
INT 7

CMP DX,2H
JNZ REPETIR;repito si no puse dos ceros seguidos


INT 0
END