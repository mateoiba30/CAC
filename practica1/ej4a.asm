ORG 1000H
NUM1 DB 12
NUM2 DB 13

ORG 2000H
MOV AL, NUM1
MOV BL, NUM2

CMP BL, AL; bl - al, si no hay signo es porq bl es mayor o igual
JNS then; A <= B?

JMP else
then: MOV CL, AL 
JMP fin
else:MOV CL, BL
fin:hlt
end
