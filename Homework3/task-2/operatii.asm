section .text
global sort
global get_words
global cmp
extern malloc
extern strcpy
extern qsort
extern strcmp
extern strlen
cmp:
    push ebp
    mov ebp,esp
    ; iau primul cuvant din matriuce
    mov eax, [ebp + 8]
    ; deref
    mov eax, [eax]
    ; iau lungimea fiecaruia
    push eax
    call strlen
    ;stiva
    add esp, 4
    push esi
    mov esi, eax
    ; iau al doi-lea cuvant din matrice
    mov edx, [ebp + 12]
    mov edx, [edx]
    push edx
    call strlen
    ;eliberez stiva
    add esp, 4
    ;in esi si eax am cele 2 size
    cmp eax, esi
    jne final
    ; iau primul cuvant din matrice again
    mov eax, [ebp + 8]
    ; iau al doi-lea cuvant din matrice again
    mov edx, [ebp + 12]
    ; deref
    mov eax, [eax]
    mov edx, [edx]
    push edx
    push eax
    call strcmp
    ;eliberez stiva
    add esp, 8
    pop esi
    pop ebp
    ret
final:
    sub esi, eax
    mov eax, esi
    pop esi
    pop ebp
    ret
;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    ; create a new stack frame
    enter 0, 0
    push ebp
    mov ebp, esp
    xor eax, eax
    ;words
    mov esi, [ebp + 12]
    ;number_of_words
    mov eax, [ebp + 16]
    ;size
    mov ecx, [ebp + 20]
    push cmp
    push ecx
    push eax
    push esi
    call qsort
    ;eliberez stiva
    add esp, 16
    pop ebp
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax
    push ebp
    mov ebp, esp
    ;sirul
    mov esi, [ebp + 12]
    ;cuvintele
    mov edi, [ebp + 16]
    ;n
    mov ecx, [ebp + 20]
    xor edx, edx
    xor ebx, ebx
    ;in loop caut delimitatorii
    xor eax, eax
loop_litere:
    inc eax
    ;spatiu
    cmp byte[esi], 32
    jne nu_spatiu
    ; pe esi + edx se termina cuvantul
    ; avem eax litere
    push ebx
    mov ebx, eax
    dec ebx
    push ecx
    push eax
    call malloc
    ; aloc memorie 
    add esp, 4
    ;fac 0 pt strcpy
    mov byte[esi], 0
    sub esi, ebx
    push esi
    push eax
    call strcpy
    ;eliberez stiva
    add esp, 8
    add esi, ebx
    pop ecx
    pop ebx
    ;edi + 4 * ebx e locul in ** unde trebuie bagat cuvantul
    mov [edi + 4 * ebx], eax
    inc ebx
    ;rebag spatiu
    mov byte[esi], 32
    xor eax, eax
nu_spatiu:
    ;virgula
    cmp byte[esi], 44
    jne nu_virgula
    ; pe esi + edx se termina cuvantul
    ; avem eax litere
    push ebx
    mov ebx, eax
    dec ebx
    push ecx
    push eax
    call malloc
    ; aloc memorie 
    add esp, 4
    ; 0 pt strcpy
    mov byte[esi], 0
    sub esi, ebx
    push esi
    push eax
    call strcpy
    ;eliberez stiva
    add esp, 8
    add esi, ebx
    pop ecx
    pop ebx
    ;edi + 4 * ebx e locul in ** unde trebuie bagat cuvantul
    mov [edi + 4 * ebx], eax
    inc ebx
    ;refac virgula
    mov byte[esi], 44
    xor eax, eax
    ;cam aici trebuie bagat
nu_virgula:
    ;punct
    cmp byte[esi], 46
    jne nu_.
    ; pe esi + edx se termina cuvantul
    ; avem eax litere
    push ebx
    mov ebx, eax
    dec ebx
    push ecx
    push eax
    call malloc
    ; aloc memorie 
    add esp, 4
    ;fac 0 pt strcpy
    mov byte[esi], 0
    sub esi, ebx
    push esi
    push eax
    call strcpy
    ;eliberez stiva
    add esp, 8
    add esi, ebx
    pop ecx
    pop ebx
    ;edi + 4 * ebx e locul in ** unde trebuie bagat cuvantul
    mov [edi + 4 * ebx], eax
    inc ebx
    ;refac punct
    mov byte[esi], 46
    xor eax, eax
nu_.:
    ;endline
    cmp byte[esi], 0
    jne nu_final
    ; pe esi + edx se termina cuvantul
    ; avem eax litere
    push ebx
    mov ebx, eax
    dec ebx
    push ecx
    push eax
    call malloc
    ; aloc memorie 
    add esp, 4
    sub esi, ebx
    push esi
    push eax
    call strcpy
    ;eliberez stiva
    add esp, 8
    add esi, ebx
    pop ecx
    pop ebx
    ;edi + 4 * ebx e locul in ** unde trebuie bagat cuvantul
    mov [edi + 4 * ebx], eax
    inc ebx
    xor eax, eax
nu_final:
    ;verific daca am spetiu punct sau virgula curenta
    cmp byte[esi], 46
    je loop_curatare
    ;verific daca am spetiu punct sau virgula curenta
    cmp byte[esi], 44
    je loop_curatare
    ;verific daca am spetiu punct sau virgula curenta
    cmp byte[esi], 32
    je loop_curatare
    jmp dupa_curatare
loop_curatare:
    ;daca sunt mai multe caractere separatoare consecutive
    inc edx
    inc esi
    ;daca mai am caracter separator continui loop-ul
    cmp byte[esi], 46
    je loop_curatare
    ;daca mai am caracter separator continui loop-ul
    cmp byte[esi], 44
    je loop_curatare
    ;daca mai am caracter separator continui loop-ul
    cmp byte[esi], 32
    je loop_curatare
    jmp am_curatat
dupa_curatare:
    inc edx
    inc esi
am_curatat:
    cmp ebx, ecx
    jne loop_litere
    pop ebp
    leave
    ret

