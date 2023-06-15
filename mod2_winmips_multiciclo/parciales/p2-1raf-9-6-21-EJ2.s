.data
coorY: .byte 24
color: .byte 255,0,255,0
CONTROL: .word32 0x10000
DATA: .word32 0x10008

.text
lwu $s6, CONTROL($zero)
lwu $s7, DATA($zero)

daddi $t0, $0, 7
sd $t0, 0($s6)

daddi $t1, $0, 1
daddi $t2, $0, 11

loop: sb $t1, 5($s7)
lbu $s1,coorY($zero)
sb $s1, 4($s7)
lwu $s2, color($0)
sw $s2, 0($s7)
daddi $t0, $0, 5
sd $t0, 0($s6)
daddi $t1, $t1, 1
bne $t1, $t2, loop
halt