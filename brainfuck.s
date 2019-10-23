# caschutte & ebdemir

.bss
myarray: .skip 20000

.global brainfuck

.text
format_str: .asciz "We should be executing the following code:\n%s\n"
pointvalue: .asciz "The value of the pointer is: %d\n"
pointloc: .asciz "The locpointer is: %d\n"
test_str: .asciz "%c\n"
bfoutput: .asciz "%c"
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



	movq $50000, %r13
	movq $0, %rdx

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
	incq %r12

	#store the bit value of the character into r15b
	movb (%r12), %r15b

	#check if we reached the end of the file
	cmpb $0, %r15b	
	je end




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

	# [ sign 
	cmpb $91 , %r15b
	je foundleft

	cmpb $93 , %r15b
	je foundright

	jmp compare

	#end of stackframe
	movq %rbp, %rsp
	popq %rbp
	ret

foundplus:

	incq myarray(%rbx)	

	jmp printloop

foundminus:

	decq myarray(%rbx)

	jmp printloop

foundgreater:
	incq %rbx

	jmp printloop

foundsmaller:
	decq %rbx

	jmp printloop

founddot:

	xorq %rsi, %rsi
	movb myarray(%rbx), %sil
	movq $bfoutput, %rdi
	call printf
	movq $0, %rax

	jmp printloop

foundleft:
	incq myarray(%rbx)
	cmpb $0, myarray(%rbx)
	je findright

	
	push %r12
	jmp printloop

foundright:
	cmpb $0, myarray(%rbx)
	je printloop
	
	popq %r12
	pushq %r12
	jmp printloop

findright:

	cmpb $93, %r15b
	je printloop

	incq %r12

	#store the bit value of the character into r15b
	movb (%r12), %r15b

	jmp findright



end:
	movq %rbp, %rsp
	popq %rbp
	ret
