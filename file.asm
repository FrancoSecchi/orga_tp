global cargar_partida_archivo
global guardar_partida_archivo

extern fopen
extern fread
extern fwrite
extern fclose

%include "utils_macros.asm"

section .data

    nombre_archivo db "partida.dat",0
	msg_error	db  "Error en apertura de archivo",10,0
    modo_lectura_escritura  db "r+",0 ;Abre un archivo para lectura y escritura. El archivo debe existir.

    mensaje db "Se abrio el archivo",10, 0
    mensaje2 db "Se cerro el archivo",10, 0

section .bss
    id_archivo resq 1
    estado_accion resq 1


section .text

%macro abrir_archivo 0 
    mov rdi, nombre_archivo 
    mov rsi, modo_lectura_escritura
    sub rsp, 8
    call fopen
    add rsp, 8
%endmacro


%macro cerrar_archivo 0 
    mov rdi, [id_archivo] 
    sub rsp, 8
    call fclose
    add rsp, 8
%endmacro


cargar_partida_archivo: 
    abrir_archivo
    
    cmp rax, 0
    je imprimirMesanjeError

    mov qword[id_archivo], rax
    mov qword[estado_accion], rax


    cerrar_archivo

    cmp rax, qword[estado_accion]
    je imprimir_mesanje_error


    ret

guardar_partida_archivo: 


imprimir_mesanje_error: 
    _printf msg_error
    mov rax, 0
    ret

retornar: 
    ret

imprimirMesanjeError:
    ret ;para probar