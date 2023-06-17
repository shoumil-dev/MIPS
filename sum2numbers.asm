

	.data
	#all the variables and strings go here
	prompt: .asciiz "enter two integers: "
	result: .asciiz "Sum is "
	integer1: .word 0
	integer2: .word 0
	integerSum: .word 0
	newline: .asciiz "\n"
	
	.text 
	
	#taking integers
	la $a0, prompt
	addi $v0, $0, 4
	syscall
	
	addi $v0, $0, 5
	syscall
	sw $v0, integer1
	
	addi $v0, $0, 5
	syscall
	sw $v0, integer2
	
	#add integers
	lw $t1, integer1
	lw $t2, integer2
	add $t3, $t1, $t2
	sw $t3, integerSum
	
	#print
	la $a0, result
	addi $v0, $0, 4
	syscall
	
	lw $a0, integerSum
	addi $v0, $0, 1
	syscall
	
	la $a0, newline
	addi $v0, $0, 4
	syscall
	
	
		