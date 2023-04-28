PIO EQU 30H; declaro etiquetas

ORG 1000H
NUM_CAR DB 5
CAR DB ?
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

ORG 2000H
PUSH AX
CALL INI_IMP; inicializo impresora
POP AX

MOV BX, OFFSET CAR
MOV CL, NUM_CAR; contador de caracteres restantes a leer

LAZO: INT 6; leo numero

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

INT 0
END