.data
coorX: .byte 24 ; coordenada X de un punto
coorY: .byte 24 ; coordenada Y de un punto
color: .byte 0, 0, 0, 0 ; dejar transparencia en cero
CONTROL: .word32 0x10000
DATA: .word32 0x10008
R: .asciiz " rojo: "
G: .asciiz " verde: "
B: .asciiz " azul: "
X: .asciiz " coordenada x: "
Y: .asciiz " coordenada y: "


;-----------------

.text
lwu $a0, CONTROL(r0) ; dirección de CONTROL
lwu $a1, DATA(r0) ; dirección de DATA

daddi $a2, $0, R ; cargo parametro de mensaje
jal devolver ; devuelve lo que pido en el msj, en $v0
sb $v0, color($s0) ; no lo pueod guardar en data porque lo sigo usando

daddi $s0, $s0, 1
daddi $a2, $0, G ; cargo parametro de mensaje
jal devolver ; devuelve lo que pido en el msj, en $v0
sb $v0, color($s0)

daddi $s0, $s0, 1
daddi $a2, $0, B ; cargo parametro de mensaje
jal devolver ; devuelve lo que pido en el msj, en $v0
sb $v0, color($s0)

daddi $a2, $0, X ; cargo parametro de mensaje
jal devolver ; devuelve lo que pido en el msj, en $v0
sb $v0, coorX($0)

daddi $a2, $0, Y ; cargo parametro de mensaje
jal devolver ; devuelve lo que pido en el msj, en $v0
sb $v0, coorY($0)

jal imprimir_imagen

halt

;----------------
;$a0 dir control
;$a1 dir data
;$a2 dir mensaje

devolver: sd $a2, 0($a1) ; cargo dir del msj en data
daddi $t0, $0, 4
sd $t0, 0($a0) ; control escribe mensaje
daddi $t1, $0, 8
sd $t1, 0($a0) ; control lee nro y escribe en data
ld $v0, 0($a1) ; cargo en $v0 lo que tengo en data ;  también podría usar un lbu o lb ya que opero de  abytes

jr $ra

;-------------
;$a0 dir control
;$a1 dir data

imprimir_imagen: lbu $t0, coorX(r0)
sb $t0, 5($a1) ; DATA+5 recibe el valor de coordenada X

lbu $t1, coorY(r0)
sb $t1, 4($a1) ; DATA+4 recibe el valor de coordenada Y

lwu $t2, color(r0)
sw $t2, 0($a1) ; DATA recibe el valor del color a pintar

daddi $t3, $0, 5
sd $t3, 0($a0) ; CONTROL recibe 5 y produce el dibujo del punto

jr $ra
