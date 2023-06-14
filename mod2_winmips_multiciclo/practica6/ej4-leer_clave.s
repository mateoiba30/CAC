.data
CLAVE: .asciiz "1234"
DATA: .word32 0x10008
CONTROL: .word32 0x10000
BIENVENIDO: .asciiz " Bienvenido "
ERROR: .asciiz " Error "
INGRESO: .ascii "0000" ; no es necesario tener un caracter nulo porqu esto no lo imprimo
MENSAJE: .asciiz " Ingrese clave de 4 digitos: "

;---------------------------------------

.code
ld $a0, CONTROL($zero)             ;manera de cargar offset de control y data
ld $a1, DATA($zero)

pedir_clave: daddi $t2, $zero, 4 ; reps
daddi $t3, $zero, INGRESO

daddi $t0, $zero, MENSAJE          ;manera de cargar offsets normales
sd $t0, 0($a1) ;mando dir msj a data
daddi $t1, $zero, 4
sd $t1, 0($a0); escribo msj

;leo clave ingresada
for: jal char
sb $v0, 0($t3); guardo caracter de a bytes
daddi $t3, $t3, 1; me desplazo de byte
daddi $t2, $t2, -1
bnez $t2, for

daddi $t2, $zero, 4 ; reps
daddi $t3, $zero, INGRESO
daddi $t4, $zero, CLAVE
daddi $a3, $zero, 0

for2: ld $t5, 0($t3)
ld $t6, 0($t4)
beq $t5, $t6, bien 
daddi $a3, $zero, 1 ; indica que hubo error, cero si esta bien
bien: daddi $t3, $t3, 1
daddi $t4, $t4, 1
daddi $t2, $t2, -1
bnez $t2, for2

jal respuesta
bnez $a3, pedir_clave

halt

;------------

;$a0 dir control
;$a1 dir data

char: daddi $t0, $zero, 9
sd $t0, 0($a0) ;leo y guardo en data
lbu $v0, 0($a1) ;guardo carcter en $v0

jr $ra

;------------

;$a0 dir control
;$a1 dir data
;$a3 vale 1 si hubo error, 0 si esta bien

respuesta: beqz $a3, correcto
daddi $t1, $zero, ERROR
j mostrar
correcto: daddi $t1, $zero, BIENVENIDO

mostrar: sd $t1, 0($a1) ; cargo dir de msj a data
daddi $t0, $zero, 4
sd $t0, 0($a0)

jr $ra


