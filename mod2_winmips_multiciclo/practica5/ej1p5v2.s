.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0

.code
l.d f1, n1(r0)
l.d f2, n2(r0)
#nop me soluciona RAW y WAR de las 2 lineas de abajo
add.d f3, f2, f1 #sumo, con RAW porque espera a f2 y tarda varias etapas por operar con flotantes
mul.d f1, f2, f1 #WAR debido a que quiere escribir f1, pero no está disponible porque la isntr de arriba se atraso con la lectura de registros 
#esta instruccion hace que la siguiente mul tenga muchos RAW porque espera a poder usar los registros de esta linea (por eso es RAW y no str)

mul.d f4, f2, f1 # multiplico, sin stall pero tarda muchas etapas
s.d f3, res1(r0) #guardo, con 2 RAWs por esperar a f3 y stall estructural porque llega a la etapa MEM al mismo tiempo que el add que tarda varias etapas
s.d f4, res2(r0) #guardo, con 1 RAW por esperar a f4 de la mul y un atasco estructural porque quiere acceder a la etapa de MEM al mismo timepo que la multiplicacion
halt #recordar que cuenta como instrucción

#!!los comentarios muy largos da errores
#analizo con forwarding y sin delay slot y sin el nop
#al operar con flotantes es común ver stall str debido a que en ejecucion se requieren varios ciclos de reloj
#en total 16 RAWs, 1 WAR y 2 Stalls str
# 3 CPI