.global brainfuck

format_str: .asciz "We should be executing the following code:\n%s\n"
test_str: .asciz "%d\n"

# Your brainfuck subroutine will receive one argument:
# a zero termianted string containing the code to execute.
brainfuck:
	pushq %rbp
	movq %rsp, %rbp

	movq %rdi, %r12

	movq %rdi, %rsi
	movq $format_str, %rdi
	call printf
	movq $0, %rax

	movq $20, %r13
	movq $0, %r14

compare:	
	cmpq %r13, %r14
	jl printloop

elseprint:
	movq %rbp, %rsp
	popq %rbp
	ret

printloop:
	incq %r12
	incq %r14

	movq (%r12), %r10
	subq $48, %r10

	movq %r10, %rsi
	movq $test_str, %rdi
	call printf
	movq $0, %rax

	jmp compare

	#end of stackframe
	movq %rbp, %rsp
	popq %rbp
	ret
