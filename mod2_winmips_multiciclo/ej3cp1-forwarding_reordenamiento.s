.data
A: .word 1
B: .word 6
.code
ld r2, B(r0)
ld r1, A(r0) #cambio de lugar los ld para que no haya RAW con la 1ra vez que entro al bucle

loop: daddi r2, r2, -1 #cambie de lugar el daddi por dsll para ganar la etapa perdida
dsll r1, r1, 1
bnez r2, loop # raw porque debe eesperar al wb de la instruccion de arriba que modifica r2. Si tengo forwarding hace un atasco menorm, espera solo a llegar a Mem en este caso
halt

#en este caso el forwarding me lleva de un atasco de 2 etapas RAW, a un atasco de 1 etapa. El forwarding no simepre me ayuda al 100%, pero siempre ayuda
# para no tener ningún RAW reordené el código del ej3p1

#1.429 CPI con forwarding
#si dejo reordenado pero sin forwarding me queda un RAW de 1 etapa en bnez que espera al wb de la 1er instrucciuon del loop
#1.762 CPI