PIC EQU 20H; EOI IMR IRR ISR INT0 INT1(TIMER)
TIMER EQU 10H;CONT COMP
PIO EQU 30H; PA PB CA CB
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 1200H
NUMEROS DB "?????"

ORG 3000H 

ROTARIZQ:ADD CH,CH
ADC CH,0
RET

RUT_CLK:MOV CH,00000001B
MOV DL,[BX]
INC BX
DEC CL

SUB DL,30H;LO PASO A NUMERO
CMP DL,0
JZ IMPRIMIR
REP2:CALL ROTARIZQ;ROTA CH
DEC DL
JNZ REP2
IMPRIMIR:MOV AL,CH
OUT PIO+1,AL

MOV AL,0
OUT TIMER,AL
MOV AL,20H
OUT PIC,AL
IRET

CONF_PIC:MOV AL,11111101B
OUT PIC+1,AL
MOV AL,N_CLK
OUT PIC+5,AL
RET

CONF_PIO:MOV AL,0
OUT PIO+3,AL
RET

CONF_CLK:MOV AL,0
OUT TIMER,AL
MOV AL,1
OUT TIMER+1,AL
RET

LEER_NUMS:PUSH BX
PUSH CX
REP:INT 6
INC BX
DEC CL
JNZ REP
POP CX
POP BX
RET

ORG 2000H
CLI 
MOV CL,5H
MOV BX,OFFSET NUMEROS
CALL CONF_PIC
CALL CONF_PIO
CALL CONF_CLK
CALL LEER_NUMS
STI

ESPERAR: CMP CL,0H
JNZ ESPERAR

INT 0
END