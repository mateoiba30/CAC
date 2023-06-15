.data
TABLA1: .double 1.0, 2.0, 3.0, 4.0, 5.0
TABLA2: .double 0.0, 0.0, 0.0, 0.0, 0.0
DOS: .double 2.0

.code
daddi $t0, $0, 5
l.d f1, DOS($0)

loop: l.d f0, TABLA1($t1)
mul.d f0, f0, f1
s.d f0, TABLA2($t1)
daddi $t1, $t1, 8
daddi $t0, $t0, -1
bnez $t0, loop

halt