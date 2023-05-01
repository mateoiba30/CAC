PIC EQU 20H; EOI IMR IRR ISR INT0 (F10)
N_F10 EQU 10

ORG 40
IP_F10 DW RUT_F10
LETRA DB "?"

ORG 1000H

CONF_PIC:PUSH AX
MOV AL,11111110B
OUT PIC+1,AL
MOV AL,N_F10
OUT PIC+4,AL
POP AX
RET

RUT_F10:PUSH AX
INC CL
MOV AL,20H
OUT PIC,AL
POP AX
IRET

ORG 2000H
CLI
CALL CONF_PIC
MOV DX,41H;'A'
MOV CL,0
STI

ESPERAR:INC DX
CMP DX,5BH;ME PASE DE LA Z?
JNZ SALTO
MOV DX,41H
SALTO:CMP CL,0
JZ ESPERAR

MOV BX,OFFSET LETRA
MOV [BX],DX
MOV AL,1
INT 7

INT 0
END