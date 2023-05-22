.data
M: .word 3
TABLA: .word 1, 2, 3, 4, 5
DIML: .word 5
RESULT: .word 0

.code
daddi $a1, $0, TABLA #tiene el offset
ld $a0, M($0)
ld $a3, DIML($0) #alejo parametros segun cuales uso primero para asegurar que no haya RAW, pero en este caso no es necesario
jal CONTAR
sd $v0, RESULT($0)
halt

CONTAR: ld $t0,0($a1) #tiene el numero actual
slt $t1, $a0, $t0 #deja en 1 si M es menor
beqz $t1, salto #si es cero es porq no es menor que M
daddi $a1, $a1, 8 #paso, lo puedo alterar porque es $a #delay slot
daddi $v0, $v0, 1 # si la resta da cero aumento el contador

salto: bnez $a3, CONTAR
daddi $a3, $a3, -1 #diml # delay slot
jr $ra

#no olvidar que el paso es de a 8 para word!
#con delay slot y forwarding