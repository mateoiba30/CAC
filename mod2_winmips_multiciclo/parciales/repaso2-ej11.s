.data
A: .word 4
B: .word 5
C: .word 0

.code
ld $t0, A($0)
ld $t1, B($0)
daddi $t2, $0, 0

loop: dadd $t2, $t2, $t0
daddi $t1, $t1, -1 ;la primera vez pasa de cero al valor x1
bnez $t1, loop

sd $t2, C($0)

halt