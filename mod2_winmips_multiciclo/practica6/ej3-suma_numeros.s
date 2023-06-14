.data
TEXTO: .asciiz "escriba un numero de 1 digito: "
MAL: .asciiz "numero de varios digitos!"
CONTROL: .word32 0x10000
DATA: .word32 0x10008
;---------------------
.code 
lwu $a0, DATA(r0) ; dir de DATA
lwu $a1, CONTROL(r0); dir de CONTROL
daddi $s0, $zero, MAL

jal ingreso
beqz $v0, mal;si es cero termino
dadd $a2, $zero, $v1

jal ingreso
beqz $v0, mal;si es cero termino
dadd $a3, $zero, $v1

jal resultado
j fin

mal: sd $s0, 0($a0); mando dir del string a DATA
daddi $t0, $zero, 4
sd $t0, 0($a1) ;  imprimo
fin: halt
;-------------------
;$a0 dir data
;$a1 dir control

ingreso: daddi $t2, $zero, TEXTO

sd $t2, 0($a0); mando dir del string a DATA
daddi $t0, $zero, 4
sd $t0, 0($a1) ;  imprimo

daddi $t0, $zero, 8
sd $t0, 0($a1) ;  leo nro
ld $v1, 0($a0) ;v1 tiene el nro

slti $v0, $v1, 10; $v0 = 1 si es menor a 10 lo que tengo en DATA

jr $ra

;-----------------
;$a0 dir data
;$a1 dir control
;$a2 num 1
;$a3 num 2

resultado: dadd $t0, $a2, $a3
sd $t0, 0($a0); DATA tiene el valor
daddi $t1, $zero, 1
sd $t1, 0($a1); CONTROL escribe num >0 entero

jr $ra
