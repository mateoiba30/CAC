.data
estado: .word 0
IMC: .double 0
peso: .double 76
altura: .double 1.93

v1: .double 18.5
v2: .double 25
v3: .double 30

.code
l.d f2, altura(r0)
l.d f1, peso(r0)#asi evito RAW
# porque tendría esta instruccion un str y genera RAW en div. tampoco que reemplace un nop porque le da RAW a la mul
mul.d f2,f2,f2
nop
nop
nop
nop
nop
nop# evito raws de la div y s.lt.d, esta es la cant maxima de nops donde cada nop me salva de 2 atascos. este ultimo tiene str
div.d f1, f1, f2# va a atascarse bastante por esperar a mul
#conviene usar varios registros, uno pa cada valor para aprovechar el tiempo que pierdo con el div

l.d f3, v1(r0)
l.d f4, v2(r0)
l.d f5, v3(r0)

c.lt.d f1,f3 #deja en 1 FP si es menor a 18,5, tiene 21 RAWs y STR por div (ya no me afecta el l.d de arriba)
bc1f salto 
daddi r3, r3, 1 #delay slot
j fin

salto: daddi r3, r3, 1 #evito RAW de l.d , mejor que poner nop
c.lt.d f1, f4 #deja en 1 FP si es menor a 25
bc1f saltoo
s.d f1, IMC(r0) #lo alejo del div #delay slot
j fin

saltoo: c.lt.d f1, f5 #deja en 1 FP si es menor 30
bc1f saltooo 
daddi r3, r3, 1 #delay slot
j fin

saltooo: daddi r3, r3, 1 #caso default

fin: sd r3, estado(r0)
halt
#con delay slot y forwarding necesario