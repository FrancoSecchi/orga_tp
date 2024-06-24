global main

%include "utils_macros.asm"


extern cargar_partida
extern guardar_archivo
extern validarEleccionMenu

section .data
    mensaje_menu             db "Menu principal",10,10,"Vamos a jugar al Zorro y las Ocas!",10,"Seleccione una opción para jugar (ingresar número de opción)",10,"  0 - Nueva partida",10,"  1 - Cargar partida",10,0 
    mensaje_opcion_incorrecta     db "La opcion elegida no es valida, por favor ingrese una opcion valida.",10,0 
    len_tabero equ 7*7 ; 
    mensaje_entrada db "Ingrese una opcion:  ",0
    cmd_clear db "clear",0

    mensaje1 db "Cargar partida",10,0
    mensaje2 db "Nueva partida",10,0
    mensaje_final db "Fin del juego",10,0

section .bss

    bufferInput resb 100 
    tablero resb 49 ;Matriz de 7*7  


section .text

main: 
    _limpiarCmd

menu: 
    _printf mensaje_menu

menu_eleccion:
    _printf mensaje_entrada ;Imprime el mensaje de "Ingrese una opcion"
    _gets bufferInput ;Obtiene el valor
    mov rdi, bufferInput
    sub rsp, 8
    call validarEleccionMenu ;Valida la elección del usuario
    add rsp, 8
    
eleccionPartida:     
    ; En la rutina externa anterior, seteamos el valor de rax para poder validar la opcion elegida.
    ; Elección nueva partida
    cmp rax, 0
    je nuevaPartida
    ;Elección cargar partida
    cmp rax, 1
    je cargarPartida

    ;En el caso qe no sea ni nueva partida ni cargar partida, se le imprime un mensaje de error y se le pide que vuelva a ingresar una opción
    _printf mensaje_opcion_incorrecta
    jmp menu_eleccion

cargarPartida:  
    
    sub rsp, 8
    call cargar_partida
    add rsp, 8

    cmp rax, 0 ;En el caso que haya habido un problema con la apertura, escritura o clausura del archivo, se termina el programa
    je finalizar_juego

    jmp finalizar_juego


nuevaPartida: 
    _printf mensaje2
    jmp finalizar_juego


finalizar_juego: 
    _printf mensaje_final

    ;Acá va a estar el mensaje que muestra todas las estadisticas
    ;.....
    ret

