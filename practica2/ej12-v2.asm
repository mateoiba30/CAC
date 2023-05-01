PIC EQU 20H; EOI IMR IRR ISR INT0 INT1(TIMER)
TIMER EQU 10H;CONT COMP
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 1000H
DSEG DB 30H
USEG DB 2FH;1RO INC, DESPUES IMPRIMO
ESPACIO DB 20H

ORG 3000H

CONF_PIC:PUSH AX
MOV AL,11111101B
OUT PIC+1,AL
MOV AL,N_CLK
OUT PIC+5,AL
POP AX
RET

CONF_CLK:PUSH AX
MOV AL,0
OUT TIMER,AL
MOV AL,1
OUT TIMER+1,AL
POP AX
RET

RUT_CLK:PUSH AX
PUSH BX
PUSH DX

MOV BX,OFFSET USEG;ANALIZO UNIDADES
MOV DL,[BX]
CMP DL,39H
JNZ SALTO
MOV USEG,2FH
INC DSEG
SALTO:INC USEG

MOV BX,OFFSET DSEG;ANALIZO DECENAS
MOV DL,[BX]
CMP DL,36H;YA INCREMENTADO ANTES, COMPARO DE NO LLEGAR AL 6
JNZ SALTO2
MOV USEG,30H
MOV DSEG,30H;NO OLVIDAR QUE SON CARACTERES

SALTO2:MOV BX,OFFSET DSEG;IMPRIMO EN ORDEN
INT 7
MOV BX, OFFSET USEG
INT 7
MOV BX, OFFSET ESPACIO
INT 7

MOV AL,0;REINICIO TIMER
OUT TIMER,AL

MOV AL,20H;FIN
OUT PIC,AL

POP DX
POP BX
POP AX
IRET

ORG 2000H
CLI
CALL CONF_PIC
CALL CONF_CLK
MOV AL,1
STI

ESPERAR: JMP ESPERAR;ESPERO INTERRUPCION DEL REOJ

INT 0;=HLT
END