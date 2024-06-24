global validarEleccionMenu

section .data
    opcion_cargar             db "1",0
    opcion_nueva_partida              db "0",0

section .bss
    caracter_ingresado                    resb 1

section .text

validarEleccionMenu:
    mov al, [rdi] ; en rdi esta el valor del buffer_input y lo mando al registro "al" ya qu es de 1 byte
    mov [caracter_ingresado], al

    mov al, [opcion_cargar]
    cmp al, [caracter_ingresado] ;Comparo si la opcion que eligio es la de cargar
    je eleccionCargarPartida

    mov al,[opcion_nueva_partida]
    cmp al,[caracter_ingresado] ;Comparo si la opcion que eligio es la de nueva partida
    je  eleccionNuevaPartida


opcionInvalida:
    mov     rax,-1
    ret

eleccionCargarPartida:
    mov     rax,1 
    ret

eleccionNuevaPartida:
    mov     rax, 0
    ret