
CMP SEG2, 3AH
JNZ RESET; a la decima vuelta no salta, las unidades llegaron a una decema
MOV SEG2, 30H;reinicio unidades
INC SEG; incremento decenas

CMP SEG, 36H;entra en total 6 veces a la comparacion, es un contador de 1 minuto
JNZ RESET
MOV SEG, 30H; si termino reinicio las decenas de segundos, vuelve a pasar un minuto y llego de vuelta acá
INC MIN2

CMP MIN2, 3AH
TIMER EQU 10H; doy valores a etiquetas, 1er reg: COMP
PIC EQU 20H; inicio del pic
EOI EQU 20H; inicio del pic, su 1er registro
N_CLK EQU 10;determino el nro de instruccion del vector de instrucciones

ORG 40; las instrucciones son de 4 bytes, la 10a instruccion está en la dir 40 (10)
IP_CLK DW RUT_CLK; redirecciono a rutina definida por mi

ORG 1000H
MIN DB 30H;decenas
MIN2 DB 30H; unidades
SEPARO DB 3AH
SEG DB 30H; decenas 
SEG2 DB 30H; unidades
ESPA DB 20H
FIN DB ?

ORG 3000H
RUT_CLK: PUSH AX
INC SEG2
JNZ RESET
MOV MIN2, 30H; si termino reinicio las decenas de segundos, vuelve a pasar un minuto y llego de vuelta acá
INC MIN

CMP MIN, 36H
JNZ RESET
MOV MIN, 30H; si termino reinicio las decenas de segundos, vuelve a pasar un minuto y llego de vuelta acá

RESET: INT 7; imprime seg con 2 caracteres, por lo tanto imprime seg2 tambien
MOV AL, 0
OUT TIMER, AL; mando 0 a CONT para que al volver al main vuelva a interrumpir
MOV AL, EOI
OUT PIC, AL; le digo terminar al PIC q terminé esta interrupción
POP AX
IRET

ORG 2000H
CLI; desactivo otras interrupciones
MOV AL, 0FDH; 11111101 -> enmascaro todas las int menos la del timer
OUT PIC+1, AL ; PIC: registro IMR le mando activar timer
MOV AL, N_CLK
OUT PIC+5, AL ; PIC: registro INT1 del timer le mando 10=nro de instruccion del vector de interrupciones
MOV AL, 10
OUT TIMER+1, AL ; TIMER: registro COMP, le mando el valor con el cual comparar
MOV AL, 0
OUT TIMER, AL ;TIMER: registro CONT le mando el valor con el que inicia el contador
MOV BX, OFFSET MIN; para imprimir al llamar int los segundos
MOV AL, OFFSET FIN-OFFSET MIN; tiene 2H para imprimir 2 caracteres (seg y seg2)
STI
LAZO: JMP LAZO;repite hasta ser interrumpido por el timer que espera 1 segundo
END