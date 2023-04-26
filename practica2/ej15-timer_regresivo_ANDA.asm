TIMER EQU 10H; doy valores a etiquetas, 1er reg: COMP
PIC EQU 20H; inicio del pic
EOI EQU 20H; inicio del pic, su 1er registro
N_F10 EQU 10
N_CLK EQU 20

ORG 40
IP_F10 DW RUT_F10

ORG 80
IP_CLK DW RUT_CLK

ORG 1000H

MSJ DB "DECENAS:  "
MSJ2 DB "UNIDADES: "
NUM DB ?; DECENAS
NUM2 DB ?; UNIDADES
ESPA DB 20H
FIN DB ?

ORG 3000H

RUT_F10:PUSH AX
MOV AL,0FCH; habilito interrupciones del timer
OUT PIC+1,AL
MOV AL,EOI
OUT EOI,AL;le indico al pic que termine la int del f10
POP AX
IRET

RUT_CLK: PUSH AX
DEC NUM2

CMP NUM2, 2FH; la unidad es menor a cero
JNZ RESET; a la decima vuelta no salta, las unidades llegaron a una decema
MOV NUM2, 39H;reinicio unidades
DEC NUM; incremento decenas

CMP NUM, 2FH; termino
JZ FIN2

RESET: INT 7; imprime seg con 2 caracteres, por lo tanto imprime seg2 tambien
MOV AL, 0
OUT TIMER, AL; mando 0 a CONT para que al volver al main vuelva a interrumpir
MOV AL, EOI
OUT PIC, AL; le digo terminar al PIC q terminé esta interrupción
POP AX
;EL RELOJ VUELVE A INTERRUMPIR SIN NECESIDAD DE LLAMAR A RUT_CLK, PORQUE REINICIÉ EL TEMPORIZADOR
FIN2: IRET


ORG 2000H

CLI
MOV AL, 0FEH; 11111110 = habilita la int 0, interrupcion de F10
OUT PIC+1, AL ; a IMR cargo FE
MOV AL, N_F10
OUT PIC+4, AL ; PIC: registro INT0 le cargo la linea de interrupcion correspondiente

MOV AL, N_CLK
OUT PIC+5, AL ; PIC: registro INT1 del timer le mando 10=nro de instruccion del vector de interrupciones
MOV AL, 1
OUT TIMER+1, AL ; TIMER: registro COMP, le mando el valor con el cual comparar
MOV AL, 0
OUT TIMER, AL ;TIMER: registro CONT le mando el valor con el que inicia el contador
STI

MOV AL, 10
MOV BX, OFFSET MSJ
INT 7
MOV BX, OFFSET NUM;LEO DECENAS
INT 6
MOV BX, OFFSET MSJ2
INT 7
MOV BX, OFFSET NUM2;LEO UNIDADES
INT 6

MOV AL, OFFSET FIN - OFFSET NUM; MOV AL, 2
MOV BX, OFFSET NUM

LAZO: JMP LAZO;repite hasta ser interrumpido por el timer que espera 1 segun
FIN3:HLT
END