.data
TABLA: .word 4, 11, 18
MAYOR: .word 10
CANTIDAD: .word 3
NUEVO: .word 0

.code
;$t0 valor actual
;$t1 desplazamiento=paso tabla
;$t2 contador de elementos a analizar
;$t3 desplazamiento=paso nuevo
;$t4 valor mayor
;$t5 =0 si no cumple, =1 si cumple
;$t6 contador de elementos en nuevo

ld $t2, CANTIDAD($0)
ld $t4, MAYOR($0)

loop: daddi $t5, $0, 0
ld $t0, TABLA($t1)
slt $t5, $t4, $t0 ; si t4 es menor (tabla mayor a MAYOR) entonces $t5=1
beqz $t5, falso ; si t5 es cero, no se comple la condicion
daddi $t6, $t6, 1
sd $t0, NUEVO($t3)
daddi $t3, $t3, 8
falso: daddi $t1, $t1, 8
daddi $t2, $t2, -1
bnez $t2, loop

sd $t6, CANTIDAD($0)
halt