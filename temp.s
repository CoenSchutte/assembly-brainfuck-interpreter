
# BF + instruction
movq    i(%rip), %rax
movzbl  (%rax), %edx
addl    $1, %edx
movb    %dl, (%rax)


# BF - instruction
movq	i(%rip), %rax
movzbl	(%rax), %edx
subl	$1, %edx
movb	%dl, (%rax)
movl	$0, %eax


# BF > instruction
movq    i(%rip), %rax
addq    $1, %rax
movq    %rax, i(%rip)


#BF < instruction
movq	i(%rip), %rax
subq	$1, %rax
movq	%rax, i(%rip)

# BF . instruction
movq    i(%rip), %rax
movzbl  (%rax), %eax
movsbl  %al, %eax
movl    %eax, %edi
call    putchar


















# BF , instruction WIP
        $condId++;              # replace this with a variable
movq    i(%rip), %rbx';
call    getchar';
movb    %al, (%rbx)';
movq    i(%rip), %rax';
movzbl  (%rax), %eax';
cmpb    $4, %al';
jne .cond$condId                                
movq    i(%rip), %rax';
movb    $0, (%rax)';
yield ".cond$condId:";          # not sure what this does :yield ".cond$condId:";
                                # yield returns the value of in php

# BF [ instruction WIP
$loopId++;              # replace this with a variable
$loopStack[] = $loopId; # replace this with a variable

yield ".loops$loopId:";   # not sure what this does :yield ".cond$condId:";
movq    i(%rip), %rax';
movzbl  (%rax), %eax';
cmpb    $0, %al';
je  .loope$loopId";

                
# BF ] instruction WIP                
$endLoopId = array_pop($loopStack);
yield " jmp .loops$endLoopId";
yield ".loope$endLoopId:";