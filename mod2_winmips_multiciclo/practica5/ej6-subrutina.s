.data
valor1: .word 16
valor2: .word 4
result: .word 0

.text
ld $a0, valor1($0)
ld $a1, valor2($0)
jal a_la_potencia #al usar jal guarda en r31 = $ra la dir de retorno para PC
sd $v0, result($0)
halt

a_la_potencia: daddi $v0, $0, 1
lazo: slt $t1, $a1, $0
bnez $t1, terminar # si a1 es menor que cero termino
daddi $a1, $a1, -1 #sinó decremento a1
dmul $v0, $v0, $a0 # $v0 *= valor1
j lazo
terminar: jr $ra

# t son locales a la subrutina, no es algo que recibe ni que devuelve la misma, por ende son tempórales
# v son para retornar
# a son para recibir
# ra es el registro que uso para retornar de la subrutina, el cual vale c(h) = 12(10) = 3er instr x 4bytes por instr
# si quiero tener una anidación de subrutinas debo usar al pila para guardar los valores de
# retorno del r31 por cada jal que haga. otra opción es volver haciendo llamado a etiquetas
# solo usando j, pero no es muy rentable