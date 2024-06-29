
extern gets
extern printf
extern system

%macro _printf 1
    mov     rdi,%1
    sub     rsp,8
    call    printf
    add     rsp,8
%endmacro
%macro  _gets   1
    mov     rdi,%1
    sub     rsp,8
    call    gets
    add     rsp,8
%endmacro 
%macro  _limpiarCmd 0
    mov     rdi,cmd_clear
    sub     rsp,8
    call    system
    add     rsp,8
%endmacro

%macro _desplazamiento 3
    mov ebx, [%tablero]
    mov eax, [%2]
    sub eax, 1 
    imul eax, 8 
    mov ecx, eax 
    mov eax, [%3]
    sub eax, 1 
    add ecx, eax 
    add ebx, ecx
%endmacro 

%macro buscar_caracter 2
    ; en ebx tengo la direccion de memoria de la posicion que quiero ver
    ; el caracter se devuelve en 'al'
    mDesplazamiento %1, %2
    mov [valor], ebx 
    mov rdi, [valor]
    movzx eax, byte [rdi]

%endmacro