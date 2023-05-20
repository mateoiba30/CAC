.data
a: .word 5
x: .word 6
y: .word 7

.code
dadd r4,r0,r0
ld r1,a(r0) #alejo r1 y r4 para no tener RAW
ld r2,x(r0)
ld r3,y(r0)

while: beqz r1,fin # termina si 'a' es igual a cero
daddi r1,r1,-1 # delay slot, va a restar una vez demás a 'a', pero va a tenrmiar cuando quiero y sin stalls
j while
dadd r2,r2,r3# delay slot

fin: sd r1,a(r0)
sd r2,x(r0)
sd r3,y(r0)
halt

#con los delay slot puestos funciona bien y sin atascos de control y sin RAW tampoco
#si bien se parece mas a un do while que un while y a queda en -1, la solución está bien