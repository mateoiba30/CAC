.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 7
long: .word 10

.code
ld r1, long(r0) #10
ld r2, num(r0)  #7
dadd r3, r0, r0 #0
dadd r10, r0, r0#0

loop: ld r4, tabla(r3) 
daddi r1, r1, -1 #diml de la tabla
daddi r3, r3, 8 #paso de la tabla
beq r4, r2, listo # con doble RAW  #si hay BTB se atasca doble la última vez por mala prediccion, la primera vez predijo bien el no saltar
#no pongo bnez 2do en el loop para no tener doble RAW
bnez r1, loop #si no tuviera forwarding se satasca por esperar a d1 de la instruccion de la linea 14 # doble atasco por mala prediccion de BTB la 1ra vez en bnez
j fin
listo: daddi r10, r0, 1 # tiene atasco doble la última vez si usa BTB
fin: halt

#ejecuto con forwarding en ambos casos
#BTB habilitado?  CPI   RAWs  BRUCH TAKENs
# no              1.651   0   8
# si              1.558   0   4