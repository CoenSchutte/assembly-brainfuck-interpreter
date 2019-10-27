# caschutte & ebdemir

.bss
myarray: .skip 50000000

.global brainfuck

.text
format_str: .asciz "We should be executing the following code:\n%s\n"
bfoutput: .asciz "%c"
test1: .asciz	 " %ld \n"


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

	#the cool way to set r14 to 0
	xorq %r14, %r14

	movq $50000000, %r13

	movq $0, %r14


# loop through te brainfuck code
compare:	
	cmpq $0, %r13
	jge printloop

elseprint:
	movq %rbp, %rsp
	popq %rbp
	ret

# print each brainfuck character
printloop:



	#store the bit value of the character into r15b
	movb (%r12), %r15b


	#go to the next char
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
	je foundright

	# unknown character -> go next 
	jmp compare


thing:
	popq %r12
	pushq %r12
	jmp printloop


skip:
	
	incq %r12

	movb (%r12), %r15b

	cmpb $91, %r15b
	je inc14

	cmpb $93, %r15b
	je dec14

	cmpq $0, %r14
	je printloop

	jmp skip

inc14:
	incq %r14
	jmp skip

dec14:
	decq %r14
	cmpq $0, %r14
	je printloop
	jmp skip
		

# Increments the value the pointer is pointing at
foundplus:
	incq myarray(%rbx)	
	jmp printloop

# Decrements the value the pointer is pointing at
foundminus:

	decq myarray(%rbx)
	jmp printloop

# Increments the pointer
foundgreater:
	incq %rbx
	jmp printloop

# Deccrements the pointer
foundsmaller:

	decq %rbx
	jmp printloop

# Prints the value the pointer is pointing at
founddot:
	# the cool way of printing
	xorq %rsi, %rsi
	movb myarray(%rbx), %sil
	movq $bfoutput, %rdi
	xorq %rax, %rax
	call printf


	jmp printloop

# pushes the location of the [ to the stack
foundleft:
	cmpb $0, myarray(%rbx)
	je skip
	
	push %r12

	# store the location of the [ and go to the next character
	jmp printloop

foundright:

	# should we find the value 0 then we evaluate the next character by jumping to our loop
	cmpb $0, myarray(%rbx)
	je printloop
	

	cmpq $1, myarray(%rbx)
	jne thing

	popq %r12 			

	jmp printloop





# rip brainfuck
end:
	movq %rbp, %rsp
	popq %rbp
	ret
