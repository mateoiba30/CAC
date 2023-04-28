PIC EQU 20H; defino etiquetas
TIMER EQU 10H
PIO EQU 30H
N_CLK EQU 20

ORG 80
IP_CLK DW RUT_CLK

ORG 2000H ; muestro numeros del contador con luces, en binario
CLI
MOV DL,1;indica que hay que rotar a la izqueirda
MOV DH,-1;la 1ra vez hace 1 demás
MOV CH,1; numero q indica luz

MOV AL,0FCH; habilito interrupciones del timer
OUT PIC+1,AL
MOV AL, N_CLK
OUT PIC+5, AL ; le mando la dir de la interrupcion al timer, INT1

MOV AL, 1 
OUT TIMER+1, AL ; le mando 1 al comparador
MOV AL, 0 
OUT TIMER, AL ;inicio contador en cero

OUT PIO+3, AL ;CB tiene todo 0, entonces habilita todas las luces
OUT PIO+1, AL ;PB tiene todo en cero, por ahora no prende ninguna luz

STI ;no programo PA ni CA porque son para la entrada, los microcontroladores, los cuales ahora no uso
LAZO: JMP LAZO; espero interrupcion

ORG 3000H

ROTARDER:CALL ROTARIZQ
DEC AL
CMP AL,0
JNZ ROTARDER
RET;NO OLVIDAR EL RET

ROTARIZQ:ADD CL,CL
ADC CL,0;SI EN LA OPERACION ANTERIOR SE PRENDIO EL FLAG, ENTONCES AGREGO UNO AL FINAL
RET

RUT_CLK:INC DH
MOV CL,CH
CMP DH,7;hago 8 para un lado y 8 para otra
JNZ SALTO2
MOV DH,0
NOT DL;INVIERTE EL BIT

SALTO2:AND DL,1;si dl es 1 va a la izq, sino a la der
JZ DERECHA
MOV AL,1
CALL ROTARIZQ
JMP FIN
DERECHA:MOV AL,7
CALL ROTARDER

FIN:MOV CH,CL
LUCES: MOV AL, CH
OUT PIO+1, AL; el PB tiene en 1 los bits del numero para prender esas luces
MOV AL, 0
OUT TIMER, AL;reinicio contador 
MOV AL, 20H
OUT PIC, AL;aviso que terminó interrupcion
IRET

END