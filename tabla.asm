global tabla

%macro Mprintf 1
    mov     rdi,%1
    sub     rsp,8
    call    printf
    add     rsp,8
%endmacro

extern printf

section .data
; -1 significa invalido, " " significa vacio
    tabla times 56 db -1, -1, "|","O", "O", "O", "|", -1, -1
                      -1, -1, "|","O", "O", "O", "|", -1, -1
                      "|", "O", "O", "O","O", "O", "O", "O", "|"
                      "|", "O", " ", " ", " ", " ", " ", "O", "|"
                      "|", "O", " ", " ", "X", " ", " ", "O", "|"
                      -1, -1, "|"," ", " ", " ", "|", -1, -1
                      -1, -1, "|"," ", " ", " ", "|", -1, -1
                      
    longfil        db 9
    longelem       db 1
    zorro          db "X"
    oca            db "O"
    pared          db "|"
    techo          db "------------------------------", 10, 0

tabla

imprimir_tabla:
    Mprintf, techo
    mov     rbx, tabla   ; Puntero al inicio de la tabla
    mov     rax, 0       ; Índice de fila

    fila_loop:
        mov     edx, 0       ; Índice de columna
        
        columna_loop:
            mov     eax, rax     ; Fila actual
            imul    eax, 9    ; Multiplicar por el número de columnas (9 elementos por fila)
            add     eax, edx   ; Sumar el índice de columna
            add     eax, rbx   ; Añadir el puntero base de la tabla

            cmp     byte [rax], -1 ; si es -1 significa es invalido, no voy a imprimir
            je      columna_loop
            
            Mprintf, eax

            inc edx ;Incrementar el indice de columna
            cmp     edx, 8
            jne     columna_loop

        ; Incrementar el índice de fila
        inc rax

        ; Comparar con el final de la tabla
        cmp rax, 7
        jne fila_loop
    Mprintf, techo
