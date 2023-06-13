.data
TEXTO: .asciiz "escriba un numero de 1 digito: "
MAL: .asciiz "numero de varios digitos!"
CONTROL: .word32 0x10000
DATA: .word32 0x10008
NUMERO: .word 0
CERO: .asciiz "CERO  "
UNO: .asciiz "UNO   "
DOS: .asciiz "DOS   "
TRES: .asciiz "TRES  "
CUATRO: .asciiz "CUATRO"
CINCO: .asciiz "CINCO "
SEIS: .asciiz "SEIS  "
SIETE: .asciiz "SIETE "
OCHO: .asciiz "OCHO  "
NUEVE: .asciiz "NUEVE "
;---------------------
.code 
lwu $a0, DATA(r0) ; dir de DATA
lwu $a1, CONTROL(r0); dir de CONTROL
daddi $s0, $zero, MAL
jal ingreso

beqz $v0, mal;si es cero termino
dadd $a3, $zero, $v1
jal muestra
j fin
mal: sd $s0, 0($a0); mando dir del string a DATA
daddi $t0, $zero, 4
sd $t0, 0($a1) ;  imprimo

fin: halt
;-------------------
;$a0 dir data
;$a1 dir control
;$a3 tiene el numero

muestra: daddi $t1, $0, 8 ; tamanio en bytes del string + car fin
daddi $t0, $0, CERO
dmul $t3, $t1, $a3  ;pos mensaje
dadd $t0, $t0, $t3

sd $t0, 0($a0)
daddi $t2, $0, 4
sd $t2, 0($a1)
jr $ra
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