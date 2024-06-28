%include "utils_macros.asm"

global personalizaTablero
global mostrarTablero


extern validarOrientacion
extern validar_ingreso_personalizacion

section .data
    mensajePersonalizar  db " ** PERSONALIZACIÓN **",10,10," Este es el menú de personalización de partida. Si se quiere jugar con las configuraciones por defecto,",10, "ingrese 3 sin modificar nada.",10, " 0 - Personalizar la tabla (default: N)", 10, " 1 - Personalizar el simbolo del zorro (default: X)", 10, " 2 - Personalizar el simbolo de ocas (default: O)", 10, 0
    orientacionDefault      db "N"
    simboloOcasDefault      db "O"
    simboloZorroDefault     db "X"

    orientacionNorte        db "N"
    orientacionSur          db "S"
    orientacionEste         db "E"
    orientacionOeste        db "O"
    mensajeIngresarOrientacion  db "Ingrese una orientación. Las opciones se eligen según dónde comienzan las Ocas.",10,"  N - Norte (las ocas comienzan arriba)",10,"  S - Sur (las ocas comienzan abajo)",10,"  E - Este (las ocas comienzan a la derecha)",10,"  O - Oeste (las ocas comienzan a la izquierda)",10,0
    mensajeCaracterInvalido     db "El caracter que se ingresó no es válido.",10,0
    mensajeIngresarSimboloOcas  db "Ingrese un símbolo para representar las OCAS. No puede ser un espacio ni tampoco el símbolo del zorro.",10,0
    mensajeIngresarSimboloZorro db "Ingrese un símbolo para representar el ZORRO. No puede ser un espacio ni tampoco el símbolo de las ocas.",10,0

    ; Todos los simbolos son un carácter ASCII   

    ;  -1 : lugar invalido, 1: ocas, 2: zorro, 0: lugar vacio 
    tableroNorte        db -1,-1, 1, 1, 1,-1,-1
                        db -1,-1, 1, 1, 1,-1,-1
                        db  1, 1, 1, 1, 1, 1, 1
                        db  1, 0, 0, 0, 0, 0, 1
                        db  1, 0, 0, 2, 0, 0, 1
                        db -1,-1, 0, 0, 0,-1,-1
                        db -1,-1, 0, 0, 0,-1,-1
    
    tableroSur          db -1,-1, 0, 0, 0,-1,-1
                        db -1,-1, 0, 0, 0,-1,-1
                        db  1, 0, 0, 2, 0, 0, 1
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
    
    indice              db "[   1  2  3  4  5  6  7   ]",10,0

section .bss
    input                   resb 1 ; es un char ascii
    orientacion             resb 1 ; es un char ascii
    simboloOcas             resb 1 ; es un char ascii
    simboloZorro            resb 1 ; es un char ascii
    tablero                 resb 49      
    caracter_actual         resb 1


section .text

personalizaTablero:
    _printf mensajePersonalizar
    _gets  input ; chequar si necesita tabla personalizada

    mov     rdi, input
    sub     rsp, 8
    call    validar_ingreso_personalizacion
    add     rsp, 8

    ;si es 0, se modifica la orientacion
    cmp     rax, 0
    je      personalizacionOrientacion

    ;si es 1, se modifica el simbolo de oca
    cmp     rax, 1
    je      personalizacionOcas

    ;si es 2, se modifica el simbolo de zorro
    cmp     rax, 2
    je      personalizacionZorro

    ;si es 3, no modifica nada
    cmp     rax, 3
    je      CrearTablero
    

personalizacionOrientacion:
    _printf mensajeIngresarOrientacion
    _gets input ; guarda la orientacion en input
    mov     rdi, input
    sub     rsp, 8
    call    validarOrientacion ; verifica si el input es valido
    add     rsp, 8

    cmp     rax, 0 ; si es menor que 0, el input es invalido
    jl      orientacionInvalido

    ; si es valido, guarda en orientacion
    mov     al, [input]
    mov     [orientacion], al
    jmp     personalizaTablero

orientacionInvalido:
    _printf mensajeCaracterInvalido
    jmp     personalizacionOrientacion
    ret

personalizacionOcas:
    _printf  mensajeIngresarSimboloOcas
    _gets simboloOcas ; no puede ser igual que el simbolo de zorro
    mov     al, [input]
    cmp     al, [simboloZorro]
    je      simboloOcasInvalido

    ; si es valido, guarda en ocas
    mov     al, [input]
    mov     [simboloOcas], al
    jmp     personalizaTablero


simboloOcasInvalido:
    _printf mensajeCaracterInvalido
    jmp personalizacionOcas
    ret

personalizacionZorro:
    _printf mensajeIngresarSimboloZorro
    _gets simboloZorro
    mov     al, [input]
    cmp     al, [simboloOcas]
    je      simboloZorroInvalido

    ; si es valido, guarda en zorro
    mov     al, [input]
    mov     [simboloZorro], al
    jmp     personalizaTablero

simboloZorroInvalido:
    _printf mensajeCaracterInvalido
    jmp personalizacionZorro
    ret

CrearTablero:
    mov     al, [orientacion]

    cmp     al, [orientacionEste]
    je      elegir_tableroEste

    cmp     al, [orientacionOeste]
    je      elegir_tableroOeste
    
    cmp     al, [orientacionSur]
    je      elegir_tableroSur

    ; si es vacio o es Norte
    jmp      elegir_tableroNorte


elegir_tableroEste:
    mov     rsi, tableroEste ; pasa la direccion de tabla a rsi
    jmp     copiarTablero

elegir_tableroOeste:
    mov     rsi, tableroOeste ; pasa la direccion de tabla a rsi
    jmp     copiarTablero

elegir_tableroSur:
    mov     rsi, tableroSur ; pasa la direccion de tabla a rsi
    jmp     copiarTablero

elegir_tableroNorte:
    mov     rsi, tableroNorte ; pasa la direccion de tabla a rsi
    jmp     copiarTablero

; Va a copiar el cotenido de tabla de memoria apuntado por RSI en RDI
; Compiar tanto bytes como indicado en rcx
copiarTablero:
    mov     rdi, tablero
    mov     rcx, 49
    rep movsb
    ret

mostrarTablero:
    _printf indice       ; Imprime el índice del tablero

    mov     rsi, tablero  ; rSI apunta al inicio del tablero
    mov     rcx, 49       ; Número de bytes en el tablero

mostrar_loop:
    mov     al, [rsi]
    call    determinarSimbolo
    jmp     imprimir

determinarSimbolo:
    cmp     al, -1
    je      imprimirSimboloInvalido

    cmp     al, 2
    je      imprimirSimboloZorro

    cmp     al, 1
    je      imprimirSimboloOcas

    jmp     imprimirSimboloInvalido

imprimirSimboloInvalido:
    mov     al, " "  ; Si el valor es -1, imprime un espacio
    ret

imprimirSimboloZorro:
    mov     al, [simboloZorro]
    ret

imprimirSimboloOcas:
    mov     al, [simboloOcas]
    ret

imprimir:
    mov     [caracter_actual], al  
    _printf  caracter_actual        
    inc     rsi                     
    loop    mostrar_loop            

    ret