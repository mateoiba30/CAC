;doy valores a etiquetas
PIC EQU 20H;pic apunta a su 1er resgistro EOI
EOI EQU 20H
N_F10 EQU 10;linea de interrupcion de la tabla de interrupciones

ORG 40;elegí la linea 10, de 4 bytes cada una, entonces es la 40(10)
IP_F10 DW RUT_F10; N_F10 nos lleva a RUT_F10, que es una rutina de interrupcion

ORG 1500H
CHAR DB ?

ORG 2000H
CLI;desabilita interrupciones por HARDWARE

MOV AL, 0FEH; 11111110 = habilita la int 0, interrupcion de F10
OUT PIC+1, AL ; a IMR cargo FE
MOV AL, N_F10
OUT PIC+4, AL ; PIC: registro INT0 le cargo la linea de interrupcion correspondiente

STI

MOV CL,41H;A
REPETIR:INC CL
CMP CL,5AH
JNZ REPETIR
MOV CL,41H
JMP REPETIR

ORG 3000H
RUT_F10: PUSH AX
INC DX

MOV CHAR,CL
MOV BX, OFFSET CHAR
MOV AL, 1
INT 7

MOV AL, EOI
OUT EOI, AL ; PIC: registro EOI en 20H le mando 20H para indicar fin
POP AX
IRET
END

;EOI 20H, IMR, IRR, ISR, INT0... INT7 -> DIRECCIONES CONSECUTIVAS
;TODOS ESTOS REGISTROS SON PROGRAMABLES
;SI USO IN o OUT INDICO QUE OPERO CON MEMORIA DE E/S