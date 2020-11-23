	.globl times
times:
	movl	$0, %eax
	movq	$0, %rcx

loop:
	cmpq	%rdi, %rcx
	jge endl
	add 	%esi, %eax
	incq 	%rcx
	jmp	loop

endl:
	ret
