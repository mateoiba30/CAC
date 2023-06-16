.data
VECTOR: .word 1234, 2345, 3456, 4567, 5678
NUEVO: .word 0

.code
daddi $t0, $0, 5 ; diml
daddi $t1, $0, 0 ; paso de ambas tablas

loop: ld $t2, VECTOR($t1)
daddi $t2, $t2, 1
sd $t2, NUEVO($t1)
daddi $t1, $t1, 8
daddi $t0, $t0, -1
bnez $t0, loop

halt