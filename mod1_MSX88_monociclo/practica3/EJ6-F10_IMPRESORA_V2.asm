PIO EQU 30H; declaro etiquetas
PIC EQU 20H
EOI EQU 20H
N_F10 EQU 10

ORG 40
IP_F10 DW RUT_F10

ORG 1000H
NUM_CAR DB 5
CARS DB "?????"
; SUBRUTINA DE INICIALIZACION ; SUBRUTINA DE GENERACIÓN
; PIO PARA IMPRESORA ; DE PULSO 'STROBE'
ORG 3000H 
INI_IMP: MOV AL, 0FDH ;inicializo impresora
OUT PIO+2, AL ; en CA activo todo menos el bit 1
MOV AL, 0
OUT PIO+3, AL; admito todos los bits para escritura
IN AL, PIO 
AND AL, 0FDH 
OUT PIO, AL 
RET

ORG 4000H;rutina para imprimri caracetr en PB
PULSO: IN AL, PIO
OR AL, 02H;activa strobe
OUT PIO, AL
IN AL, PIO
AND AL, 0FDH
OUT PIO, AL
RET

RUT_F10:PUSH AX;INICIO IMPRESORA E IMPRIMO, RUIINA QUE EN UN EJ ANTERIOR ESTABA EN EL MAIN
MOV BX, OFFSET CARS-1
MOV CL, NUM_CAR; contador de caracteres restantes a leer
LAZO: INC BX
POLL: IN AL, PIO; espero a que no esté BUSY la impresora
AND AL, 1
JNZ POLL
MOV AL, [BX]
OUT PIO+1, AL;mando caracter a PB
PUSH AX
CALL PULSO;imprimo
POP AX
DEC CL
JNZ LAZO;repito 5 veces
mov AL,EOI
OUT EOI,AL;le indico al pic que termine la int del f10
POP AX

POP DX;PSW
POP BX; PC
INC BX; PC AL VOLVER SE SALTEA EL ESPERAR
POP BX
POP DX
IRET

ORG 2000H
MOV AL, 0FEH;habilito timer
OUT PIC+1, AL
MOV AL, N_F10
OUT PIC+4, AL

CALL INI_IMP;inicializo impresora

MOV CL,NUM_CAR;CANT CARACTERES
MOV BX, OFFSET CARS
REPETIR:INT 6
INC BX
DEC CL
CMP CL,0H
JNZ REPETIR

ESPERAR: JMP ESPERAR;ESPERO INTERRUPCION
INT 0
END