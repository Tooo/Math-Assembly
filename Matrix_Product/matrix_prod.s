    .globl matrix_prod
# rdi - *A, rsi - *B, rdx - *C, rcx - n
matrix_prod: # void matrix_prod(void *A, void *B, void *C, int n);
    xorq %r8, %r8 # r8 - i counter
    xorq %rax, %rax # rax - return
    push %rdi
    push %rsi
    push %rdx

oloop:
    cmpq %r8, %rcx # 0 to N-1
    jle end_oloop
    xorq %r9, %r9 # r9 - j counter

iloop:
    cmpq %r9, %rcx # 0 to N-1
    jle end_iloop

    push %rcx
    push %r8
    push %r9

    movq 40(%rsp), %rdi # *A -> 1st arg 
    movq 32(%rsp), %rsi # *B -> 2nd arg
    movq 16(%rsp), %rdx # n -> 3rd arg
    movq 8(%rsp), %rcx # i -> 4th arg
    movq (%rsp), %r8 # j -> 5th arg

    call dot_prod # long dot_prod(void *A, void *B, int n, int i, int j);

    movq %rax, %rdi # result -> 1st arg
    movq $17, %rsi # 17 -> 2nd arg

    call mod # unsigned char mod(long x, unsigned char m);

    pop %r9
    pop %r8

    movq %r8, %rdi # i -> rdi
    imulq (%rsp), %rdi # n * i -> rdi
    addq %r9, %rdi # (n*i) + j
    movq 8(%rsp), %rsi # *C -> rsi
    movq %rax, (%rsi, %rdi) # result -> C[?]

    pop %rcx
    incq %r9
    jmp iloop

end_iloop:
    incq %r8
    jmp oloop

end_oloop:
    pop %rdx
    pop %rsi
    pop %rdi
	ret
