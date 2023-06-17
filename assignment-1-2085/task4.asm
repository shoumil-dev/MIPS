# a program to set the order of events right in the sacred timeline
# author: Shoumil Guha
# created: 15-8-2022

	.data
.globl insertion_sort
newline: .asciiz "\n"
space: .asciiz " "

	.text
main:
#allocating space for local variable arr and for loop counter
			addi $fp $sp 0	#setting fp as current sp
			addi $sp $sp -8

#creating an array
			addi $a0 $0 24	# (5+1)*4 = 24 bytes
			addi $v0 $0 9
			syscall
			sw $v0 -4($fp) #storing array location in stack

#allocating array values
			lw $t0 -4($fp)
			addi $t1 $0 5	#size
			sw $t1 0($t0)
			addi $t1 $0 6
			sw $t1 4($t0)
			addi $t1 $0 -2
			sw $t1 8($t0)
			addi $t1 $0 7
			sw $t1 12($t0)
			addi $t1 $0 4
			sw $t1 16($t0)
			addi $t1 $0 -10
			sw $t1 20($t0)
			

#creating arguments
			addi $sp $sp -4
			lw $t0 -4($fp)
			sw $t0 0($sp)

#jump to function	
			jal insertion_sort

#remove arguments
			addi $sp $sp 4

#creating a counter
			sw $0 -8($fp)	#counter = 0

for_loop_2:
			lw $t0 -4($fp)
			lw $t1 0($t0)	#size
			lw $t2 -8($fp)
			slt $t3 $t2 $t1	#if not counter < size, go to end of loop
			beq $t3 $0 end_for_loop_2

			lw $t0 -4($fp)
			lw $t1 -8($fp) #counter
			addi $t1 $t1 1 #increment counter to account for size
			sll $t1 $t1 2  #multiply by 4
			add $t2 $t0 $t1	#go to index
			lw $a0 0($t2) 	#load value at index
			addi $v0 $0 1
			syscall		#print value
			
			la $a0 space	#print space
			addi $v0 $0 4
			syscall

			lw $t0 -8($fp)
			addi $t0 $t0 1	#increment counter by one
			sw $t0 -8($fp)
			
			j for_loop_2	#jump to top of loop

end_for_loop_2:		
			la $a0 newline	#print newline
			addi $v0 $0 4
			syscall
			
			j exit		#exit program
						

insertion_sort:		
#save $ra and $fp in stack
			addi $sp $sp -8
			sw $ra 4($sp)
			sw $fp 0($sp)

#copy $sp to $fp
			addi $fp $sp 0

#allocate local variables
			addi $sp $sp -16

#creating length variable
			lw $t0 8($fp)
			lw $t1 0($t0)		
			sw $t1 -4($fp)	#LENGTH

#creating a counter variable
			addi $t0 $0 1
			sw $t0 -8($fp)	#COUNTER i = 1

for_loop:		
			lw $t0 -8($fp)
			lw $t1 -4($fp)
			slt $t2 $t0 $t1	#if not counter < length, jump to end of loop
			beq $t2 0 end_for_loop
			
#key = the_list[i]
			lw $t0 8($fp)	#array
			lw $t1 -8($fp)	#counter i
			addi $t1 $t1 1	#add 1 to jump over size	
			sll $t1 $t1 2
			add $t2 $t0 $t1
			lw $t3 0($t2)
			sw $t3 -12($fp)	#storing array value at index i in key

#j = i - 1
			lw $t0 -8($fp)
			addi $t0 $t0 -1
			sw $t0 -16($fp)

while_loop:		
			lw $t0 -16($fp)	#j
			slt $t1 $t0 $0 # while not j < 0 jump to and and check the next condition
			beq $t1 $0 to_and
			j end_while_loop

to_and:			
			lw $t0 8($fp)	# array
			lw $t1 -16($fp)	# counter j
			addi $t1 $t1 1	#add 1 to jump over size		
			sll $t1 $t1 2
			add $t2 $t0 $t1 # t2 = address of the_list[j]
			lw $t3 0($t2)
			lw $t4 -12($fp)	#key
			slt $t5 $t4 $t3	#if key is not less than list jump to end of loop
			beq $t5 $0 end_while_loop

#the_list[j + 1] = the_list[j]			
			lw $t0 8($fp)	# array
			lw $t1 -16($fp)	# counter j
			addi $t1 $t1 1	#add 1 to skip size	
			sll $t1 $t1 2
			add $t2 $t0 $t1 # t2 = address of the_list[j]
			lw $t3 0($t2)
			addi $t4 $t2 4	# t3 = address of the_list[j+1]
			sw $t3 0($t4) #storing

			lw $t0 -16($fp)
			addi $t0 $t0 -1	#decrementing j by one
			sw $t0 -16($fp)

#the_list[j + 1] = key
			lw $t0 8($fp)	# array
			lw $t1 -16($fp)	# counter j
			addi $t1 $t1 1		
			sll $t1 $t1 2
			add $t2 $t0 $t1 # t2 = address of the_list[j]
			addi $t3 $t2 4	# t3 = address of the_list[j+1]
			lw $t4 -12($fp)	#key
			sw $t4 0($t3)

#jump to top of while
			j while_loop

end_while_loop:		
			lw $t0 -8($fp)
			addi $t0 $t0 1	#increment for loop counter i by one
			sw $t0 -8($fp)

			j for_loop	#jump to top of for loop

end_for_loop:		
#remove local variables
			addi $sp $sp 16

#restore $fp and $ra
			lw $fp 0($sp)
			lw $ra 4($sp)
			addi $sp $sp 8

			jr $ra		#return to caller

exit:
			addi $v0 $0 10
			syscall
		
