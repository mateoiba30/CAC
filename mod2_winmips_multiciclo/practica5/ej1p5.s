.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0

.code
l.d f1, n1(r0)
l.d f2, n2(r0)

add.d f3, f2, f1 #sumo, con RAW porque espera a f2 y tarda varias etapas por operar con flotantes
;mul.d f4, f2, f1 # multiplico, sin stall pero tarda muchas etapas
s.d f3, res1(r0) #guardo, con 2 RAWs por esperar a f3 y stall estructural porque llega a la etapa MEM al mismo tiempo que el add que tarda varias etapas
s.d f4, res2(r0) #guardo, con 1 RAW por esperar a f4 de la mul y un atasco estructural porque quiere acceder a la etapa de MEM al mismo timepo que la multiplicacion
halt #recordar que cuenta como instrucción

#analizo con forwarding y sin delay slot
#al operar con flotantes es común ver stall str debido a que en ejecucion se requieren varios ciclos de reloj
#en total 4 RAWs y 2 Stalls str
# 2.286 CPI