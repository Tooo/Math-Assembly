# edi - x
	.globl sqrt
sqrt:
	movl $0, %eax # eax - result
	movl $1, %ecx # ecx - Bitmask
	shl $15, %ecx # 1000 0000 0000 0000
loop:
	cmpl $0, %ecx # Bitmask - 0
	je endl
	movl $0, %edx  # result^2
	xor %ecx, %eax  # eax is bitmasked 
	xor %eax, %edx # eax -> edx
	imul %rdx, %rdx
	cmp %rdi, %rdx  
	jle shift
	xor %ecx, %eax # kth bit change to 0
shift:
	shr %ecx # shift right
	jmp loop
endl:
	ret
