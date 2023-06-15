.data
cant: .word 2
datos: .word 1, 2
res: .word 0

.code
ld r4, datos(r0)
dadd r1, r14, r6
daddi r2, r2, 1  
sd r5, datos(r12)
halt