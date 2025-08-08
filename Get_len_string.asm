section .data
    hello db "Hello? ", 0
    newline db 10           ; символ новой строки

section .bss
    buffer resb 20          ; буфер для строки числа

section .text
global _start

_start:
    mov rdi, hello
    call str_len
    call print_number
    
    
    mov rdi, rax
    mov rax, 60
    syscall


; Функция strlen: вычисляет длину null-terminated строки
; Вход: rdi = адрес строки
; Выход: rax = длина строки
str_len:
    push rbp
    mov rbp, rsp
    
    xor rax, rax
    
str_len_loop:
    mov cl, [rdi + rax]
    test cl, cl
    jz strlen_done
    
    inc rax
    jmp str_len_loop

strlen_done:
    pop rbp
    ret
    
    
    
    
; Функция вывода числа
; Вход: rax = число для вывода
print_number:
    push rbp
    mov rbp, rsp
    
    mov rbx, 10             ; делитель
    mov rcx, 0              ; счетчик цифр
    mov rdi, buffer         ; адрес буфера
    add rdi, 19             ; указываем на конец буфера
    mov byte [rdi], 0       ; null terminator
    dec rdi                 ; перемещаемся к предыдущему байту
    
convert_loop:
    xor rdx, rdx            ; очищаем старшие биты для деления
    div rbx                 ; rax = rax / 10, rdx = остаток
    add dl, '0'             ; преобразуем остаток в ASCII
    mov [rdi], dl           ; сохраняем цифру
    dec rdi                 ; перемещаемся назад
    inc rcx                 ; увеличиваем счетчик цифр
    test rax, rax           ; проверяем, есть ли еще цифры
    jnz convert_loop        ; если да, продолжаем
    
    inc rdi                 ; указываем на первую цифру
    
    ; Выводим строку
    mov rax, 1              ; sys_write
    mov rsi, rdi            ; адрес строки числа
    mov rdx, rcx            ; длина строки
    mov rdi, 1              ; stdout
    syscall
    
    pop rbp
    ret
