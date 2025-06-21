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
    .date:   resb date_size
endstruc
section .text
    global sort_events
    extern printf

sort_events:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    xor eax, eax
loop1:
    mov edx, eax
    add edx, 1
    push eax
    mov eax, ebx

loop2: ;avem 2 pozitii in struct si le compar
    movzx esi, byte[ebx + event.valid]
    cmp edx, ecx
        je final_2
    add eax, event_size
    movzx edi, byte[eax + event.valid]
    cmp esi, edi
        jg deja_inversate
    cmp esi, edi
        je dupa_cmp_valabilitate
        ;initial compar dupa validitate
        ;si schimb datele dintre elementele
        xor esi, esi
        mov edi, eax
loop_inversare:
    ;un loop unde inversez datele
        push eax
        push edx
        mov al, [ebx + esi]
        mov dl, [edi]
        mov [edi], al
        mov [ebx + esi], dl
        pop eax
        pop edx
        inc edi
        inc esi
        cmp esi, event_size
            jne loop_inversare
    jmp deja_inversate
dupa_cmp_valabilitate:

    ;apoi sortez dupa an
    movzx esi, word[ebx + event.date + date.year]
    movzx edi, word[eax + event.date + date.year]
    cmp esi, edi
        jl deja_inversate
    cmp esi, edi
        je dupa_cmp_an
        ;compar dupa an
        xor esi, esi
        mov edi, eax
loop_inversare_an:
    ;un loop unde inversez datele
        push eax
        push edx
        mov al, [ebx + esi]
        mov dl, [edi]
        mov [edi], al
        mov [ebx + esi], dl
        pop eax
        pop edx
        inc edi
        inc esi
        cmp esi, event_size
            jne loop_inversare_an
    jmp deja_inversate
dupa_cmp_an:

    ;apoi sortez dupa luna
    movzx esi, byte[ebx + event.date + date.month]
    movzx edi, byte[eax + event.date + date.month]
    cmp esi, edi
        jl deja_inversate
    cmp esi, edi
        je dupa_cmp_luna
        ;compar dupa luna
        xor esi, esi
        mov edi, eax
loop_inversare_luna:
    ;un loop unde inversez datele
        push eax
        push edx
        mov al, [ebx + esi]
        mov dl, [edi]
        mov [edi], al
        mov [ebx + esi], dl
        pop eax
        pop edx
        inc edi
        inc esi
        cmp esi, event_size
            jne loop_inversare_luna
    jmp deja_inversate
dupa_cmp_luna:
;apoi sortez dupa zi
    movzx esi, byte[ebx + event.date + date.day]
    movzx edi, byte[eax + event.date + date.day]
    cmp esi, edi
        jl deja_inversate
    cmp esi, edi
        je dupa_cmp_zi
        ;compar dupa zi
        xor esi, esi
        mov edi, eax
loop_inversare_zi:
    ;un loop unde inversez datele
        push eax
        push edx
        mov al, [ebx + esi]
        mov dl, [edi]
        mov [edi], al
        mov [ebx + esi], dl
        pop eax
        pop edx
        inc edi
        inc esi
        cmp esi, event_size
            jne loop_inversare_zi
    jmp deja_inversate
dupa_cmp_zi:
    ;apoi ramane de comparat lexicografic
    ;aici e nevoie de inca o iteratie pentru a compara toate elementele
    push ecx
    xor ecx, ecx
loop_31_elem_lexi:
    movzx esi, byte[ebx + ecx]
    movzx edi, byte[eax + ecx]
    cmp esi, edi
        jl deja_inversate_lexi
    cmp esi, edi
        je dupa_cmp_lexi
        ;compar lexicografic
        xor esi, esi
        mov edi, eax
loop_inversare_lexi:
    ;un loop unde inversez datele
        push eax
        push edx
        mov al, [ebx + esi]
        mov dl, [edi]
        mov [edi], al
        mov [ebx + esi], dl
        pop eax
        pop edx
        inc edi
        inc esi
        cmp esi, event_size
            jne loop_inversare_lexi
    jmp deja_inversate_lexi
dupa_cmp_lexi:
    inc ecx
    cmp ecx, 31
        jne loop_31_elem_lexi
deja_inversate_lexi:
    pop ecx
deja_inversate:
    inc edx
    cmp edx, ecx
        jne loop2
final_2:
    pop eax
    inc eax
    add ebx, event_size
    cmp eax, ecx
        jne loop1
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
