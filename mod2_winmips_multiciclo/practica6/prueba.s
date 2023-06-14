.data
NUM: .word 5
AUX: .word 3
DATA: .word32 0x10008

.code
daddi $a0, $0, DATA

halt