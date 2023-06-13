.data
TEXTO: .asciiz "escriba un numero de 1 digito: "
MAL: .asciiz "numero de varios digitos!"
CONTROL: .word32 0x10000
DATA: .word32 0x10008
NUMERO: .word 0
CERO: .asciiz "CERO"
UNO: .asciiz "UNO"
DOS: .asciiz "DOS"
TRES: .asciiz "TRES"
CUATRO: .asciiz "CUATRO"
CINCO: .asciiz "CINCO"
SEIS: .asciiz "SEIS"
SIETE: .asciiz "SIETE"
OCHO: .asciiz "OCHO"
NUEVE: .asciiz "NUEVE"

.code 
lwu $a0, DATA(r0) ; dir de DATA
lwu $a1, CONTROL(r0); dir de CONTROL
daddi $a2, $zero, TEXTO
lwu $s0, MAL(r0)
jal ingreso



fin: halt

ingreso: sd $a2, 0($a0); mando dir del string a DATA
daddi $t0, $zero, 4
sd $t0, 0($a1) ;  imprimo

daddi $t0, $zero, 8
sd $t0, 0($a1) ;  leo nro
ld $t1, 0($a0)

slti $v0, $t1, 10; $v0 = 1 si es menor a 10 lo que tengo en DATA

jr $ra