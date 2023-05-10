ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1500H
NUM1 DB ?;podría declararlo en otro lugar
NUM2 DB ?

;MAXIMO VALOR 9(10)
;MINIMO RESULTADO -9(10), que se representa con valores menores o iguales a FFH
ORG 2000H

MOV AL,1H
MOV BX, OFFSET NUM1
INT 6;leo num

MOV BX, OFFSET NUM2
INT 6
;la maxima suma es de 18(10) = 12(16)
;si el res es mayor a 9 debo primero imprimir cl-10(10) y desp un uno

MOV CL, [BX]; CL tiene num2
SUB CL, NUM1; al=num2 - num1 en 1 celda de hexadecimal
;el 30h ya se lo restan entre ellos

CMP CL,0
JNS SALTO2;si no es menor a 0, en realidad es positivo
MOV BYTE PTR [BX], 2DH;imprimo signo y le resto el bit de signo que vale 2^7
INT 7
DEC CL
NOT CL
;FFH = -1 -> le tengo que restar 1 y hacer el complemento

SALTO2: ADD CL,30H ; PASO A CHAR
MOV BYTE PTR [BX],CL;tiene la suma en numeros
INT 7

INT 0
END