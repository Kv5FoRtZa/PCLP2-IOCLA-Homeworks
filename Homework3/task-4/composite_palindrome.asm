extern strlen
extern strcpy
extern memset
extern strcmp
extern malloc
section .bss
    ;15 linii maxim, 10 caractere pe linie
    concatenare resb 170
    ;15 linii maxim, 10 caractere pe linie
    palindrom_vechi resb 170
    ;aici salvez 2^numarul de cuvinte
    marime resb 1
section .text
global check_palindrome
global composite_palindrome
global concatenare
check_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax
    push ebp
    mov ebp,esp
    ;str
    mov eax, [ebp + 12]
    ;len
    mov ecx, [ebp + 16]
    ;parcurg pana la jumatate
    ;verific daca + cnt = ecx - cnt
    push ebx
    xor ebx, ebx
    mov edx, ecx
    dec edx
loop_palindrome:
    ;pozitia de la final
    movzx esi, byte[eax + edx]
    ;pozitia de la inceput
    movzx edi, byte[eax + ebx]
    cmp edi, esi
    jne nu_e_egal
    dec edx
    inc ebx
    cmp ebx, edx
    jl loop_palindrome
    ;e palindrom
    xor eax, eax
    inc eax
    pop ebx
    pop ebp
    leave
    ret
nu_e_egal:
    ; nu e palindrom
    pop ebx
    xor eax, eax
    pop ebp
    leave
    ret
composite_palindrome:
    ; create a new stack frame
    enter 0, 0
    push ebp
    mov ebp,esp
    ;sirul
    mov esi, [ebp + 12]
    ;n
    mov ecx, [ebp + 16]
    ;fac 2^n
    mov edx, 1
    shl edx, cl
    dec edx
    mov [marime], edx
    ;eliberez memoria de date(150 e nr maxim de litere)
    mov edx, 152
    push edx
    xor edx, edx
    push edx
    push concatenare
    call memset
    ;eliberez stiva
    add esp, 12
    ;eliberez memoria de date(150 e nr maxim de litere)
    mov edx, 152
    push edx
    xor edx, edx
    push edx
    push palindrom_vechi
    call memset
    ;eliberez stiva
    add esp, 12
    xor edi, edi
    xor ebx, ebx
    ;edi va fi un nr de la 1 la 2^15, emuland toate var de submulme
loop_1_32768:
    inc edi
    push edi
    xor ebx, ebx
    xor edx, edx
loop_gasire_poz:
    ;daca ultimul bit este 1
    ;iau in considerare cuvantul
    test edi, 1
    jz dupa
    ;in eax avem sirul nou
    ;in ebx sirul vechi
    mov eax, [esi + ebx * 4]
    ;verific daca e gol sirul
    cmp edx , 0
    jne strl
    inc edx
    push eax
    push concatenare
    call strcpy
    ;eliberez stiva
    add esp, 8
    jmp dupa_Strl
strl:
    ;daca nu e gol aplic
    push eax
    push concatenare
    call strlen
    ;in ecx avem rezultatul
    mov ecx, eax
    ;eliberez stiva
    add esp, 4
    pop eax
    lea edx, [concatenare + ecx]
    push eax
    push edx
    ;strcpy intre cele 2
    call strcpy
    ;eliberez stiva
    add esp, 8
dupa_Strl:
dupa:
    ;impart la 2
    shr edi, 1
    inc ebx
    ;daca nr e 0 ies din loop
    cmp edi, 0
    jne loop_gasire_poz
    pop edi
    push esi
    push edi
    push ebx
    ;in concatenare am sirul final
    push concatenare
    call strlen
    ;eliberez stiva
    add esp, 4
    push eax
    push concatenare
    call check_palindrome
    ;eliberez stiva
    add esp, 8
    ;verific daca e palindrom
    cmp eax, 1
    jne nu_e_pal
    ;aici e palindrom
    push concatenare
    call strlen
    ;vad care e mai mare dintre cele 2
    add esp, 4
    mov edi, eax
    push palindrom_vechi
    call strlen
    ;eliberez stiva
    add esp, 4
    cmp edi,eax
    jle nu_mai_mare
    ;cel nou e mai mare aici
    push concatenare
    push palindrom_vechi
    call strcpy
    ;eliberez stiva
    add esp, 8
nu_mai_mare:
    cmp edi, eax
    jne nu_e_pal
    ;daca au aceasi lungime fac strcmp
    push concatenare
    push palindrom_vechi
    call strcmp
    ;eliberez stiva
    add esp, 8
    ;daca eax < 0, trebuie inversate
    cmp eax, 0
    jle nu_e_pal
    push concatenare
    push palindrom_vechi
    call strcpy
    ;eliberez stiva
    add esp, 8
nu_e_pal:
    pop ebx
    ;eliberez memoria de date(150 e nr maxim de litere)
    mov edx, 170
    push edx
    xor edx, edx
    push edx
    push concatenare
    call memset
    ;eliberez stiva
    add esp, 12
    pop edi
    pop esi
    ;daca ajung la 2^15 ma opresc
    cmp edi,[marime]
    jl loop_1_32768
    push palindrom_vechi
    call strlen
    ;eliberez stiva
    add esp, 4
    push eax
    call malloc
    ;eliberez stiva
    add esp, 4
    push palindrom_vechi
    push eax
    call strcpy
    ;eliberez stiva
    add esp, 8
    ;mov eax, 0
    pop ebp
    leave
    ret

