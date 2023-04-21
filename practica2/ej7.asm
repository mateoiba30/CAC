ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1500H
NUM1 DB ?;podría declararlo en otro lugar
NUM2 DB ?

ORG 2000H
MOV AL,1H
MOV BX, OFFSET NUM1
INT 6;leo num

MOV BX, OFFSET NUM2
INT 6
;la maxima suma es de 18(10) = 12(16)
;si el res es mayor a 9 debo primero imprimir cl-10(10) y desp un uno

MOV CL, [BX]; CL tiene num2
ADD CL, NUM1; al=num1 + num2 en 1 celda de hexadecimal
SUB CL, 60H; llevo al valor numerico

CMP CL, 10
JS SALTO; si no hay signo, cl>=10
MOV BYTE PTR [BX], 31H ;si es mayor a nueve primero imprimo 1 y desp le resto 10 a cl
INT 7
SUB CL,10
SALTO:ADD CL,30H ; PASO A CHAR
MOV BYTE PTR [BX],CL;tiene la suma en numeros
INT 7

INT 0
END