%include "utils_macros.asm"

global personalizaTabla

section .data
    mensajePersonalizar  db " ** PERSONALIZACIÓN **",10,10,"Este es el menú de personalización de partida. Si se quiere jugar con las configuraciones por defecto, ingrese s sin modificar nada.",10,0
    orientacionDefault      db "N"
    simboloOcasDefault      db "O"
    simboloZorroDefault     db "X"
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
    imput                   resb 1 ; es un char ascii
    orientacion             resb 1 ; es un char ascii
    simboloOcas             resb 1 ; es un char ascii
    simboloZorro            resb 1 ; es un char ascii

personalizaTabla
    _printf, mensajePersonalizar

personalizaOrientacion
    _printf, mensajeIngresarOrientacion
    _gets, orientacion ; guarda la orientacion en imput
    

orientacionInvalido

personalizaOcas
    _printf, mensajeIngresarSimboloOcas
    _gets, simboloOcas

personalizaZorro
    _printf, mensajeIngresarSimboloZorro
    _gets, simboloZorro