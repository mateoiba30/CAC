.data
TABLA: .word 4, 11, 18, 6, 6, 17, 28, 9, 0, 11, 23, 15, 6, 37, 29, 14
MENOR: .word 20
CANTIDAD: .word 15 ; DEBE TERMINAR EN 12
NUEVO: .word 0

.code
;$t0 contador de reps
;$t1 desplazamiento de tabla1
;$t2 desplazamiento de tabla2
;$t3 cantidad en nuevo
;$t4 dato actual
;$t5 menor
;$t6 bool MENOR?

ld $t0, CANTIDAD($0)
daddi $t1, $0, 0
daddi $t2, $0, 0
daddi $t3, $0, 0
ld $t5, MENOR($0)

loop: daddi $t6, $0, 0
ld $t4, TABLA($t1)
slt $t6, $t4, $t5
beqz $t6, no_menor
sd $t4, NUEVO($t2)
daddi $t2, $t2, 8
daddi $t3, $t3, 1
no_menor: daddi $t0, $t0, -1
daddi $t1, $t1, 8
bnez $t0, loop

sd $t3, CANTIDAD($0)

halt


