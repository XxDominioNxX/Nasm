section .text
global _start

_start:
    push 2          ; третий параметр
    push 3          ; второй параметр
    push 4          ; первый параметр
    call max_of_three
    add esp, 12     ; очищаем стек
    
    ; Сохраняем результат и выводим
    push eax        ; сохраняем результат
    call print_number
    add esp, 4      ; очищаем стек
    
    ; Завершаем программу
    mov eax, 1      ; sys_exit
    mov ebx, 0      ; код возврата
    int 0x80

max_of_three:
    push ebp
    mov ebp, esp
    
    ; Получаем параметры из стека
    mov eax, [ebp+8]    ; первый параметр
    mov ebx, [ebp+12]   ; второй параметр
    mov ecx, [ebp+16]   ; третий параметр
    
    ; Используем eax как текущий максимум
    cmp eax, ebx
    jge check_third
    mov eax, ebx

check_third:
    cmp eax, ecx
    jge done
    mov eax, ecx

done:
    pop ebp
    ret

; Простая функция вывода числа (для 0-9)
print_number:
    push ebp
    mov ebp, esp
    
    ; Преобразуем число в ASCII
    mov eax, [ebp+8]    ; получаем число
    add eax, '0'        ; преобразуем в символ
    mov [result], al    ; сохраняем в буфер
    
    ; Выводим результат
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, result     ; буфер
    mov edx, 1          ; длина
    int 0x80
    
    ; Выводим новую строку
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    pop ebp
    ret

section .data
    newline db 10       ; символ новой строки
    result db 0         ; буфер для результата

section .bss
