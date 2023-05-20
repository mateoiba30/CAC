.data
A: .word 1
B: .word 1
C: .word 1
D: .word 0

.code
dadd r4,r4,r4 # la pongo 1ra para evitar RAW
ld r1,A(r0)
ld r2,B(r0)
ld r3,C(r0)#pongo r3 cercano a la comparacion de r1 y r2 para que no joda

#nop
bne r1,r2,cmp2# si no son iguales, salta
daddi r4,r4,1
#nop
cmp2: bne r1,r3,cmp3
daddi r4,r4,1
#nop
cmp3: bne r2,r3,fin
daddi r4,r4,1
#nop
#nop
fin: sd r4, D(r0)
halt

#sin forwarding hay varios RAWS que debería solucionar poniendo NOPs ya que
#las instrucciones están bastante juntas y no hay alternativa para reordenar
#son pocas las zonas que pude reordenar