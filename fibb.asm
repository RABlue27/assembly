.data
comma: .ascii     ", "
N:     .word      6 #Fib(N)

#Code based off Prof's fib.asm on his website as well as some questions I've had that appear on stack overflow
#Alex Duclos | 6738884 

.text
main:


	lw $a0, N		#initialize n
	jal Fib_0		#call Fib(n)
	move $t1, $v0		#store result of function
	
	move $a0, $t1  		#Print result to show it works
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall 	


Fib_0:

#Is there a better way to reserve 20 bytes? 
#addi $sp $sp  -20 doesn't work and this is the only 
#way i could find to save the stacks.
#like I saw someone do it online like this but it just seems so incredibly wrong?
	addi $sp,$sp,-4
	sw $ra,($sp)
	addi $sp,$sp,-4 
	sw $a0,($sp) 
	addi $sp,$sp,-4 
	sw $a1,($sp)
	addi $sp,$sp,-4 
	sw $a2,($sp) 
	addi $sp,$sp,-4 
	sw $a3,($sp) 

	j Dec

#Wrote this to basically decide which case it is. Dec is short for decision 
Dec:
	#check my base cases 
	beq $a0,0,Fib_2 
	beq $a0,1,Fib_3
	beq $a0,2,Fib_1 

	#divide by two (This bits from stackoverflow since I couldnt find the mod operator
	div $a1,$a0,2
	#get reminder 
	mfhi $a1
	#run Fib_6 or Fib_4 if the  umber is even or odd 
	beq $a1,$zero,Fib_6
	j Fib_4
	
#Base
Fib_2:
	li $v0,1
	j Fib_5
#Base
Fib_3:
	li $v0,1
	j Fib_5
#Base
Fib_1:
	li $v0,2
	j Fib_5

#This is the same concept as the Fib given in class
#but i get the N values in the function since I get
#different N values based on the value of N currently
#Does that make sense? I feel like it doesn't but 
#I truly have no clue how to document assembly code
Fib_6:
	div $a0,$a0,2
	jal Fib_0
	move $a3,$v0 
	add $a0,$a0,1
	jal Fib_0
	add $v0,$v0,$a3
	add $v0,$v0,1
	j Fib_5


Fib_4:
	sub $a0,$a0,1 
	div $a0,$a0,2 
	jal Fib_0
	move $a3,$v0 
	sub $a0,$a0,1
	jal Fib_0
	add $v0,$v0,$a3
	add $v0,$v0,1
	j Fib_5

#This is the final function. Just basically does the 
#Inverse of above version and destroys the stack.
Fib_5:
lw $a3,($sp) 
addi $sp,$sp,4
lw $a2,($sp) 
addi $sp,$sp,4 
lw $a1,($sp)
addi $sp,$sp,4 
lw $a0,($sp) 
addi $sp,$sp,4 
lw $ra,($sp) 
addi $sp,$sp,4
jr $ra
