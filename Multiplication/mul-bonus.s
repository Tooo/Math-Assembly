//edi = a, esi = b, eax = return
//if b is min, then swap a and b
//if a is odd, then shift b and return += b
//if a is even, then shift b
//end a = 0
	.globl times
times:
	cmpl %esi, %edi
	jle mulit
	movl %edi, %eax
	movl %esi, %edi
	movl %eax, %esi
	
mulit:
	movl $0, %eax

loop:	
	cmpq $0, %rdi
	je endloop
	test $1, %rdi 
	je aeven
	jmp aodd

aeven:
	shl %rsi
	shr %rdi
	jmp loop

aodd:
	add %rsi, %rax
	shl %rsi
	shr %rdi
	jmp loop

endloop:
	ret
