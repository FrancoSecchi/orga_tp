global validarEleccionMenu

section .data
    opcion_cargar             db "1",0
    opcion_nueva_partida              db "0",0

section .bss
    caracter_ingresado                    resb 1

section .text

validarEleccionMenu:
    mov al, [rdi]
    mov [caracter_ingresado], al

    mov     al,[opcion_cargar]
    cmp     al,[caracter_ingresado]
    je      eleccionCargarPartida

    mov     al,[opcion_nueva_partida]
    cmp     al,[caracter_ingresado]
    je      eleccionNuevaPartida


opcionInvalida:
    mov     rax,-1
    ret

eleccionCargarPartida:
    mov     rax,1
    ret

eleccionNuevaPartida:
    mov     rax, 0
    ret