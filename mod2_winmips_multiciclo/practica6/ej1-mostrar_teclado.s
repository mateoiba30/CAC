.data
CARACTER: .byte 0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
ENTER: .byte 13

.text
lwu $s0, DATA(r0) ; $s0 = dirección de DATA
lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL
daddi $s2, $zero, 13 ; $s2 valor del enter
lwu $s3, CARACTER(r0)

repetir: daddi $t0, $zero, 9
sd $t0, 0($s1) ; control dice de leer un caracter y mandarlo a data 10008

lbu $t1, 0($s0); tomo caracter desde DATA

beq $t1, $s2, fin ; me fijo de que no sea un enter

sb $t1, CARACTER($zero) ; inmed(reg) -> guardo el caracter en CARACTER

sb $s3, 0($s0);ahora data debe tener la dir del string a leer, debo cargar desde un registro la dir ($s3)

daddi $t0, $zero, 4
sd $t0, 0($s1) ;  imprimo

j repetir

fin: halt