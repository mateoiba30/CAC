ORG 1000H
BiTE DB 11110000B
REPS DB 1;rotacines a la derecha

ORG 3000H
ROTARDER: MOV CL,8
SUB CL,CH
CALL ROTARIZ
RET
ROTARIZ: ADD AL,AL
ADC AL,0
DEC CL
JNZ ROTARIZ
RET

ORG 2000H
MOV AL, BiTE
MOV CH, REPS
CALL ROTARDER
HLT
END