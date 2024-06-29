global main

extern cargar_partida_archivo
extern guardar_partida_archivo
extern validar_eleccion_menu
extern validar_eleccion_jugada
extern personalizaTablero
extern mostrarTablero

%include "utils_macros.asm"
%include "mostrar_tablero"

section .data
    mensaje_menu             db "Menu principal",10,10,"Vamos a jugar al Zorro y las Ocas!",10,"Seleccione una opción para jugar (ingresar número de opción)",10,"  0 - Nueva partida",10,"  1 - Cargar partida",10,0 
    mensaje_opcion_incorrecta     db "La opcion elegida no es valida, por favor ingrese una opcion valida.",10,0 
    mensaje_controles_generales db "CONTROLES: Los controles ingresados deben estar en MAYÚSCULAS",10," Ingresar uno de los caracteres indicados.",10,"(G) Guardar Partida - (S) Salir del Juego - (1 - 8) Movimiento",10,10,0

    mensaje_entrada db "Ingrese una opcion:  ",0
    mensaje_inicio_partida db "Empezamos a jugar!!",10 ,0
    cmd_clear db "clear",0

    mensaje1 db "Cargar partida",10,0
    mensaje2 db "Nueva partida",0
    mensaje_final db "Fin del juego",10,0

    mensaje_turno_zorro     db "Es el turno del zorro",10,0
    mensaje_turno_oca       db "Es el turno de las ocas",10,0
    turno_de_zorro_oca      db 0 ;si es el turno del zorro le sumo 1, si es el turno de la oca --> le resto 1

    ; Variables de partida - en orden específico.
    ; Todos los simbolos son un carácter ASCII
        
    mover_zorro                    db "Ingrese una opción 1: Arriba, 2: Abajo, 3: Izquierda, 4: Derecha, 5: DiagArrIzq, 6: DiagArrDer, 7: DiagAbjIzq, 8: DiagAbjDer, S: Salir", 0
    mensaje_movi_zorro_invalido     db "Movimiento del zorro invalida, ingrese una posicion valida", 10, 0
   ; msj_turno_oca db "Ingresar fil y col: "10,0

    mensaje_selec_oca_fila  db "Ingrese fila de la oca que quiere seleccionar o 'S' para salir: ", 0
    mensaje_selec_oca_col   db "Ingrese columna de la oca que quiere seleccionaro 'S' para salir: ", 0
    mensaje_posicion_ocas_invalido      db "Posicion de oca invalida, ingrese una posicion valida", 0

    mensaje_movi_oca        db "Ingrese una opcion de movimiento 1: Adelante, 2: Izquierda, 3: Derecha, S: Salir: ", 0
    mensaje_movi_oca_invalido          db "Movimiento invalido, ingrese un movimiento valido", 10, 0

    cant_ocas_comido    db 0 
    
	LONG_ELEM	equ	1
	CANT_FIL	equ	7
	CANT_COL	equ	7

section .bss

    buffer_input    resb   1
    ; Define una etiqueta que apunta a todo el bloque de memoria que almacena el estado del juego.
    ; Este bloque consiste en múltiples variables, cada una representando una parte del estado del juego.
    ; El tamaño total de este bloque es de 95 bytes.
    ; 
    ; "times 0 resb 95" no reserva espacio adicional, simplemente crea una etiqueta
    ; que apunta a la ubicación donde se encuentran las siguientes variables.
    registroDatosPartida    times 0 resb 95 ; Es una etiqueta 


    cant_mov_izq          resw 500
    cant_mov_der          resw 500
    cant_mov_abajo        resw 500
    cant_mov_arriba       resw 500
    cant_mov_arriba_der   resw 500
    cant_mov_arriba_izq   resw 500
    cant_mov_abajo_der    resw 500
    cant_mov_abajo_izq    resw 500

    fil                   resb 1
    col                   resb 1

    ; voy a actual la pos de zorro cada moviento
    pos_fil_zorro       resb 1
    pos_col_zorro       resb 1
    movi_zorro          resb 1

    pos_col_oca_ori     resb 1 
    pos_fil_oca_ori     resb 1

    pos_fil_oca_mov     resb 1
    pos_col_oca_mov     resb 1

    movi_oca            resb 1



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
    ; jmp finalizar_juego

jugar: 
    ;Acá se imprime el tablero
    _printf mensaje_controles_generales
    sub rsp, 8
    call personalizaTablero
    add rsp, 8

    mov [tablero], rdi ;en rdi esta el dir de tablero

    sub rsp, 8
    call mostrarTablero
    add rsp,8
; ----------------------------------------------
ingresar_jugada: 
 
    _gets buffer_input
    mov rdi, buffer_input
    sub rsp, 8
    call validar_eleccion_jugada ;Valida la elección del usuario
    add rsp, 8

    cmp rax, 2 ; Si elige finalizar la partida, salta al final del juego
    je finalizar_juego

    ; cmp mov_adelante, [rax]
    ; inc mov_ad

    cmp byte[turno_de_zorro_oca],0
    je turno_zorro ;movimiento del zorro
    cmp byte[turno_de_zorro_oca],1
    je turno_oca   ;movimiento de la oca

turno_zorro:
    
    sub rsp, 8
    call buscar_zorro
    add  rsp, 8
pedir_mov:
    _printf mensaje_controles_generales
    _printf msj_turno_zorro
    _gets   fil
    mov rdi, fil
    _gets   col
    mov rcx, col
    sub rsp, 8
    call validar_moviento_zorro ;Valida la elección del usuario
    add rsp, 8

validar_moviento_zorro:
    ret;aux

buscar_zorro:
    mov rcx,49
    mov rbx,tablero
    mov rdi,0
l:
    mov ax,[rbx+rdi]
    cmp ax,2   ;aca va el simbolo de el zorro ─> 2
    je  guadar_posicion_zorro
    inc rdi
    loop l

guadar_posicion_zorro:
    mov qword[pos_zorro],rdi
    jmp pedir_mov

turno_oca:
    _printf mensaje_selec_oca_fila
    _gets pos_fil_oca_ori
    ; recibo un num de fil, si ingresa S significa salir del juego
    mov rdi, pos_col_oca_ori
    call chequear_si_terminar_el_juego

    _printf mensaje_selec_oca_col
    _gets pos_col_oca_ori
    ; recibo un num de col, si ingresa S significa salir del juego
    mov rdi, pos_col_oca_ori
    call chequear_si_terminar_el_juego

    
    ; Ahora ya tengo dos indices
    call validar_posicion_oca
    ; si es 0 significar es valido la posicion, si es distinto, volver a pedir posicion
    cmp     al, "0"
    jne     turno_oca

recibir_movimienro_oca:
    _printf mensaje_movi_oca
    _gets   movi_zorro
    ; si es s, salir el juego
    call    chequear_si_terminar_el_juego

    cmp     byte [moverOcaA], '1'
    je      incrementarCol
    cmp     byte [moverOcaA], '2'
    je      decrementarFil
    cmp     byte [moverOcaA], '3'
    je      incrementarFil

incrementarCol:
    mov     al, [pos_col_oca_ori]
    add     al, 1
    mov     [pos_col_oca_mov], al

    mov     [pos_fil_oca_mov], [pos_col_oca_mov]
    ; Tengo que cheaquear si es valido el movimiento
    jmp     validar_nuevo_posi_oca
    ret

decrementarFil:
    mov     al, [pos_fil_oca_ori]
    sub     al, 1
    mov     [pos_fil_oca_mov], al

    mov     [pos_col_oca_mov], [pos_col_oca_ori]
    jmp     validar_nuevo_posi_oca
    ret

incrementarFil:
    mov     al, [pos_fil_oca_ori]
    add     al, 1
    mov     [pos_fil_oca_mov], al

    mov     [pos_col_oca_mov], [pos_col_oca_ori]
    jmp     validar_nuevo_posi_oca
    ret

validar_posicion_oca:
    _buscar_caracter pos_fil_oca_ori, pos_col_oca_ori
    cmp     al, "0"
    je      esValido
    jne     mensaje_ingreso_invalido

esValido:
    mov     al, "0"
    ret

mensaje_ingreso_invalido:
    _printf mensaje_posicion_ocas_invalido
    jmp     turno_oca
    ret

validar_nuevo_posi_oca:
    ; veo que la oca no se pueda mover a una posicion ocupada o que no sea un '-' (lugar vacio)
    _buscar_caracter pos_fil_oca_mov, pos_col_oca_mov
    cmp     al, '0'
    je      mover_oca
    jne     mov_invalido_Oca

mov_invalido_Oca:
    ; voy a volver a pedir a seleccionar oca
    _printf mensaje_movi_oca_invalido
    jmp turno_oca
    ret

mover_oca:
    ; va a mover la oca
    _desplazamiento pos_col_oca_ori, pos_fil_oca_ori
    ; ebx esta apuntado a pos viejo de oca
    ; cambiar el pos original a 0(vacio)
    mov     al, "0"
    mov     ebx, al 

    _desplazamiento pos_col_oca_mov, pos_fil_oca_mov
    mov     al, "1"
    mov     ebx, al

    ; falta de verificar si se gana oca o no

    mov     byte [turno_de_zorro_oca], 0 ; cambio el turno

    jmp mostrarTablero
    ret


chequear_si_terminar_el_juego:
    cmp byte [rdi], 'S'
    je finalizar_juego
    ret

finalizar_juego: 
    _printf mensaje_final

    ;Acá va a estar el mensaje que muestra todas las estadisticas
    ;.....
    ret


