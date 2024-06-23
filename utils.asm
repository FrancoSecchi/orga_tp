
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