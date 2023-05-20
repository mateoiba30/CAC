.data
estado: .word 0
IMC: .double 0
peso: .double 76
altura: .double 1.93

v1: .double 18.5
v2: .double 25
v3: .double 30

.code
l.d f1, peso(r0)
l.d f2, altura(r0)
div.d f1, f1, f2
s.d f1, IMC(r0)

l.d f3, v1(r0)
c.lt.d f1,f3 #deja en 1 FP si es menor a 18,5
bc1f salto
daddi r1, r1, 1
j fin

salto: l.d f3, v2(r0)
c.lt.d f1, f3 #deja en 1 FP si es menor a 25
bc1f saltoo
daddi r1, r1, 2
j fin

saltoo: l.d f3, v3(r0)
c.lt.d f1, f3 #deja en 1 FP si es menor 30
bc1f saltooo
daddi r1, r1, 3
j fin

saltooo: daddi r1, r1, 4 #caso default

fin: sd r1, estado(r0)
halt