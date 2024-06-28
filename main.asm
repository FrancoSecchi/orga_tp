global main

%include "utils_macros.asm"


extern cargar_partida_archivo
extern guardar_partida_archivo
extern validar_eleccion_menu
extern validar_eleccion_jugada

section .data
    mensaje_menu             db "Menu principal",10,10,"Vamos a jugar al Zorro y las Ocas!",10,"Seleccione una opción para jugar (ingresar número de opción)",10,"  0 - Nueva partida",10,"  1 - Cargar partida",10,0 
    mensaje_opcion_incorrecta     db "La opcion elegida no es valida, por favor ingrese una opcion valida.",10,0 
    mensaje_controles_generales db "CONTROLES: Los controles ingresados deben estar en MAYÚSCULAS",10," Ingresar uno de los caracteres indicados.",10,"(G) Guardar Partida - (S) Salir del Juego - (1 - 8) Movimiento",10,0

    mensaje_entrada db "Ingrese una opcion:  ",0
    mensaje_inicio_partida db "Empezamos a jugar!!",10 ,0
    cmd_clear db "clear",0

    mensaje1 db "Cargar partida",10,0
    mensaje2 db "Nueva partida",10,0
    mensaje_final db "Fin del juego",10,0

    mensaje_turno_zorro     db "Es el turno del zorro",10,0
    mensaje_turno_oca       db "Es el turno de las ocas",10,0
    turno_de_zorro_oca    db 0 ;si es el turno del zorro le sumo 1, si es el turno de la oca --> le resto 1







section .bss
    ; Define una etiqueta que apunta a todo el bloque de memoria que almacena el estado del juego.
    ; Este bloque consiste en múltiples variables, cada una representando una parte del estado del juego.
    ; El tamaño total de este bloque es de 95 bytes.
    ; 
    ; "times 0 resb 95" no reserva espacio adicional, simplemente crea una etiqueta
    ; que apunta a la ubicación donde se encuentran las siguientes variables.
    registroDatosPartida    times 0 resb 95 ; Es una etiqueta 

    ; Variables de partida - en orden específico.
    ; Todos los simbolos son un carácter ASCII
    tablero                 resb 49         

    ;  -1 : lugar invalido, 1: ocas, 3: zorro, 0: lugar vacio 
    tableroNorte        db -1,-1, 1, 1, 1,-1,-1
                        db -1,-1, 1, 1, 1,-1,-1
                        db  1, 1, 1, 1, 1, 1, 1
                        db  1, 0, 0, 0, 0, 0, 1
                        db  1, 0, 0, 3, 0, 0, 1
                        db -1,-1, 0, 0, 0,-1,-1
                        db -1,-1, 0, 0, 0,-1,-1
    
    tableroSur          db -1,-1, 0, 0, 0,-1,-1
                        db -1,-1, 0, 0, 0,-1,-1
                        db  1, 0, 0, 3, 0, 0, 1
                        db  1, 0, 0, 0, 0, 0, 1
                        db  1, 1, 1, 1, 1, 1, 1
                        db -1,-1, 1, 1, 1,-1,-1
                        db -1,-1, 1, 1, 1,-1,-1
    
    tableroEste         db -1,-1, 1, 1, 1,-1,-1
                        db -1,-1, 0, 0, 1,-1,-1
                        db  0, 0, 0, 0, 1, 1, 1
                        db  0, 0, 2, 0, 1, 1, 1
                        db  0, 0, 0, 0, 1, 1, 1
                        db -1,-1, 0, 0, 1,-1,-1
                        db -1,-1, 1, 1, 1,-1,-1

    tableroOeste        db -1,-1, 1, 1, 1,-1,-1
                        db -1,-1, 1, 0, 0,-1,-1
                        db  1, 1, 1, 0, 0, 0, 0
                        db  1, 1, 1, 0, 2, 0, 0
                        db  1, 1, 1, 0, 0, 0, 0
                        db -1,-1, 1, 0, 0,-1,-1 
                        db -1,-1, 1, 1, 1,-1,-1

    mov_ad db 

    movimientos_totales db 0 ;para definir los turnos si es un numero par es el turno del zorro, si es impar de las ocas 


    cant_mov_izq          resw 500
    cant_mov_der          resw 500
    cant_mov_abajo        resw 500
    cant_mov_arriba       resw 500
    cant_mov_arriba_der   resw 500
    cant_mov_arriba_izq   resw 500
    cant_mov_abajo_der    resw 500
    cant_mov_abajo_izq    resw 500

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

    jmp jugar


nueva_partida: 
    _printf mensaje2
    jmp finalizar_juego

jugar: 
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

    cmp mov_adelante, [rax]
    inc mov_ad

    cmp byte[turno_de_zorro_oca],0
    je turno_zorro ;movimiento del zorro
    cmp byte[turno_de_zorro_oca],1
    je turno_oca   ;movimiento de la oca



finalizar_juego: 
    _printf mensaje_final

    ;Acá va a estar el mensaje que muestra todas las estadisticas
    ;.....
    ret





