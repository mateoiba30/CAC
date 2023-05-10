PIO EQU 30H;defino etiquetas
;el pio le manda datos a la imp´resora, no es una interrupción.Por eso no se usa el PIC
ORG 1000H
MSJ DB "CONCEPTOS DE "
DB "ARQUITECTURA DE "
DB "COMPUTADORAS"
FIN DB ?

ORG 2000H
MOV AL, 0FDH ; 11111101
OUT PIO+2, AL;activa BUSY pero desactiva STROBE
MOV AL, 0
OUT PIO+3, AL; activo todos los bits de escritura de PB
IN AL, PIO
AND AL, 0FDH; deja encendido los bits que coinciden con 11111101,STROBE  desactivado
OUT PIO, AL ; FIN INICIALIZACION

MOV BX, OFFSET MSJ;BX apunta al mensaje
MOV CL, OFFSET FIN-OFFSET MSJ; y cl dice cant de caracteres a leer

POLL: IN AL, PIO;veo si la lectura está BUSY
AND AL, 1
JNZ POLL;repito hasta que quede BUSY
;cuando se liberó la mando a imprimir otro caracter
MOV AL, [BX]
OUT PIO+1, AL; manda el valor del caracter actual al PB, puerto de datos de salida
IN AL, PIO
OR AL, 02H
OUT PIO, AL; activa el bit1 de strobe
IN AL, PIO
AND AL, 0FDH
OUT PIO, AL ; FIN PULSO,  le manda 11111101 al PA para no estar BUSY
INC BX; BX apunta al siguiente caracter
DEC CL; decremento contador de caracteres

JNZ POLL;vuelvo a esperar impresion
INT 0
END