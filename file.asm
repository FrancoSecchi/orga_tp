global cargar_partida
global guardar_partida
section .data

    nombre_archivo db "partida.dat",0
    mode				db	"ab+",0		; modo append binary and read (actualizacion y lectura)
	msgErrOpen	db  "Error en apertura de archivo",0

section .text

leer_partida: 


guardar_partida: 