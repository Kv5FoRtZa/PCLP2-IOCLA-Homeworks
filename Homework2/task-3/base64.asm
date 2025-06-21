%include "../include/io.mac"

extern printf
global base64

section .data
	alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
	fmt db "%d", 10, 0

section .text

base64:
	;; DO NOT MODIFY

    push ebp
    mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; source array
	mov ebx, [ebp + 12] ; n
	mov edi, [ebp + 16] ; dest array
	mov edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	; -- Your code starts here --
	xor ecx, ecx

	mov dword [edx], 0
loop:
	mov al, [esi]
	and al, 252; iau primii 6 biti
	shr al, 2
	push ecx
	mov ecx, [edx]
	movzx eax, al
	mov al, [alphabet + eax]
	mov [edi + ecx], al
	add dword [edx], 1
	pop ecx
	mov al, [esi]
	and al, 3; salvez ultimii 2
	inc esi
	;numarul 2
	shl al, 4
	push ebx
	mov bl, [esi]
	and bl, 240; iau primii 4 biti din nr 2
	shr bl, 4
	add al, bl
	pop ebx
	push ecx
	mov ecx, [edx]
	movzx eax, al
	mov al, [alphabet + eax]
	mov [edi + ecx], al
	add dword [edx], 1
	pop ecx
	mov al, [esi]
	and al, 15; salez ultimii 4 biti din nr 2
	inc esi
	;numarul 3
	shl al, 2
	push ebx
	mov bl, [esi]
	and bl, 192; primii 2 biti
	shr bl, 6
	add al, bl
	pop ebx
	push ecx
	mov ecx, [edx]
	movzx eax, al
	mov al, [alphabet + eax]
	mov [edi + ecx], al
	add dword [edx], 1
	pop ecx
	mov al, [esi]
	and al, 63; ultimii 6 biti din ultimul nr
	push ecx
	mov ecx, [edx]
	movzx eax, al
	mov al, [alphabet + eax]
	mov [edi + ecx], al
	add dword [edx], 1
	pop ecx
	inc esi
	add ecx, 3
	cmp ecx, ebx
		jne loop
	; -- Your code ends here --


	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY