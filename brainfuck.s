# caschutte & ebdemir

.bss
myarray: .skip 20000

.global brainfuck

.text
format_str: .asciz "We should be executing the following code:\n%s\n"
pointvalue: .asciz "The value of the pointer is: %d\n"
pointloc: .asciz "The locpointer is: %d\n"
test_str: .asciz "%d\n"

# Your brainfuck subroutine will receive one argument:
# a zero termianted string containing the code to execute.

# $']  used to compare stuff

brainfuck:
	#create a stackframe
	pushq %rbp
	movq %rsp, %rbp
	
	#index of our array
	movq $0, %rbx
	


	#printing the brainfuck code
	movq %rdi, %r12		
	movq %rdi, %rsi
	movq $format_str, %rdi
	call printf
	movq $0, %rax

	movq $50000, %r13
	movq $0, %r14

# loop through te brainfuck code
compare:	
	cmpq %r13, %r14
	jl printloop

elseprint:
	movq %rbp, %rsp
	popq %rbp
	ret

# print each brainfuck character
printloop:
	incq %r12

	#store the bit value of the character into r15b
	movb (%r12), %r15b

	#check if we reached the end of the file
	cmpb $0, %r15b	
	je end


	#print the character
	movzb %r15b, %rsi
	movq $test_str, %rdi
	call printf
	movq $0, %rax


	#we compare here
	# + sign
	cmpb $43, %r15b
	je foundplus

	# - sign
	cmpb $45 , %r15b
	je foundminus

	# > sign
	cmpb $62 , %r15b
	je foundgreater

	# < sign
	cmpb $60 , %r15b
	je foundsmaller

	jmp compare

	#end of stackframe
	movq %rbp, %rsp
	popq %rbp
	ret

foundplus:
	incq myarray(%rbx)

	#print the character
	movq myarray(%rbx), %rsi
	movq $pointvalue, %rdi
	call printf
	movq $0, %rax

	jmp printloop

foundminus:
	decq myarray(%rbx)
	
	#print the character
	movq myarray(%rbx), %rsi
	movq $pointvalue, %rdi
	call printf
	movq $0, %rax

	jmp printloop

foundgreater:
	incq %rbx

	movq %rbx, %rsi
	movq $pointloc, %rdi
	call printf
	movq $0, %rax

	jmp printloop

foundsmaller:
	decq %rbx


	movq %rbx, %rsi
	movq $pointloc, %rdi
	call printf
	movq $0, %rax

	jmp printloop

end:
	movq %rbp, %rsp
	popq %rbp
	ret