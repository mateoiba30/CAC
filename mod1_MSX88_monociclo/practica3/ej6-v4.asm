PIO EQU 30H;PA PB CA CB
PIC EQU 20H; EOI IMR IRR ISR INTO INT1 ...
N_F10 EQU 10; F10 ES LA INT 0

ORG 40
IP_F10 DW RUT_F10

ORG 1000H
CARS DB "???????";1RO ALMACENO, DEBO TENER ESPACIO SUFICIENTE PARA TODOS ANTES DE ENVIAR
FIN DB ?

ORG 3000H

PULSO:PUSH AX
IN AL,PIO
OR AL,02H
OUT PIO,AL;ACTIVO STROBE
IN AL,PIO
AND AL,0FDH
OUT PIO,AL;DESACTIVO STROBE
POP AX
RET

CONF_IMPR:PUSH AX
MOV AL,0FDH
OUT PIO+2,AL;CONFIGURO CA
MOV AL,0H
OUT PIO+3,AL;CONFIGURO CB
IN AL,PIO
AND AL,0FDH
OUT PIO,AL;DESACTIVO STROBE
POP AX
RET

CONF_PIC:PUSH AX
MOV AL,0FEH;11111110
OUT PIC+1,AL;IMR
MOV AL,N_F10
OUT PIC+4,AL;CARGO RUTINA DE INTERRUPCION
POP AX
RET

LEER_CARS:PUSH BX
PUSH CX
REP:INT 6
INC BX
DEC CL
JNZ REP
POP CX
POP BX
RET

RUT_F10:PUSH BX;QUIERO QUE ME MODIFIQUE CX
PUSH AX
POLL:IN AL,PIO
AND AL,1H
JNZ POLL;ESPERA A QUE EL BIT 0 DE BUSY SE DESACTIVE

MOV AL,[BX];MANDO CARACTERES
OUT PIO+1,AL
CALL PULSO
INC BX
DEC CL
JNZ POLL

MOV AL,20H;FIN
OUT PIC,AL
POP AX
POP BX
IRET

ORG 2000H
CLI
MOV CL,OFFSET FIN - OFFSET CARS;CONTADOR DE CARS
MOV BX, OFFSET CARS
CALL CONF_PIC
CALL CONF_IMPR
CALL LEER_CARS
STI;UNA VEZ CARGADO TODO ESPERO LA INTERRUPCION

ESPERAR:CMP CL,0H
JNZ ESPERAR

INT 0
END