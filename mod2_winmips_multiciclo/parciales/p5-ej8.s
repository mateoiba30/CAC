.data

RES: .word 0
CONTROL: .word 0x10000
DATA: .word 0x10008

.code
ld $s0, CONTROL($0)
ld $s1, DATA($0)

daddi $t0, $0, 8
sd $t0, 0($s0) ; leo num y se almacena en data
ld $a0, 0($s1) ; cargo A
;sd $a0, A($0) si querría guardar las variables en memoria

sd $t0, 0($s0) ; leo num y se almacena en data
ld $a1, 0($s1) ; cargo B

sd $t0, 0($s0) ; leo num y se almacena en data
ld $a2, 0($s1) ; cargo C

jal calculo
sd $v0, RES($0)

sd $v0, 0($s1)
daddi $t0, $0, 2
sd $t0, 0($s0)

halt

;---------------
;$a0 A
;$a1 B
;$a2 C

calculo: daddi $v0, $0, 1
beqz $a2, fin

dsub $t0, $a0, $a1 ; (A-B)
potencia: dmul $v0, $v0, $t0
daddi $a2, $a2, -1
bnez $a2, potencia

fin: jr $ra