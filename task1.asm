# author: Shoumil Guha
# date: 06.08.2022
# This is the assembly code for Task 1 Assignment 1

	.data 
tier_one_price: .word 9
tier_two_price: .word 11
tier_three_price: .word 14
discount_flag: .word 0
welcome_message: .asciiz "Welcome to the Thor Electrical Company!\n"
age_prompt_message: .asciiz "Enter your age: "
consumption_prompt_message: .asciiz "Enter your total consumption in kWh: "
total_cost: .word 0
age: .word 0
consumption: .word 0
gst: .word 0
total_bill: .word 0
final_message: .asciiz "Mr Loki Laufeyson, your electricity bill is $"
fullstop: .asciiz "."

	.text
		la $a0 welcome_message
		addi $v0 $0 4
		syscall
		
	 	la $a0 age_prompt_message
		addi $v0 $0 4
		syscall
		
		addi $v0 $0 5
		syscall
		sw $v0 age
		
		lw $t0 age
		addi $t1 $0 18
		addi $t2 $0 65
		slt $t3 $t1 $t0		#result = 18 < age		
		beq $t3 $0 then
		slt $t4 $t0 $t2		#result = age < 65
		bne $t4 $0 else
		j then  
		
then:		addi $t0 $0 1
		sw $t0 discount_flag
		j endif

else:		sw $0 discount_flag
		j endif

endif: 		lw $a0 discount_flag	#delete later
 		addi $v0 $0 1
 		syscall
 		
 		la $a0 consumption_prompt_message
 		addi $v0 $0 4		
 		syscall
 		addi $v0 $0 5
 		syscall
 		sw $v0 consumption
 		
 		
 		lw $t0 consumption
 		addi $t1 $0 1000
 		slt $t2 $t1 $t0		#result = 1000 < consumption
 		beq $t2 $0 nextif
 		lw $t3 discount_flag
 		bne $t3 $0 elif
 		
 		lw $t0 consumption
 		addi $t1 $t0 -1000	#then
 		lw $t2 tier_three_price
 		mult $t1 $t2
 		mflo $t3
 		lw $t4 total_cost
 		add $t6 $t4 $t3		#total_cost = total_cost + calculated
 		sw $t6 total_cost
 		
 		addi $t0 $0 1000
 		sw $t0 consumption
 		j nextif  
 		
elif:		lw $t0 consumption
		addi $t1 $0 1000
		slt $t2 $t1 $t0	#result = 1000 < consumption
		beq $t2 $0 nextif
		
		lw $t0 consumption
 		addi $t1 $t0 -1000	#then | consumption = consumption-1000
 		lw $t2 tier_three_price
 		addi $t3 $t2 -2		#tier_three_price = tier_three_price - 2
 		mult $t1 $t3
 		mflo $t4
 		lw $t5 total_cost
 		add $t6 $t5 $t4		#total_cost = total_cost + calculated
 		sw $t6 total_cost
		
		addi $t0 $0 1000
 		sw $t0 consumption
 		
nextif: 	lw $t0 consumption
		addi $t1 $0 600
		slt $t2 $t1 $t0	#result = 600 < consumption
		beq $t2 $0 else2
		
		lw $t0 consumption
		addi $t1 $t0 -600
		lw $t2 tier_two_price
		mult $t1 $t2
		mflo $t3
		lw $t4 total_cost
		add $t6 $t4 $t3
		sw $t6 total_cost
		
		addi $t0 $0 600
		sw $t0 consumption		
		j ending_calculations
		
else2:		lw $t0 consumption
 		addi $t1 $t0 -600	#then | consumption = consumption-600
 		lw $t2 tier_two_price
 		addi $t3 $t2 -2		#tier_three_price = tier_three_price - 2
 		mult $t1 $t3
 		mflo $t4
 		lw $t5 total_cost
 		add $t6 $t5 $t4		#total_cost = total_cost + calculated
 		sw $t6 total_cost
		
		addi $t0 $0 600		#consumption = 600
 		sw $t0 consumption
 		
ending_calculations:	lw $t0 consumption
			lw $t1 total_cost
			lw $t2 tier_one_price
			mult $t0 $t2
			mflo $t3
			add $t4 $t1 $t3		#total_cost = total_cost + calculated
			sw $t4 total_cost
			
			lw $t0 total_cost
			addi $t1 $0 10
			div $t0 $t1
			mflo $t2
			sw $t2 gst
			
			lw $t0 total_cost
			lw $t1 gst
			add $t2 $t0 $t1		#total_bill = total_cost + gst
			sw $t2 total_bill
			
			la $a0 final_message
			addi $v0 $0 4
			syscall
			lw $t0 total_bill
			addi $t1 $0 100
			div $t0 $t1
			mflo $a0
			addi $v0 $0 1
			syscall
			la $a0 fullstop
			addi $v0 $0 4
			syscall
			div $t0 $t1
			mfhi $a0
			addi $v0 $0 1
			syscall
			
exit:			addi $v0 $0 10
			syscall
			