%include "../include/io.mac"

; declare your structs here

struc date
    .day:    resb 1
    .month:  resb 1
    .year:   resw 1
endstruc

struc event
    .name:   resb 31
    .valid:  resb 1
    .date:  resb date_size
endstruc

section .data

section .text
    global check_events
    extern printf

check_events:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    ;parcurg toate numerele
loop:
    mov byte[ebx + event.valid], 1
    movsx edx, word [ebx + event.date + date.year]
    cmp edx, 1989;compar daca anul e bun
        jg next_an_1989
        mov byte[ebx + event.valid], 0
        jmp final
next_an_1989:
    cmp edx, 2031
        jl next_an_2031
        mov byte[ebx + event.valid], 0
        jmp final
next_an_2031:
    movsx edx, byte [ebx + event.date + date.month]
    cmp edx , 0
        jg next_luna_0
        mov byte[ebx + event.valid], 0
        jmp final
next_luna_0:
    cmp edx , 13;compar daca luna e buna
        jl next_luna_13
        mov byte[ebx + event.valid], 0
        jmp final
next_luna_13:
    ; edx e luna acum
    movsx eax, byte [ebx + event.date + date.day]
    cmp eax , 0;pt fiecare tip de luna, compar cu 0 si cu 28/30/31
        jg next_zi_0
        mov byte[ebx + event.valid], 0
        jmp final
next_zi_0:
    mov edi, 32
    cmp edx , 2
        jne nu_e_feb
        mov edi, 29
nu_e_feb:
    cmp edx , 4
        jne nu_e_apr
        mov edi, 31
nu_e_apr:
    cmp edx , 6
        jne nu_e_iun
        mov edi, 31
nu_e_iun:
    cmp edx , 9
        jne nu_e_sep
        mov edi, 31
nu_e_sep:
    cmp edx , 11
        jne nu_e_nov
        mov edi, 31
nu_e_nov:
    cmp eax , edi
        jl next_zi_32
        mov byte[ebx + event.valid], 0
        jmp final
next_zi_32:
next_zi_29:
final:
    sub ecx, 1
    add ebx, event_size
    cmp ecx , 0
        jne loop
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
