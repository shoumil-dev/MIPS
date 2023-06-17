# a program to find all possible combinations of events for defeating Thanos
# author: Shoumil Guha
# created: 18-8-2022

    .data
.globl print_combination
.globl combination_aux
space: .asciiz " "
newline: .asciiz "\n"
    .text

main: 
#allocating space for local variables
			addi $fp $sp 0
			addi $sp $sp -12  # 3 locals  

#initialising array
			addi $v0 $0 9
			addi $a0 $0 24  # (5+1)*4 = 24 bytes
			syscall
			sw $v0 -12($fp)
			addi $t0 $0 5
			sw $t0 ($v0)  #storing size at the beginning of array

#initialising values in array
			lw $t0 -12($fp)
			addi $t1 $0 1
			sw $t1 4($t0)
			addi $t1 $0 2
			sw $t1 8($t0)
			addi $t1 $0 3
			sw $t1 12($t0)
			addi $t1 $0 4
			sw $t1 16($t0)
			addi $t1 $0 5
			sw $t1 20($t0)

#creating local variable 'r'
			addi $t0 $0 3
			sw $t0 -8($fp)
			
#creating local variable 'n'
			lw $t0 -12($fp)
			lw $t1 0($t0)  #storing size of array in t1
			sw $t1 -4($fp)

#allocating space for arguments
			addi $sp $sp -12  # 3 arguments
			lw $t0 -12($fp)
			sw $t0 0($sp)  # address of list is arg 1
			lw $t0 -4($fp)
			sw $t0 4($sp)  # n is arg 2
			lw $t0 -8($fp)
			sw $t0 8($sp)  # r is arg 3

#call print_combination
			jal print_combination

#clear arguments
			addi $sp $sp 12

#remove locals, then exit
			addi $sp $sp 12
			addi $v0 $0 10
			syscall

print_combination:
#function entry (saving fp and ra and making space for locals)			
			addi $sp $sp -8
			sw $ra 4($sp)
			sw $fp 0($sp)
			addi $fp $sp 0  
			addi $sp $sp -4  # space for locals

#creating data array of length r
			addi $v0 $0 9
			lw $t0 16($fp)  # r
			addi $t0 $t0 1  # incrementing by one to account for size
			sll $t0 $t0 2  # multiply by 4
			addi $a0 $t0 0
			syscall
			sw $v0 -4($fp)  #store array address as local variable
			sw $t0 ($v0)

#allocating space for arguments
			addi $sp $sp -24  # 6 arguments
			lw $t0 8($fp)
			sw $t0 0($sp)  # array as arg 1
			lw $t0 12($fp)
			sw $t0 4($sp)  # n as arg 2
			lw $t0 16($fp)
			sw $t0 8($sp)  # r as arg 3
			sw $0 12($sp)  # index = 0 as arg 4
			lw $t0 -4($fp)
			sw $t0 16($sp)  # data array as arg 5
			sw $0 20($sp)  # i = 0 as arg 6

#call combination_aux
			jal combination_aux

#clear arguments
			addi $sp $sp 24

#remove local variable
			addi $sp $sp 4

#restore $fp and $ra
			lw $fp 0($sp)
			lw $ra 4($sp)
			addi $sp $sp 8  # deallocate

#return to caller
			jr $ra

combination_aux:
#function entry (save ra and fp)
			addi $sp $sp -8
			sw $ra 4($sp)
			sw $fp 0($sp)
			addi $fp $sp 0  # copy $sp $fp

#space for locals
			addi $sp $sp -4
			sw $0 -4($fp)  # counter j for for_loop

#body of function
#start of if statement 1			
			lw $t0 20($fp)  # index
			lw $t1 16($fp)  # r
			bne $t0 $t1 nextif  # if index != r, jump to next if statement

for_loop:		
			lw $t0 -4($fp)  # j
			lw $t1 16($fp)  # r
			slt $t2 $t0 $t1  # if j not less than r, jump to end of loop
			beq $t2 $0 end_loop

#print value
			lw $t0 24($fp)  # data
			lw $t1 -4($fp)  # j
			addi $t1 $t1 1  # incrementing j to account for size
			sll $t1 $t1 2  # multiplying by 4 bytes
			add $t2 $t0 $t1  # indexing jth position
			lw $a0 0($t2)
			addi $v0 $0 1
			syscall
			la $a0 space
			addi $v0 $0 4
			syscall

#incrementing j
			lw $t0 -4($fp)
			addi $t0 $t0 1
			sw $t0 -4($fp)

			j for_loop  # jumping to top of loop

end_loop:		
			la $a0 newline  # print a newline
			addi $v0 $0 4
			syscall

			j return  # leave function

#start of if statement 2
nextif:
			lw $t0 28($fp)  # i
			lw $t1 12($fp)  # n
			slt $t2 $t0 $t1  # if i < n is true, skip the if statement
			bne $t2 $0 endif

			j return # leave function

endif:
#data[index] = arr[i]
			lw $t0 24($fp)  # data
			lw $t1 20($fp)  # index
			addi $t1 $t1 1  # accounting for size
			sll $t1 $t1 2  # multiplying by 2 bytes
			add $t2 $t1 $t0  #  going to position
			
			lw $t3 8($fp)
			lw $t4 28($fp)
			addi $t4 $t4 1
			sll $t4 $t4 2
			add $t5 $t4 $t3
			lw $t6 0($t5)
			sw $t6 0($t2)  # storing in data array

#recursive call 1
#allocating space for arguments
			addi $sp $sp -24  # 6 arguments
			lw $t0 8($fp)
			sw $t0 0($sp)  # array as arg 1

			lw $t0 12($fp)
			sw $t0 4($sp)  # n as arg 2

			lw $t0 16($fp)
			sw $t0 8($sp)  # r as arg 3

			lw $t0 20($fp)
			addi $t0 $t0 1
			sw $t0 12($sp)  # index+1 as arg 4

			lw $t0 24($fp)
			sw $t0 16($sp)  # data array as arg 5

			lw $t0 28($fp)
			addi $t0 $t0 1
			sw $t0 20($sp)  # i+1 as arg 6

#call combination_aux
			jal combination_aux

#deallocate arguments
			addi $sp $sp 24

#recursive call 2
#allocating space for arguments
			addi $sp $sp -24  # 6 arguments
			lw $t0 8($fp)
			sw $t0 0($sp)  # array as arg 1

			lw $t0 12($fp)
			sw $t0 4($sp)  # n as arg 2

			lw $t0 16($fp)
			sw $t0 8($sp)  # r as arg 3

			lw $t0 20($fp)
			sw $t0 12($sp)  # index as arg 4

			lw $t0 24($fp)
			sw $t0 16($sp)  # data array as arg 5

			lw $t0 28($fp)
			addi $t0 $t0 1
			sw $t0 20($sp)  # i+1 as arg 6

#call combination_aux
			jal combination_aux

#deallocate arguments
			addi $sp $sp 24
			j return
			
return:	
#remove local var
			addi $sp $sp 4

#restore $fp and $ra
			lw $fp 0($sp)
			lw $ra 4($sp)
			addi $sp $sp 8  # deallocate

#return to caller
			jr $ra

			
			
			 











