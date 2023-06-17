# a program to draft a plan for the Avengers tower in code.
# author: Shoumil Guha
# created: 11-8-2022

	.data
height: .word 0
space: .asciiz " "
valid_input: .word 0
prompt: .asciiz "How tall do you want the tower: "
var_i: .word 0
var_s: .word 0
var_j: .word 0
star: .asciiz "* "
newline: .asciiz "\n"
letter_A: .asciiz "A "


	.text

#while valid, continue. else, leave the loop
while_loop: 	lw $t0 valid_input
		bne $t0 $0 main_loop
		
#print prompt
		la $a0 prompt
		addi $v0 $0 4
		syscall

#read integer and put in height
		addi $v0 $0 5
		syscall
		sw $v0 height

#if height is less than 5, skip to endif
		lw $t0 height
		addi $t1 $0 5
		slt $t2 $t0 $t1
		bne $t2 $0 endif

#valid input = 1
		addi $t0 $0 1
		sw $t0 valid_input

#jump back to top if not valid
endif: 		j while_loop

#for i in range of height
main_loop: 	
#initialize variables to zero
		sw $0 var_s
		sw $0 var_j

		lw $t0 height
		lw $t1 var_i
		slt $t2 $t1 $t0			#if not i < height, end the loop
		beq $t2 $0 end_main_loop

#Updating initial value of s to -(height+1) for first sub loop
		lw $t0 height
		addi $t0 $t0 1			# height +=1
		addi $t1 $0 -1			
		mult $t0 $t1
		mflo $t0			# $t0 = (height+1)*-1
		sw $t0 var_s	
		
#starting the first sub loop
sub_loop_1:	lw $t0 var_s
		lw $t2 var_i
		sub $t2 $0 $t2			# -i = 0-i
		slt $t3 $t0 $t2			#if not -(height+1) < -1 jump to next loop
		beq $t3 $0 sub_loop_2

#print a space (body of loop)
		la $a0 space
		addi $v0 $0 4
		syscall

#increment s and jump to beginning
		lw $t0 var_s
		addi $t0 $t0 1
		sw $t0 var_s
		
		j sub_loop_1

#for j in range(i+1)
sub_loop_2:	lw $t0 var_j
		lw $t1 var_i			# value i
		addi $t1 $t1 1			# value i+1
		slt $t2 $t0 $t1			#
		beq $t2 $0 print_newline	# if not j < (i+1), jump to print

#body of loop
#if i not equal to 0, go to else
		lw $t0 var_i
		bne $t0 $0 else

#print A followed by a space and jump to endif
		la $a0 letter_A
		addi $v0 $0 4
		syscall
		j endif2

#else, print a star followed by a space
else:		la $a0 star
		addi $v0 $0 4
		syscall
		j endif2

#increment j and jump to top of loop
endif2:		lw $t0 var_j
		addi $t0 $t0 1			# j += 1
		sw $t0 var_j	
		
		j sub_loop_2

#move to the next line using newline character
print_newline:	la $a0 newline
		addi $v0 $0 4
		syscall		

#increment counter i of the main loop by one and jump to top of loop
		lw $t0 var_i
		addi $t0 $t0 1			# i += 1
		sw $t0 var_i
		
		j main_loop		

#end the main loop by exiting the program
end_main_loop: 	addi $v0 $0 10
		syscall
				
	

	



