PIC EQU 20H
PIO EQU 30H
N_F10 EQU 10

ORG 40
IP_F10 DW RUT_F10

ORG 3000H

CONF_PIC:MOV AL,11111110B
OUT PIC+1,AL
MOV AL,N_F10
OUT PIC+4,AL
RET

CONF_PIO:MOV AL,0H
OUT PIO+3,AL
MOV AL,CL
OUT PIO+1,AL
RET

RUT_F10:ADD CH,CL
MOV AL,CH
OUT PIO+1,AL

CMP CH,0FFH
JNZ SIGO
MOV CL,10000000B
MOV CH,0H
JMP FIN
SIGO:CALL ROTDER
FIN:MOV AL,20H
OUT PIC,AL
IRET

ROTDER:PUSH DX
MOV DH,7
REP:CALL ROTIZQ
DEC DH
JNZ REP
POP DX
RET

ROTIZQ:ADD CL,CL
ADC CL,0
RET

ORG 2000H
CLI
CALL CONF_PIC
CALL CONF_PIO
MOV CL,10000000B
MOV CH,0H
STI

ESPERAR:JMP ESPERAR;CL TIENE EL BIT ACTUAL
;CH INDICA LA SUMA ANTERIOR

INT 0
END