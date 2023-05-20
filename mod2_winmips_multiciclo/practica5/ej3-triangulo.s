.data
altura: .double 13.47
base: .double 5.85
superficie: .double 0
dos: .double 2

.code
l.d f1,altura(r0)
l.d f2,base(r0)
l.d f4, dos(r0)
mul.d  f3, f1, f2
nop
nop
nop
nop
nop
nop#cada nop me salva de 2 atascos, 1 en div y otro en store

div.d f3, f3, f4
#no importa cuantos nops ponga, va a haber str debido a que s.d espera a tener disponible f3
#si no hay forwarding, en lugar de tener str tengo raw porque tarda mas tiempo en llegar el f3
s.d f3, superficie(r0)
halt