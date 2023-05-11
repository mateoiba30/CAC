.data
A: .word 1
B: .word 2

.code
ld r1, A(r0) 
ld r2, B(r0) #sin forwarding genera atascos porque la siguiente instruccion espera a que r2 tenga el valor de B en el registro
sd r2, A(r0) #si activo forwarding, no espero a que el valor de r2 sea cambiado en la etapa de wb y le paso el valor directo a esta instruccion así no tiene un atasco
sd r1, B(r0)
halt

#el forwarding no siempre me evita el RAW, read after write
#sin forwarding hay un promedio de2.2 CPI
# c.c. 1.8 CPI