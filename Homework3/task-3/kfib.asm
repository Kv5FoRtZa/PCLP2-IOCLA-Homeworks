section .bss
;n este maxim 40
    vector resd 45
section .text
global kfib
global calculare
calculare:
    push ebp
    mov ebp,esp
    ; termenul curent
    mov ecx, [ebp + 8]
    ; k
    mov ebx, [ebp + 12]
    ;n
    mov eax, [ebp + 16]
    ; sirul de numere
    ;compar elementul curent cu k
    ;daca < k, fac doar suma primelor ecx
    cmp ecx, eax
    jge final
    ;altfel suma a k numere de la pozitia curenta - k pana la curent
    cmp ecx, ebx
    jl suma
    ;aici trebuie suma de la vector + curent - k pana la vector + curent
    push ecx
    sub ecx, ebx
    xor edi, edi
    xor edx, edx
loop_suma_mare:
    ;ecx pozitii in dword
    add edx, [vector + 4 * ecx]
    inc ecx
    inc edi
    cmp edi, ebx
    jne loop_suma_mare
    ;ecx pozitii in dword
    mov [vector + 4 * ecx], edx
    pop ecx
    inc ecx
    push eax
    push ebx
    push ecx
    call calculare
    ;eliberez stiva
    add esp, 12
    jmp final
suma:
    xor edx, edx
    push eax
    xor eax, eax
loop_suma:
    ;in eax fac suma nr de la 0 la curent
    add eax, [vector + 4 * edx]
    inc edx
    cmp edx, ecx
    jne loop_suma
    ;ecx pozitii in dword
    mov [vector + 4 * edx], eax
    pop eax
    inc ecx
    push eax
    push ebx
    push ecx
    call calculare
    ;eliberez stiva
    add esp, 12
final:
    pop ebp
    ret
kfib:
    ; create a new stack frame
    enter 0, 0
    push ebp
    mov ebp,esp
    xor eax, eax
    ; n termen
    mov eax, [ebp + 12]
    ; k
    mov ebx, [ebp + 16]
    sub eax, ebx
    inc eax
    ;elementul unde ma aflu curent
    xor ecx,ecx
    inc ecx
    ;primul termen este 1
    mov dword[vector], 1
    push eax
    push eax
    push ebx
    push ecx
    call calculare
    ;eliberez stiva
    add esp, 12
    pop eax
    dec eax
    ;in eax bag rezultatul
    mov eax, [vector + 4 * eax]
    pop ebp
    leave
    ret

