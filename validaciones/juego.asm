global validar_eleccion_jugada

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
