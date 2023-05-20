.data
TABLA: .word 0,1,2,3,4,5,6,7,8,9
X: .word 4
CANT: .word 0
RES: .word 0,0,0,0,0,0,0,0,0,0

.code
daddi r1,r1,10 # diml 
dadd r2,r0,r0  # paso
ld r4, X(r0)
dadd r6,r0,r0

loop: ld r3, TABLA(r2)
daddi r1,r1,-1

slt r5,r4,r3 # si la X es menor a r3 pongo un 1 a RES
sd r5, RES(r2)
dadd r6,r6,r5 # si queda en cero no sumo nada a fin de cuentas
#si son iguales lo deja en cero, por eso me sirve slt
bnez r1, loop
daddi r2,r2,8 # DELAY SORT

sd r6,CANT(r0)
halt

#forwarding me salva de 48 raws y no me deja con ninuno, no necesito reordenaar ni usar nop
#BTB 4 atascos, 1.105 CPI
#delay slot 0 atascos, 1.053 CPI (lo mejor)