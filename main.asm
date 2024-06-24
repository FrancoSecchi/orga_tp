global main

%include "utils_macros.asm"


extern cargar_partida
extern guardar_archivo
extern validarEleccionMenu

section .data
    mensajeMainMenu             db "Menu principal",10,10,"Vamos a jugar al Zorro y las Ocas!",10,"Seleccione una opción para jugar (ingresar número de opción)",10,"  0 - Nueva partida",10,"  1 - Cargar partida",10,0 
    mensajeOpcionIncorrecta     db "La opcion elegida no es valida, por favor ingrese una opcion valida.",10,0 
    len_tabero equ 7*7 ; 
    mensajeEntrada db "Ingrese una opcion:  ",0
    cmd_clear db "clear",0

    mensaje1 db "Cargar partida",10,0
    mensaje2 db "Nueva partida",10,0
    mensaje3 db "Fin del juego",10,0

section .bss

    bufferInput resb 100 
    registroPartida times 0 resb 95
    tablero resb 49 ;Matriz de 7*7  


section .text

main: 
    _limpiarCmd

menu: 
    _printf mensajeMainMenu

menu_eleccion:
    _printf mensajeEntrada
    _gets bufferInput
    mov rdi, bufferInput
    sub rsp, 8
    call validarEleccionMenu
    add rsp, 8
    
eleccionPartida:     
    ; En la rutina externa anterior, seteamos el valor de rax para poder validar la opcion elegida.
    ; Elección nueva partida
    cmp rax, 0
    je nuevaPartida
    ;Elección cargar partida
    cmp rax, 1
    je cargarPartida

    _printf mensajeOpcionIncorrecta
    jmp menu_eleccion

cargarPartida:  
    
    sub rsp, 8
    call cargar_partida
    add rsp, 8

    cmp rax, 0
    je finalizar_juego
    
    jmp finalizar_juego


nuevaPartida: 
    _printf mensaje2
    jmp finalizar_juego

;modularizar y hacerlo 
    ;Abris el archivo
    ;Si no existe o hay algun error, se informa y se comienza una nueva partida
    ; Cargar partida 
    ; 

finalizar_juego: 
    _printf mensaje3
    ret

