%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box
; you can declare any helper variables in .data or .bss

section .text


; int check_row(char* sudoku, int row);
check_row:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int row 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    xor ecx, ecx
    xor ebx, ebx
    mov ax, 9
    mov cx, dx
    mul cx
    mov bx, ax
    ;in ebx bag pozitia primului din randul cautat
    xor ecx, ecx
    mov eax, 1
    xor edi, edi
    push eax
    mov eax, 1
loop: ;parcurg elementele de pe linia respectiva 
    push ecx
    movzx ecx, byte [esi + ebx]
    mul ecx
    add edi, ecx; fac suma lor
    pop ecx
    add ebx, 1
    add ecx, 1
    cmp ecx, 9
        jne loop
    mov ebx, eax
    pop eax
    cmp ebx, 362880
        je bun_mul
    mov eax, 2
bun_mul:
    cmp edi, 45; si o compar cu suma buna
        je bun
    mov eax, 2
bun:
    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this row is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_row:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY

; int check_column(char* sudoku, int column);
check_column:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int column 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here

    xor ecx, ecx
    mov ebx, edx
    xor edi, edi
    mov eax, 1
    push eax
    mov eax, 1
loop_col: ;parcurg elementele de pe coloana respectiva
    push ecx
    movzx ecx, byte [esi + ebx]
    add edi, ecx; fac suma lor
    mul ecx;si produsul
    pop ecx
    add ebx, 9
    add ecx, 1
    cmp ecx, 9
        jne loop_col
    mov ebx, eax
    pop eax
    cmp ebx, 362880
        je bun_mul_col
    mov eax, 2
bun_mul_col:
    cmp edi, 45; si o compar cu suma buna
        je bun_col
    mov eax, 2
bun_col:
    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this column is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_column:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY


; int check_box(char* sudoku, int box);
check_box:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int box 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    ;fac suma primelor 3 de pe prima linie
    xor edi, edi
    mov ebx, 0
    cmp edx, 0; verificam in ce patrat se afla
        jne dupa_0
        mov ebx, 0
dupa_0:
    cmp edx, 1
        jne dupa_1
        mov ebx, 3
dupa_1:
    cmp edx, 2
        jne dupa_2
        mov ebx, 6
dupa_2:
cmp edx, 3
        jne dupa_3
        mov ebx, 27
dupa_3:
    cmp edx,  4
        jne dupa_4
        mov ebx, 30
dupa_4:
    cmp edx, 5
        jne dupa_5
        mov ebx, 33
dupa_5:
    cmp edx, 6
        jne dupa_6
        mov ebx, 54
dupa_6:
    cmp edx, 7
        jne dupa_7
        mov ebx, 57
dupa_7:
    cmp edx, 8
        jne dupa_8
        mov ebx, 60
dupa_8:
    mov eax, 1
    movzx ecx, byte [esi + ebx]; fac suma numerelor pe prima linie
    add edi, ecx
    mul ecx
    inc ebx
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx
    inc ebx
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx

    add ebx, 7; apoi pe linia 2 
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx
    inc ebx
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx
    inc ebx
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx
    add ebx, 7

    ;si apoi suma pe linia 3
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx
    inc ebx
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx
    inc ebx
    movzx ecx, byte [esi + ebx]
    add edi, ecx
    mul ecx
    
    mov ebx, eax
    mov eax, 1
    cmp ebx, 362880
        je bun_mul_patrat
    mov eax, 2
bun_mul_patrat:
    cmp edi, 45
        je bun_patrat
    mov eax, 2
bun_patrat:
    ;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this box is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here
end_check_box:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY
