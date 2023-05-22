.data
CADENA0: .asciiz "aeiou"
CADENA1: .asciiz "aeiou0"
POS: .word 0

.code
daddi $a0,$0,CADENA0
daddi $a1,$0,CADENA1
jal ANALIZAR_STRINGS
sd $v0, POS($0)
halt

ANALIZAR_STRINGS: lbu $t0,0($a0)
lbu $t1,0($a1)

bne $t0, $t1, fin #si son distintos termino
beqz $t0, fin2 #me fijo si termine una de las cadenas
beqz $t1, fin2

daddi $v0, $v0, 1 #incremento pos de diferencia
daddi $a0, $a0, 1 #avanzo de paso
daddi $a1, $a1, 1
j ANALIZAR_STRINGS

fin2: daddi $v0, $0, -1
fin: jr $ra

#usar lbu para caracteres, y paso 1
#sin delay slot
#si una es mas larga que otra van a diferir al comparar el 0 con un caracteres
#el caracter que vale cero es el de fin de string