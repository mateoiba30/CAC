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
nop# evito raw de la div

div.d f1, f1, f2

l.d f3, v1(r0)
c.lt.d f1,f3 #deja en 1 FP si es menor a 18,5, tiene 21 RAWs y STR por div (ya no me afecta el l.d de arriba)
bc1f salto 
daddi r3, r3, 1 #delay slot
j fin

salto: l.d f3, v2(r0)
daddi r3, r3, 1 #evito RAW de l.d , mejor que poner nop
c.lt.d f1, f3 #deja en 1 FP si es menor a 25
bc1f saltoo
s.d f1, IMC(r0) #lo alejo del div #delay slot
j fin

saltoo: l.d f3, v3(r0)
nop #pa evitar el RAW
c.lt.d f1, f3 #deja en 1 FP si es menor 30
bc1f saltooo 
daddi r3, r3, 1 #delay slot
j fin

saltooo: daddi r3, r3, 1 #caso default

fin: sd r3, estado(r0)
halt
#con delay slot y forwarding necesario