%include "utils_macros.asm"

global personalizaTabla

extern validarOrientacion

section .data
    mensajePersonalizar  db " ** PERSONALIZACIÓN **",10,10," Este es el menú de personalización de partida. Si se quiere jugar con las configuraciones por defecto, ingrese 3 sin modificar nada.",10, " 0 - Personalizar la tabla (default: N)", 10, " 1 - Personalizar el simbolo del zorro (default: X)", 10, "2 - Personalizar el simbolo de ocas (default: O)", 10, 0
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

section .bss
    input                   resb 1 ; es un char ascii
    orientacion             resb 1 ; es un char ascii
    simboloOcas             resb 1 ; es un char ascii
    simboloZorro            resb 1 ; es un char ascii

personalizaTabla
    _printf, mensajePersonalizar
    _gets, input ; chequar si necesita tabla personalizada

    mov     rdi, 8
    call    personalización

personalizaOrientacion
    _printf, mensajeIngresarOrientacion
    _gets, input ; guarda la orientacion en input
    mov     rdi, [input]
    sub     rsp, 8
    call    validarOrientacion ; verifica si el input es valido
    add     rep, 8

    cmp     rax, 0 ; si es menor que 0, el input es invalido
    jl      orientacionInvalido

    ; si es valido, guardo en orientacion
    mov     al, [input]
    mov     [orientacion], al
    jmp     personalizaOcas

orientacionInvalido
    _printf, mensajeCaracterInvalido
    jmp     personalizaOrientacion

personalizaOcas
    _printf, mensajeIngresarSimboloOcas
    _gets, simboloOcas ; no puede ser igual que el simbolo de zorro
    mov     rdi, [input]
    sub     rsp, 8
    call    validarOcas

personalizaZorro
    _printf, mensajeIngresarSimboloZorro
    _gets, simboloZorro
