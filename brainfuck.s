# caschutte & ebdemir

.bss
myarray: .skip 50000000

.global brainfuck

.text
format_str: .asciz "We should be executing the following code:\n%s\n"
bfoutput: .asciz "%c"

# Your brainfuck subroutine will receive one argument:
# a zero termianted string containing the code to execute.


brainfuck:
	#create a stackframe
	pushq %rbp
	movq %rsp, %rbp
	
	#printing the brainfuck code
	movq %rdi, %r12		
	movq %rdi, %rsi
	movq $format_str, %rdi
	call printf
	xorq %rax, %rax

	#index of our array
	xorq %rbx, %rbx

	jmp next_action


start_counter:
	movq $1, %r14

counter:
	cmpq $0, %r14
	jmp next_action

	incq %r12

	movb (%r12), %r15b

	cmpb $91, %r15b
	je inc14

	cmpb $93, %r15b
	je dec14

	jmp counter


# print each brainfuck character
next_action:

	#store the bit value of the character into r15b
	movb (%r12), %r15b

	incq %r12

	#check if we reached the end of the file
	cmpb $0, %r15b	
	je end

	#we compare here
	# + sign
	cmpb $43, %r15b
	je foundplus

	# - sign
	cmpb $45, %r15b
	je foundminus

	# > sign
	cmpb $62, %r15b
	je foundgreater

	# < sign
	cmpb $60, %r15b
	je foundsmaller

	# . sign 
	cmpb $46, %r15b
	je founddot

	# , sign
	#cmpb $44 , %r15b
	#je foundcomma

	# [ sign 
	cmpb $91, %r15b
	je foundleft

	# ] sign
	cmpb $93, %r15b
	je loop_end

	jmp next_action


inc14:
	incq %r14
	jmp counter


dec14:
	decq %r14
	jmp counter
		

# Increments the value the pointer is pointing at
foundplus:
	incq myarray(%rbx)	
	jmp next_action

# Decrements the value the pointer is pointing at
foundminus:

	decq myarray(%rbx)
	jmp next_action

# Increments the pointer
foundgreater:
	incq %rbx
	jmp next_action

# Deccrements the pointer
foundsmaller:

	decq %rbx
	jmp next_action

# Prints the value the pointer is pointing at
founddot:
	# the cool way of printing

	movq $0, %rax
	movq myarray(%rbx), %rsi
	movq $bfoutput, %rdi
	call printf


	jmp next_action

foundleft:
	cmpq $0, myarray(%rbx)
	je start_counter

	push %r12

	jmp next_action


loop_end:
	cmpb $0, myarray(%rbx)
	je happy_stack

	popq %r12
	decq %r12
	jmp next_action

happy_stack:
	popq %r13
	jmp next_action


# rip brainfuck
end:
	movq %rbp, %rsp
	popq %rbp
	ret
