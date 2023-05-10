ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1500H
NUM DB ?;podría declararlo en otro lugar

ORG 2000H
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
INT 7;en BX tengo la dir del inicio del bloque de caracteres
;en AL el tamaño del bloque de caracteres

MOV BX, OFFSET NUM
INT 6;el la dir que dice bx guarda el num ingresado
MOV AL, 1
INT 7;imprime el numero ingresado
MOV CL, NUM
INT 0
END