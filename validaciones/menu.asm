global validar_eleccion_menu
global validarOrientacion

section .data
    opcion_cargar                       db "1",0
    opcion_nueva_partida                db "0",0

    orientacionNorte                    db "N",0
    orientacionSur                      db "S",0
    orientacionEste                     db "E",0
    orientacionOeste                    db "O",0

section .bss
    caracter_ingresado                    resb 1

section .text

validar_eleccion_menu:
    mov al, [rdi] ; en rdi esta el valor del buffer_input y lo mando al registro "al" ya qu es de 1 byte
    mov [caracter_ingresado], al

    mov al, [opcion_cargar]
    cmp al, [caracter_ingresado] ;Comparo si la opcion que eligio es la de cargar
    je eleccion_cargar_partida

    mov al,[opcion_nueva_partida]
    cmp al,[caracter_ingresado] ;Comparo si la opcion que eligio es la de nueva partida
    je  eleccion_nueva_partida


opcion_invalida:
    mov     rax,-1
    ret

eleccion_cargar_partida:
    mov     rax,1 
    ret

eleccion_nueva_partida:
    mov     rax, 0
    ret

validarOrientacion:
    mov     al, [rdi] ; en rdi esta el valor del input
    mov     [caracter_ingresado], al

    mov     al, [orientacionNorte]
    cmp     al, [caracter_ingresado] ;Comparo si ingresa la orientacion norte
    je      eleccion_orientacion

    mov     al, [orientacionEste]
    cmp     al, [caracter_ingresado] ;Comparo si ingresa la orientacion Este
    je      eleccion_orientacion

    mov     al, [orientacionSur]
    cmp     al, [caracter_ingresado] ;Comparo si ingresa la orientacion sur
    je      eleccion_orientacion

    mov     al, [orientacionOeste]
    cmp     al, [caracter_ingresado] ;Comparo si ingresa la orientacion oeste
    je      eleccion_orientacion

ingresadoInvalido:
    mov     rax, -1
    ret

eleccion_orientacion:
    mov     rax, 0
    ret





