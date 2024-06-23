global main

%include "utils.asm"


extern leer_archivo
extern guardar_archivo

section .data
    mensajeMainMenu             db "Menu principal",10,10,"Vamos a jugar al Zorro y las Ocas!",10,"Seleccione una opción para jugar (ingresar número de opción)",10,"  0 - Cargar Partida",10,"  1 - Nueva Partida",10,0 
    len_tabero equ 7*7 ; 
    cmd_clear db "clear",0

section .bss

    bufferInput resb 100 
    registroPartida times 0 resb 95
    tablero resb 49 ;Matriz de 7*7  


section .text

main: 
    _limpiarCmd

menu: 
    _printf mensajeMainMenu
    _gets bufferInput
    ; Validar menu

    ;Si rax == 0 (esto lo devuelve el ret de las rutinas externas)
    ; Cargas la partida
    ;sino generas una nueva partido
    ;Sino decis que es invalida la opcion


eleccionPartida: 
    ; Cargas o generas una nueva

cargarPartida:  ;modularizar y hacerlo 
    ;Abris el archivo
    ;Si no existe o hay algun error, se informa y se comienza una nueva partida
    ; Cargar partida 
    ; 

