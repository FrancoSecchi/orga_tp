global validar_eleccion_jugada
global validar_moviento_zorro

section .data

    caracter_salir_juego db "S",0

section .bss
    caracter_ingresado  resb 1
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
    mov 