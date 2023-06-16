.data
A: .word 4
B: .word 5
C: .word 0

.code
ld r1, 45(r2)
dadd r1, r6, r7
or r9, r1, r7
dsub r8, r2, r7

halt