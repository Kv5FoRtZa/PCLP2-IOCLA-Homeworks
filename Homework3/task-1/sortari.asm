section .text
global sort
    struc node
        .val: resd 1
        .node resd 1
    endstruc
;   struct node {
;    int val;
;    struct node* next;
;   };

;; struct node* sort(int n, struct node* node);
;   The function will link the nodes in the array
;   in ascending order and will return the address
;   of the new found head of the list
; @params:
;   n -> the number of nodes in the array
;   node -> a pointer to the beginning in the array
;   @returns:
;   the address of the head of the sorted list
sort:
    ; create a new stack frame
    push ebp
    mov ebp, esp
;ceva deja scris
    enter 0, 0
    xor eax, eax
; 12 e pozitia din stiva unde e n
    mov edx, [ebp + 12]
; 16 e pozitia din stiva unde e sirul
    mov eax, [ebp + 16]
    xor ecx, ecx
;caut primul
    push eax
    loop:
    push edx
;il caut pe 1 in sir
    mov edx, 1
    cmp [eax], edx
    jne nu
    mov edi, eax
    mov esi, edi
nu:
    add eax, node_size
    pop edx
    inc ecx
    cmp ecx, edx
    jne loop
;in esi am adresa veche
;in edi am adresa primului pe care o bag la final in eax
    pop eax
    xor ecx, ecx
;incep de la 2 deoarece 1 e deja gasit
    add ecx, 2
loop_cautare:
;il caut pe ecx in struct
    xor ebx, ebx
    push eax
loop_doi:
    cmp [eax], ecx
    jne nu_doi
;leg fiecare next vechi de eax
    mov [esi + node.node], eax
    mov esi, eax
nu_doi:
    inc ebx
    add eax, node_size
    cmp ebx, edx
    jle loop_doi
    pop eax
    inc ecx
    cmp ecx, edx
    jle loop_cautare
    mov eax, edi
    pop ebp
    leave
    ret

