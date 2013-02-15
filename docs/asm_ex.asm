; 2009.1.20 gurugio


[bits 64]

; for x86_64 processor assembly
[CPU X64]


; only RIP-relative addressing is active for x86_64 processor
[DEFAULT REL]

extern caos_putchar


; caos_printf cannot be invoked...WHT???
;extern caos_printf

section .text
global _start

_start:

	; According to the AMD64 ABI Draft 0.99,
	; rbx, rbp, r12-r15 registers must be preserved across function calls
	push rbx
	push rbp
	
	push r12
	push r13
	push r14
	push r15

	

	; only "MOV reg64, imm64" intruction can take a full 64bit immediate value.
	mov r15, 0x12345678abcdef

	; data is accessed with RIP-relative addressing
	; function parameter is passed in rdi, rsi, rdx, rcx, r8, r9, stack~
	mov rdi, [byte msg]
	call _test_asm

	
	; data is accessed with RIP-relative addressing
	mov rdx, [byte msg]
	add dl, 1
	mov byte [byte msg], dl


	pop r15
	pop r14
	pop r13
	pop r12

	pop rbp
	pop rbx

	ret

global _test_asm
_test_asm:
	; According to the AMD64 ABI Draft 0.99,
	; rbx, rbp, r12-r15 registers must be preserved across function calls
	push rbx
	push rbp
	
	push r12
	push r13
	push r14
	push r15


	push rdi

	mov rdi, 'T'
	call caos_putchar
	mov rdi, 'e'
	call caos_putchar
	mov rdi, 's'
	call caos_putchar
	mov rdi, 't'
	call caos_putchar

	; function argument is in rdi
	pop rdi
	call caos_putchar


	pop r15
	pop r14
	pop r13
	pop r12

	pop rbp
	pop rbx



	ret 


section .data
msg db '0'

