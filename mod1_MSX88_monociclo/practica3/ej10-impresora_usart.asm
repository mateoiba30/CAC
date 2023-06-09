USART EQU 60H
ORG 1000H
SACADOS DW 0
TABLA DB "Comunicación serie a"
DB "través del protocolo"
DB "DTR por consulta de estado"
FIN DB ?
; programa principal
ORG 2000H
INICIO: MOV BX, OFFSET TABLA
MOV SACADOS, 0
; programo la USART
MOV AL, 51H ; binario=01010001
OUT USART+2, AL
TEST: IN AL, USART+2
AND AL, 81H
CMP AL, 81H
JNZ TEST
MOV AL, [BX]
OUT USART+1, AL
INC BX
INC SACADOS
CMP SACADOS, OFFSET FIN-OFFSET TABLA
JNZ TEST
INT 0
END
