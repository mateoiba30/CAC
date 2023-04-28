PIC EQU 20H; como no uso polling debo usar interrupciones y configurar el PIC
HAND EQU 40H;defino etiquetas
N_HND EQU 10

ORG 40 
IP_HND DW RUT_HND;redirecciono a la rutina para imprimir

ORG 3000H 
RUT_HND: PUSH AX 

MOV AL, [BX]
OUT HAND, AL ;al DATO le paso el caracter actual, lo guarda en el buffer
INC BX ;pasa a siguiente caracter
DEC CL ;decremento contador de caracteres
MOV AL, 20H 
OUT PIC, AL;indico que terminó la interrupción

POP AX 
IRET 
;HAND SHAKE EMITE UNA INTERRUPCION CUANDO LA IMPRESORA SE DESOCUPA, NO ESTA BUSY
ORG 1000H
MSJ DB "U"
FIN DB ?

ORG 2000H
MOV BX, OFFSET MSJ
MOV CX, OFFSET FIN - OFFSET MSJ; en realidad solo CL se queda con valores despues de la resta

CLI;configuro hand y pic
MOV AL, 0FBH; 11111011
OUT PIC+1, AL; IMR activa HAND
MOV AL, N_HND
OUT PIC+6, AL; le cargo la rutina de interrupcion

;configuro hand para interrupcion
MOV AL, 80H; 10000000
OUT HAND+1, AL; desactivo todo menos la linea de interrupcion
STI

LAZO: CMP CL, 0;puede estar ocupada por carga de caracter o por estar imprimiendo alguno
JNZ LAZO

IN AL, HAND+1
AND AL, 7FH; 11111111
OUT HAND+1, AL;desactivo interrupciones para que la impresora no lea nada mas

INT 0
END