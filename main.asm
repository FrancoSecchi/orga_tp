global main

%include "utils_macros.asm"


extern cargar_partida_archivo
extern guardar_partida_archivo
extern validar_eleccion_menu
extern validar_eleccion_jugada

section .data
    mensaje_menu             db "Menu principal",10,10,"Vamos a jugar al Zorro y las Ocas!",10,"Seleccione una opción para jugar (ingresar número de opción)",10,"  0 - Nueva partida",10,"  1 - Cargar partida",10,0 
    mensaje_opcion_incorrecta     db "La opcion elegida no es valida, por favor ingrese una opcion valida.",10,0 
    len_tabero equ 7*7 ; 
    mensaje_controles_generales db "CONTROLES: Los controles ingresados deben estar en MAYÚSCULAS",10," Ingresar uno de los caracteres indicados.",10,"(G) Guardar Partida - (S) Salir del Juego - (1 - 9) Movimiento",10,0

    mensaje_entrada db "Ingrese una opcion:  ",0
    mensaje_inicio_partida db "Empezamos a jugar!!",10 ,0
    cmd_clear db "clear",0

    mensaje1 db "Cargar partida",10,0
    mensaje2 db "Nueva partida",10,0
    mensaje_final db "Fin del juego",10,0

section .bss

    buffer_input resb 100 
    tablero resb 49 ;Matriz de 7*7  


section .text

main: 
    _limpiarCmd

menu: 
    _printf mensaje_menu

menu_eleccion:
    _printf mensaje_entrada ;Imprime el mensaje de "Ingrese una opcion"
    _gets buffer_input ;Obtiene el valor
    mov rdi, buffer_input
    sub rsp, 8
    call validar_eleccion_menu ;Valida la elección del usuario
    add rsp, 8
    
eleccion_partida:     
    ; En la rutina externa anterior, seteamos el valor de rax para poder validar la opcion elegida.
    ; Elección nueva partida
    cmp rax, 0
    je nueva_partida
    ;Elección cargar partida
    cmp rax, 1
    je cargar_partida

    ;En el caso qe no sea ni nueva partida ni cargar partida, se le imprime un mensaje de error y se le pide que vuelva a ingresar una opción
    _printf mensaje_opcion_incorrecta
    jmp menu_eleccion

cargar_partida:  
    sub rsp, 8
    call cargar_partida_archivo
    add rsp, 8

    cmp rax, 0 ;En el caso que haya habido un problema con la apertura, escritura o clausura del archivo, se termina el programa
    je finalizar_juego

    jmp empezar_turno


nueva_partida: 
    _printf mensaje2
    jmp finalizar_juego

empezar_turno: 
    ;Acá se imprime el tablero
    _printf mensaje_controles_generales

ingresar_jugada: 
    _gets buffer_input
    mov rdi, buffer_input
    sub rsp, 8
    call validar_eleccion_jugada ;Valida la elección del usuario
    add rsp, 8

    cmp rax, 2 ; Si elige finalizar la partida, salta al final del juego
    je finalizar_juego


finalizar_juego: 
    _printf mensaje_final

    ;Acá va a estar el mensaje que muestra todas las estadisticas
    ;.....
    ret

