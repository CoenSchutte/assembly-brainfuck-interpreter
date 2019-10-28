# caschutte & ebdemir


.global brainfuck

.text
format_str: .asciz "We should be executing the following code:\n%s\n"
bfoutput: .asciz "%c"

.data
myarray: 
.skip 30000


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

	#index of our array set to 0 in a fancy way
	movq $0, %r15

	jmp first_action

# rip brainfuck
end:
	movq %rbp, %rsp
	popq %rbp
	ret

next_action:
	incq %r12

# print each brainfuck character
first_action:

	#store the bit value of the character into r11b
	movb (%r12), %r11b

	#check if we reached the end of the file
	cmpb $0, %r11b	
	je end

	#we compare here
	# + sign
	cmpb $43, %r11b
	je foundplus

	# - sign
	cmpb $45, %r11b
	je foundminus

	# > sign
	cmpb $62, %r11b
	je foundgreater

	# < sign
	cmpb $60, %r11b
	je foundsmaller

	# . sign 
	cmpb $46, %r11b
	je founddot

	# [ sign 
	cmpb $91, %r11b
	je foundleft

	# ] sign
	cmpb $93, %r11b
	je loop_end

	jmp next_action
		

# Increments the value the pointer is pointing at
foundplus:
	incb myarray(%r15)	
	jmp next_action

# Decrements the value the pointer is pointing at
foundminus:
	decb myarray(%r15)
	jmp next_action

# Increments the pointer
foundgreater:
	incq %r15
	jmp next_action

# Deccrements the pointer
foundsmaller:
	decq %r15
	jmp next_action


# Prints the value the pointer is pointing at
founddot:
	movq $0, %rax
	movq myarray(%r15), %rsi
	movq $bfoutput, %rdi
	call printf

	jmp next_action

# we found a left bracket and push it's location to the stack
foundleft:

	cmpb $0, myarray(%r15)
	je start_counter

	pushq %r12
	jmp next_action

# initializes our counter
start_counter:
	movq $1, %r14

#counts the amount of brackets
counter:
	cmpq $0, %r14
	je next_action

	incq %r12

	movb (%r12), %r11b

	cmpb $91, %r11b
	je inc14

	cmpb $93, %r11b
	je dec14

	jmp counter

# increment our bracket counter
inc14:
	incq %r14
	jmp counter

# decrement our bracket counter
dec14:
	decq %r14
	jmp counter

# we found a right bracket and check if it matches
loop_end:
	cmpb $0, myarray(%r15)
	je happy_stack

	popq %r12
	push %r12

	jmp next_action

# makes the stack happy
happy_stack:
	popq %rbx
	jmp next_action



