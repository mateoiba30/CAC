PIO EQU 30H;PA PB CA CB
TIMER EQU 10H; CONT COMP -> INT1
PIC EQU 20H; EOI IMR IRR ISR INTO INT1 ...
N_CLK EQU 10

ORG 40
IP_CLK DW RUT_CLK

ORG 3000H

ROTARIZQ:ADD CL,CL;ROTO LO QUE TENGO EN CL 1 VEZ
ADC CL,0
RET

ROTARDER:PUSH DX;7 A LA IZQ= 1 A LA DER
MOV DX,7
REP:CALL ROTARIZQ
DEC DX
CMP DX,0
JNZ REP
POP DX
RET

RUT_CLK:MOV AL,CL
OUT PIO+1,AL;MANDO NUMERO A IMPRIMIR

CMP CH,0;VEO SENTIDO
JZ IZQ
CALL ROTARDER
JMP SALTO
IZQ:CALL ROTARIZQ

SALTO:INC AH
CMP AH,7H;ME FIJO SI DEBO CAMBIAR SENTIDO
JNZ NO_CAMBIO
NOT CH
MOV AH,0;REINICIO CONTADOR DE VUELTAS

NO_CAMBIO:MOV AL,0
OUT TIMER,AL;REINICIO CONTADOR

MOV AL,20H;FIN
OUT PIC,AL
IRET

ORG 2000H
CLI
MOV CL,1;CL TIENE EL NUMERO A IMPRIMIR, QUE SE LE MANDA A PB
;CH INDICA EL SENTIDO (0 PARA ROTAR A LA IZQUIERDA)
;AH CONTADOR DE VUELTAS EN UN SENTID

MOV AL,0
OUT PIO+3,AL;CB LE DICE A PB QUE USA TODOS LOS BITS
OUT PIO+1,AL;EMPIEZAN LKUCES APAGADAS PA EMPROLIJAR -> NO NECESARIO

MOV AL,0FDH;11111101
OUT PIC+1,AL;IMR

MOV AL, N_CLK
OUT PIC+5,AL;DIGO RUTINA A USAR POR EL TIMER

MOV AL,0
OUT TIMER,AL;CONTADOR EN CERO
MOV AL,1
OUT TIMER+1,AL;COMPARADOR EN 1

STI;CONFIGURE TODO, LISTO A QUE EL TIMER ME INTERRUMPA

ESPERAR: JMP ESPERAR

INT 0
END