.data
A: .word 4
B: .word 5
C: .word 0

.code
ld $t0, A($0)
ld $t1, B($0)

daddi $t1, $t1, -1 ; la 1ra vez ya está multiplicado por 1
loop: dadd $t0, $t0, $t0
daddi $t1, $t1, -1
bnez $t1, loop

sd $t1, C($0)

halt