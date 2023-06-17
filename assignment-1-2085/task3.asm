# a program with a function to compare Hulk's strength with other people.
# author: Shoumil Guha
# created: 13-8-2022


    .data
.globl smash_or_sad
smash: .asciiz "Hulk SMASH! >:(\n"
sad: .asciiz "Hulk Sad :(\n"
message_start: .asciiz "Hulk smashed "
message_end: .asciiz " people\n"

    .text

main:			
#set $fp and make space for locals
			addi $fp $sp 0   
			addi $sp $sp -8	#local variable + memory location of array = 8bytes
			
#creating array and storing variables
			addi $v0 $0 9
			addi $a0 $0 20	#storing 16 bytes for array[3] and size
			syscall
			sw $v0 -8($fp) #storing array location
			addi $t0, $0 4 
			sw $t0, ($v0)  #storing size of array

#storing array elements
			lw $t0 -8($fp)	#loading up the place where the array is
			addi $t1 $0 2	
			sw $t1 4($t0)	#index 1 value	
			addi $t1 $0 3	
			sw $t1 8($t0)	#index 2 value
			addi $t1 $0 10
			sw $t1 12($t0)	#index 3 value
			addi $t1 $0 16
			sw $t1 16($t0)	#index 4 value
			 
#storing hulk power as local variable
			addi $t0 $0 15 
			sw $t0 -4($fp)

#function call
#push arguments
			addi $sp $sp -8	# 4 bytes for array location and 4 for hulk power
			
#arg 1 = the_list
			lw $t0 -8($fp)
			sw $t0 0($sp)

#arg 2 = hulk power
			lw $t0 -4($fp)
			sw $t0 4($sp)

#link and goto power
			jal smash_or_sad

#remove arguments
			addi $sp $sp 8

#store return value
			sw $v0 -4($fp)

#print message		
			la $a0 message_start
			addi $v0 $0 4
			syscall
			lw $a0 -4($fp)
			addi $v0 $0 1
			syscall
			la $a0 message_end
			addi $v0 $0 4
			syscall

#exit the program	
			j exit

smash_or_sad: 
#save $ra and $fp in stack
			addi $sp $sp -8
			sw $ra 4($sp)
			sw $fp 0($sp)

#copy $sp to $fp
			addi $fp $sp 0

#allocate local variables
			addi $sp $sp -8

#initialize locals
			sw $0 -8($fp)	#smash count = 0
			sw $0 -4($fp) 	#counter for for loop

for_loop:		
			lw $t0 8($fp)		#load the array
			lw $t1 0($t0)		#load the size of the array
			lw $t2 -4($fp)		#load counter
			slt $t3 $t2 $t1		#if not counter < size
			beq $t3 $0 endloop	# go to end of loop

if:			lw $t0 12($fp)		#load hulk smash variable
			lw $t1 -4($fp)		#load counter
			addi $t1 $t1 1		#add one to counter to skip size
			sll $t1 $t1 2		#counter*4
			lw $t2 8($fp)		#load array
			add $t2 $t2 $t1	    #going to relevant array position
			lw $t3 0($t2)		#value at position (enemy power)
			slt $t2 $t0 $t3		#if hulk weaker than enemy
			bne $t2 $0 else		#jump to else
		
#print message	
			la $a0 smash		
			addi $v0 $0 4
			syscall

			lw $t0 -8($fp)
			addi $t0 $t0 1		#increment smash count by 1
			sw $t0 -8($fp)
			
			j endif

else:
#print message
			la $a0 sad		
			addi $v0 $0 4
			syscall

endif:	
#increment loop counter by 1	
			lw $t0 -4($fp)	
			addi $t0 $t0 1
			sw $t0 -4($fp)

			j for_loop #jump back to top of loop

endloop:
#returning smash count			
			lw $v0 -8($fp)

#remove local var
			addi $sp $sp 8

#restore $fp and $ra
			lw $fp 0($sp)
			lw $ra 4($sp)
			addi $sp $sp 8

#return to caller
			jr $ra
			   	
exit:			
			addi $v0 $0 10
			syscall
			
			


