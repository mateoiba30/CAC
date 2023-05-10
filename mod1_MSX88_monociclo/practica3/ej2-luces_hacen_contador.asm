PIC EQU 20H; defino etiquetas
TIMER EQU 10H
PIO EQU 30H
N_CLK EQU 10; instruccion de interrupcion 10 -> dir 40

ORG 40
IP_CLK DW RUT_CLK; la interrupcion me lleva a la siguiente rutina

ORG 1000H
INICIO DB 0; el contador de las luces inicia en cero

ORG 2000H ; muestro numeros del contador con luces, en binario
CLI
MOV AL, 0FDH; 11111101
OUT PIC+1, AL ;habilito timer, INT1 en IMR
MOV AL, N_CLK

OUT PIC+5, AL ; le mando la dir de la interrupcion al timer, INT1
MOV AL, 1 
OUT TIMER+1, AL ; le mando 1 al comparador
MOV AL, 0 
OUT PIO+3, AL ;CB tiene todo 0, entonces habilita todas las luces
OUT PIO+1, AL ;PB tiene todo en cero, por ahora no prende ninguna luz
OUT TIMER, AL ;inicio contador en cero
STI ;no programo PA ni CA porque son para la entrada, los microcontroladores, los cuales ahora no uso
LAZO: JMP LAZO; espero interrupcion

ORG 3000H
RUT_CLK: INC INICIO; cuando el timer llegue a 1 viene acá, osea cada 1 segundo
CMP INICIO, 0FFH
JNZ LUCES
MOV INICIO, 0; si me paso de 255 vuelvo a 0 para que las luces siempre puedan representar el numero actual
LUCES: MOV AL, INICIO
OUT PIO+1, AL; el PB tiene en 1 los bits del numero para prender esas luces
MOV AL, 0
OUT TIMER, AL;reinicio contador 
MOV AL, 20H
OUT PIC, AL;aviso que terminó interrupcion
IRET

END