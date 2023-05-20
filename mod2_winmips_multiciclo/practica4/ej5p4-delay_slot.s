.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

.code
dadd r1, r0, r0 # paso
ld r2, cant(r0) # diml

loop: ld r3, datos(r1) #recibo dato
daddi r2, r2, -1
dsll r3, r3, 1 # desplazo izquierda
sd r3, res(r1) # guardo en memoria
daddi r1, r1, 8#
bnez r2, loop
nop # para no procesar el halt en delay slot -> puedo cambiarlo y fuera del bucle poner la linea 14

halt

#multiplica por 2 todos los elementos de la tabla
#conviene tener BTB para tener 4 atascos nomás, sinó tendría 7. Pero si quiero tener Delay Slot, no puedo tener BTB
#con delay slot hago algo con el ciclo perdido por bnez, es mejor en CPI aunqe tenga nop ya que el nop es una instruccion sin atascos (nop perjudica el tiempo de ejecucion)
#no hay raw, no es necesario el forwarding

# CPI con BTB y nop 1.154 en 60 ciclos
# CPI con nop 1.068 en 63 ciclos
# CPI sin nop 1.078 en 55 ciclos