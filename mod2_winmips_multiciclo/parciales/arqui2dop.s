.data
TABLA1: .double 12.0, 15.3, 31.2, 56.4, 44.3, 78.1
MIN: .double 20.0
MAX: .double 50.0
CANT: .word 6
RES: .word 0
TABLA2: .double 0.0

.text
ld $t0, CANT($0); obtengo diml
l.d f1, MIN($0);   obtengo minimo
l.d f2, MAX($0);falta el obtener maximo !!!!!!!!!!
dadd $t3, $0, $0; indico contador de componentes que cumplen la condicion
dadd $t4, $0, $0; indico contador de desplazamiento tabla1 (de a ocho por ser double)

dadd $t5, $0, $0; indico registro de desplazamiento para la tabla2
loop: l.d f3, TABLA1($t4);pongo valor de la tabla 1 en f3
c.lt.d f3, f1 ;comparo con el minimo
bc1t FUERA; si es menor al minimo mne voy
c.lt.d f2, f3 ;comparo con el maximo
bc1t FUERA; si es mayor al maximo
daddi $t3, $t3, 1; si cumple la condicion aumento contador
s.d f3, TABLA2($t5); almaceno en tabla 2
daddi $t5, $t5, 8;aumento desplazamiento !!!!!!!!!!!!!!!!!!
FUERA: daddi $t4, $t4, 8; aumento desplazamiento de la tabla1
daddi $t0, $t0, -1; contador--
bnez $t0, loop; chequeo si repetir
sd $t3, RES($0); guardo respuesta en memoria

halt; fin del programa