.data
valor: .word 5
result: .word 0

.text
daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila (1)
ld $a0, valor($0)
jal factorial
sd $v0, result($0)
halt

factorial: 

bnez $a0, else #si no hago recursio no debo manipular la pila
daddi $v0, $a0, 1
j fin

else: daddi $sp, $sp, -8
sd $ra, 0($sp) #pusheo dir de retorno

daddi $a0, $a0, -1
jal factorial
daddi $a0, $a0, 1 #en vez de sumarle uno tmb podría haberla pusheado
dmul $v0, $v0, $a0

ld $ra, 0($sp)#popeo dir de retorno
daddi $sp,$sp,8

fin: jr $ra

#por mas que sea recursivo, no devolver con el mismo parametro de entrada
