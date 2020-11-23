	.globl sum_float

	# var map:
	#   %xmm0:  total
	#   %rdi:   F[n] (base pointer)
	#   %rsi:   n
	#	%rcx:   counter
	#   %rbp:   F[n] end pointer
	# 	%rdx: 	save stack
	#   %rsp: 	stack top (Queue End)
	#	%rbx	stack base (Queue Start)
	#	%xmm1	x
	#	%xmm2	y

sum_float:
	push	%rbp
	push	%rbx
	movq	%rsp, %rdx				# Save stack pointer

	xorps	%xmm0, %xmm0            # total <- 0.0
	leaq	(%rdi, %rsi, 4), %rbp   # endptr <- F + n
	movq	%rsp, %rbx				# stack base <- stack pointer
	movq	$1, %rcx

loop:
	cmpq	%rcx, %rsi # for loop, 1 to n-1        
	jle	endloop
	
	cmpq	%rsp, %rbx	# If stack head = tail, go to x_f
	je x_f
	cmpq	%rdi, %rbp	# if F[n] base = end, go to x_queue
	je x_queue

	movq	(%rdi), %xmm1	# x <- head(F)
	comiss	(%rbx), %xmm1	# if x - head(q) > 0, go to x_queue
	jl x_queue

x_f:
	add	$4, %rdi
	jmp x_end
x_queue:
	subq $8, %rbx
	movq 	(%rbx), %xmm1
x_end:
	cmpq	%rsp, %rbx
	je y_f
	cmpq	%rdi, %rbp
	je y_queue

	movq	(%rdi), %xmm2
	comiss	(%rbx), %xmm2
	jl y_queue

y_f:
	add		$4, %rdi
	jmp y_end
y_queue:
	subq 	$8, %rbx
	movq 	(%rbx), %xmm2
y_end:
	addss 	%xmm1, %xmm2
	movq	%xmm2, %r9
	push	%r9
	incq	%rcx
	jmp	loop

endloop:
	movq (%rsp), %xmm0
	movq %rdx, %rsp
	pop %rbx
	pop	%rbp
	ret
