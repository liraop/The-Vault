hello:
	.string	"Hello world!\n"
	.globl	_start
_start:
        # write(1, hello, 13)
        mov     $1, %rdi
        mov     $hello, %rsi
        mov     $13, %rdx
        mov     $1, %rax 
        syscall

        # _exit(0)
        xor     %rdi, %rdi
        mov     $60, %rax
        syscall
