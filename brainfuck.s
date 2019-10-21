# caschutte & ebdemir

.bss
myarray: .skip 20000

.global brainfuck

.text
format_str: .asciz "We should be executing the following code:\n%s\n"
pointvalue: .asciz "The value of the pointer is: %d\n"
pointloc: .asciz "The locpointer is: %d\n"
test_str: .asciz "%c\n"
bfoutput: .asciz "hey im output %c \n"
bfinput: .asciz "hey im input %c \n"

# Your brainfuck subroutine will receive one argument:
# a zero termianted string containing the code to execute.

# $']  used to compare stuff

brainfuck:
	#create a stackframe
	pushq %rbp
	movq %rsp, %rbp
	
	#printing the brainfuck code
	movq %rdi, %r12		
	movq %rdi, %rsi
	movq $format_str, %rdi
	call printf
	movq $0, %rax

	#index of our array
	movq $0, %rbx

	#debug <3	
	movq $0, %r14

	movq $50000, %r13
	movq $0, %rdx

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

	# . sign 
	cmpb $46 , %r15b
	je founddot

	# , sign
	#cmpb $44 , %r15b
	#je foundcomma


	jmp compare

	#end of stackframe
	movq %rbp, %rsp
	popq %rbp
	ret

foundplus:
	movq myarray(%rbx), %rdx
	incq myarray(%rbx)	
	movq myarray(%rbx), %rdx

	#print the character
	xorq %rsi, %rsi
	movb myarray(%rbx), %sil			
	movq $pointvalue, %rdi
	call printf
	movq $0, %rax

	jmp printloop

foundminus:
	movq myarray(%rbx), %rdx
	decq myarray(%rbx)
	movq myarray(%rbx), %rdx

	#print the character
	xorq %rsi, %rsi
	movb myarray(%rbx), %sil			
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

	xorq %rsi, %rsi
	movb myarray(%rbx), %sil
	movq $pointvalue, %rdi
	call printf
	movq $0, %rax

	jmp printloop

foundsmaller:
	decq %rbx


	movq %rbx, %rsi
	movq $pointloc, %rdi
	call printf
	movq $0, %rax

	xorq %rsi, %rsi
	movb myarray(%rbx), %sil
	movq $pointvalue, %rdi
	call printf
	movq $0, %rax

	jmp printloop

founddot:
	movq myarray(%rbx), %rsi
	movq $bfoutput, %rdi
	call printf
	movq $0, %rax

	jmp printloop


end:
	movq %rbp, %rsp
	popq %rbp
	ret