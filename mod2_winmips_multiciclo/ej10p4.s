.data
cadena: .asciiz "adbdcdedfdgdhdid" #pesan 8 bits, 1 byte, uso lbu que es load byte unsigned
car: .asciiz "d"
cant: .word 0

#lbu para cargar caracteres en registros

.code
dadd r5,r0,r0 # paso # la pongo 1ra para que no haya RAW con el loop
lbu r2,car(r0) #caracter a comparar
dadd r3,r0,r0 #contador aciertos
daddi r4,r0,16 # diml

loop: lbu r1,cadena(r5) #caracter actual
daddi r5,r5,1 # paso de 1 porque son bytes
daddi r4,r4,-1
bne r1,r2, salto# si no son iguales # lo alejo de la instr 14 para quew no haya RAW
daddi r3,r3,1
salto: bnez r4, loop #si no recorrí todo, repito

sd r3, cant(r0)# sb es para byte, para un caracter, esto es una word #unica instruccion con RAW si no hy forwarding
halt
