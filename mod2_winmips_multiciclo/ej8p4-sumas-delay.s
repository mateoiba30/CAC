.data
A: .word 4
B: .word 5
C: .word 0

.code
ld r2,B(r0) #veces que repito
ld r1,A(r0)
dadd r3,r3,r3 # resultado
daddi r2,r2,-1 # 1ro resto, r1 ya es el valor multiplicado por 1 #alejado de instr 7 para no tener RAW

loop: dadd r3,r3,r1
bnez r2,loop
daddi r2,r2,-1 # delay slot, si ponrdía al otro como delay slot habrían RAWs en bnez esperando a restarle 1 a r2

sd r3,C(r0)
halt
