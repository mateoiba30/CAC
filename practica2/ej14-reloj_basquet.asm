

TIMER EQU 10H; doy valores a etiquetas, 1er reg: COMP
PIC EQU 20H; inicio del pic
EOI EQU 20H; inicio del pic, su 1er registro
N_F10 EQU 10
N_CLK EQU 20
N_F10FIN EQU 30

ORG 40
IP_F10 DW RUT_F10

ORG 80
IP_CLK DW RUT_CLK

ORG 120
IP_F10FIN DW RUT_FIN

ORG 1000H
SEG DB 30H; decenas 
SEG2 DB 30H; unidades
ESPA DB 20H
FIN DB ?

ORG 3000H

RUT_F10: PUSH AX
INC DX

MOV AL, 0FDH; 11111101 -> enmascaro todas las int menos la del timer Y F10
OUT PIC+1, AL ; PIC: registro IMR le mando activar timer
MOV AL, N_CLK
OUT PIC+5, AL ; PIC: registro INT1 del timer le mando 10=nro de instruccion del vector de interrupciones
MOV AL, 1
OUT TIMER+1, AL ; TIMER: registro COMP, le mando el valor con el cual comparar
MOV AL, 0
OUT TIMER, AL ;TIMER: registro CONT le mando el valor con el que inicia el contador

MOV AL, EOI
OUT EOI, AL ; PIC: registro EOI en 20H le mando 20H para indicar fin
POP AX
IRET

RUT_CLK: PUSH AX

CLI
MOV AL, 0FEH; 11111110 = habilita la int 0, interrupcion de F10
OUT PIC+1, AL ; a IMR cargo FE
MOV AL, N_F10FIN
OUT PIC+4, AL ; PIC: registro INT0 le cargo la linea de interrupcion correspondiente
MOV BX, OFFSET SEG; para imprimir al llamar int los segundos
MOV AL, OFFSET FIN-OFFSET SEG

INC SEG2

CMP SEG2, 3AH
JNZ RESET; a la decima vuelta no salta, las unidades llegaron a una decema
MOV SEG2, 30H;reinicio unidades
INC SEG; incremento decenas

CMP SEG, 33H;entra en total 3 veces a la comparacion, es un contador de 1 minuto
JZ FIN2

RESET: INT 7; imprime seg con 2 caracteres, por lo tanto imprime seg2 tambien
MOV AL, 0
OUT TIMER, AL; mando 0 a CONT para que al volver al main vuelva a interrumpir
MOV AL, EOI
OUT PIC, AL; le digo terminar al PIC q terminé esta interrupción
POP AX

STI
JMP RUT_CLK
FIN2: IRET

ORG 2000H
CLI; desactivo otras interrupciones

RUT_FIN:MOV AL, 0FEH; 11111110 = habilita la int 0, interrupcion de F10
OUT PIC+1, AL ; a IMR cargo FE
MOV AL, N_F10
OUT PIC+4, AL ; PIC: registro INT0 le cargo la linea de interrupcion correspondiente

STI

CMP SEG, 33H
JZ FIN3
LAZO: JMP LAZO;repite hasta ser interrumpido por el timer que espera 1 segun
FIN3:HLT
END