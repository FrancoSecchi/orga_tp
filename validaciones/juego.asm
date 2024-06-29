global validar_eleccion_jugada
global validar_moviento_zorro
global validar_posicion_oca

extern pos_fil_oca_mov
extern pos_col_oca_mov
extern pos_col_oca_ori
extern pos_fil_oca_ori


section .data
    caracter_salir_juego db "S",0
    mensaje_posicion_ocas_invalido      db "Posicion de oca invalida, ingrese una posicion valida", 0
    mensaje_movi_oca_invalido           db "Movimiento invalido, ingrese un movimiento valido", 0

section .bss
    caracter_ingresado                  resb 1

section .text

validar_eleccion_jugada: 
    mov al, [rdi]
    mov [caracter_ingresado], al

    mov al, [caracter_salir_juego]
    cmp al, [caracter_ingresado]
    je opcion_finalizar_juego

opcion_finalizar_juego: 
    mov rax, 2
    ret

validar_moviento_zorro:
    mov al,[rdi]
    cmp al,1
    je opcion_adelante

ejecutar_movimiento:
    ret

opcion_adelante:
    ret; aux

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
    mov     al, "-1"
    ret

validar_nuevo_posi_oca:
    ; veo que la oca no se pueda mover a una posicion ocupada o que no sea un '-' (lugar vacio)
    _buscar_caracter pos_fil_oca_mov, pos_col_oca_mov
    cmp     al, '0'
    je      esValido
    jne     mov_invalido_Oca

mov_invalido_Oca:
    ; voy a volver a pedir a seleccionar oca
    _printf mensaje_movi_oca_invalido
    mov     al, "-1"
    ret

validar_ganar_ocas:
    ; tengo que chequear si el zorro queda "acorralado"
