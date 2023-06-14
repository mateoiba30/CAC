.data
DATA: .word32 0x10008
CONTROL: .word32 0x10000
MSJ1: .asciiz " Ingrese base flotante: "
MSJ2: .asciiz " Ingrese base entera positiva: "
MSJ3: .asciiz " resultado: "
UNO: .word 1.0

;-----------------------

.code
ld $s0, DATA($zero)
ld $s1, CONTROL($zero)

daddi $t0, $zero, MSJ1
daddi $t1, $zero, MSJ2
daddi $s2, $zero, 4 ;escribir string
daddi $s3, $zero, 8 ;leer nro
daddi $s4, $zero, MSJ3
daddi $s5, $zero, 3 ; escribir flotante

sd $t0, 0($s0) ; guardo dir de msj1 en data
sd $s2, 0($s1) ; escribo msj1
sd $s3, 0($s1) ; leo nro y guarda en data
l.d f1, 0($s0) ; guardo base flotante en f1

sd $t1, 0($s0) ; guardo dir de msj2 en data
sd $s2, 0($s1) ; escribo msj2
sd $s3, 0($s1) ; leo nro y guarda en data
ld $a0, 0($s0) ; guardo exponente entero en $a0

jal potencia; devuelve res en f2

sd $s4, 0($s0) ; guardo dir de msj en data
sd $s2, 0($s1) ; escribo msj3
s.d f2, 0($s0) ;pongo en data el resultado
sd $s5, 0($s1) ;escribo resultado


halt

;--------------
;$a0 exponente (reps)
;f1 base

potencia: daddi $t0, $0, 1
mtc1 $t0, f2
cvt.d.l f2, f2
beqz $a0, fin

daddi $t1, $a0, 0
for: mul.d f2,f2,f1
daddi $t1, $t1, -1
bnez $t1, for
fin: jr $ra