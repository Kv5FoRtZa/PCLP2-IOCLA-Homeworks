%include "../include/io.mac"

extern printf
global remove_numbers

section .data
	fmt db "%d", 10, 0

section .text

; function signature:
; void remove_numbers(int *a, int n, int *target, int *ptr_len);

remove_numbers:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     esi, [ebp + 8] ; source array
	mov     ebx, [ebp + 12] ; n
	mov     edi, [ebp + 16] ; dest array
	mov     edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	;; Your code starts here
		xor ecx, ecx
	xor eax, eax
	push ebx
	sub ebx, 1
	;verific intr-un loop ultimul si primul bit
	;daca doar primul bit e 1 sau ultimul e 0 elimin/pastrez
loop:
	mov eax, [esi + 4 * ebx]
	test eax,1
	jnz salt
		sub eax, 1
		and eax, [esi + 4 * ebx]
		jz s2
		mov eax, [esi + 4 * ebx]
		mov [edi + ecx * 4], eax
		add ecx, 1
salt:
s2:
	sub ebx, 1
	cmp ebx, -1
		jne loop
	mov [edx], ecx
	pop ebx
	;; Your code ends here


	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY
