.data
A: .word 1
B: .word 6
.code
ld r1, A(r0)
ld r2, B(r0)
loop: dsll r1, r1, 1  # aunque tenga forwarding activado: hace un atasco porque espera saber el resultado de la operacion en el wb, para saber si saltar o no -> brunch taken con atasco de 2 ciclos
daddi r2, r2, -1
bnez r2, loop # raw porque debe eesperar al wb de la instruccion de arriba que modifica r2. Si tengo forwarding hace un atasco menorm, espera solo a llegar a Mem en este caso
halt

#en este caso el forwarding me lleva de un atasco de 2 etapas RAW, a un atasco de 1 etapa. El forwarding no simepre me ayuda al 100%, pero siempre ayuda
# multiplica por 2 a r1 dezplazandolo a la izq
# repito hasta que r1 valga cero -> 6 veces
# r1=A*2*2*2*2*2*2 = A* 2^6 = 2^6 = 64(10) = 40(16)
# dsll: Desplaza a izquierda N veces los bits del registro rf, dejando el resultado en rd
# bnez: Si rd no es igual a 0, salta a la dirección rotulada offN

#1.714 CPI con forwarding
#2.048 CPI sin forwarding