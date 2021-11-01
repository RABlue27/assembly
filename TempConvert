.data
#All the data we need saved starting from the begining 
Celsius: 'c'
Farenhiet: 'f'
Kelvin: 'k'
s1: .asciiz  "\nPlease try entering another value!\n"
s2: .asciiz  "\nYou have chosen: Celsius\n"
s3: .asciiz  "\nYou have chosen: American\n"
s4: .asciiz  "\nYou have chosen: Kelvin\n"
s5: .asciiz "\nEnter your low number first, and your high number second\n"

Cel: .asciiz "C: "
Far: .asciiz "F: "
Kel: .asciiz "K: "

newLine: .asciiz "\n"

empty: .asciiz "   "

.text #Starting the main code

WhileLoop: #Create a loop that we jump to. 
			
	li $v0, 12 #Load Data
	syscall
	#Check if our input is equal to what we desire it to be. if so, we jump out of the while loop
	beq $v0, 'c', CelsiusInput
	beq $v0, 'f', FaranhietInput
	beq $v0, 'k', KelvinInput
	#if not equal, we conitnue as usual. We load a new value and yell at the user
	li $v0, 4
	la $a0, s1
	syscall
	#rejump to ther while loop 
	j WhileLoop


#First 3 lines: tell user thier input
#Second three lines: tell user instruction
#Last line, jump to end of program.
CelsiusInput:
	li $v0, 4
	la $a0, s2
	syscall
	
	li $v0, 4
	la $a0, s5
	syscall
	
	#read int
	li $v0, 5
	syscall
	#read second int
	move $t0, $v0	
	li $v0, 5
	syscall
	move $t1, $v0
	#not ints are stored in $t0 and $t1
	#low is stored in t0.
	#first we convert to Fahrenheit
	#first we multiply by 9.
	
	#We loop through the table, if $v0 < $v1 convert that to both K and F and output. then inc v0.
	LowToHigh:
	
		bgt $t0, $t1, EndProgram #while less than 
		
		li $v0, 4
		la $a0, Cel
		syscall
		li $v0, 1
		la $a0, ($t0)
		syscall
		li $v0, 4
		la $a0, empty
		syscall
		
		
		la $t3, ($t0) #placeholder value of t0 in t3.
		mul $t0, $t0, 9
		div $t0, $t0, 5
		addi $t0, $t0, 32
		#output to F
		#move $a0, $t0 #move to v0 from t0 so we can print.
		
		li $v0, 4
		la $a0, Far
		syscall
		
		la $a0, ($t0)
		li $v0, 1	
		syscall		

		#add space
		la $a0, empty
		li $v0, 4
		syscall
		
		#output to K
					
		la $t0, ($t3)
		addi  $t0, $t0, 273
		
		li $v0, 4
		la $a0, Kel
		syscall	
		
		la $a0, ($t0)
		li $v0, 1
		syscall	
		
		#add space
		la $a0, empty
		li $v0, 4
		syscall
		
		
		#t0 back to it's default state.
		la $t0, ($t3)
		#t0 incriments
		addi $t0, $t0, 1
		
			
		li $v0, 4
		la $a0, newLine
		syscall
		
		j LowToHigh
		

	j EndProgram
	
FaranhietInput:
	li $v0, 4
	la $a0, s3
	syscall
	
	li $v0, 4
	la $a0, s5
	syscall
	
	#read int
	li $v0, 5
	syscall
	#read second int
	move $t0, $v0	
	li $v0, 5
	syscall
	move $t1, $v0
	#not ints are stored in $t0 and $t1
	#low is stored in t0.
	#first we convert to Fahrenheit
	#first we multiply by 9.
	
	#We loop through the table, if $v0 < $v1 convert that to both K and F and output. then inc v0.
	LowToHigh2:
		#convert from F->C 
		
		li $v0, 4
		la $a0, Far
		syscall
		li $v0, 1
		la $a0, ($t0)
		syscall
		li $v0, 4
		la $a0, empty
		syscall
		
		
		bgt $t0, $t1, EndProgram #while less than 
		la $t3, ($t0) #placeholder value of t0 in t3.
		sub $t0, $t0, 32
		mul $t0, $t0, 5
		div $t0, $t0, 9
		
		#output to F
		#move $a0, $t0 #move to v0 from t0 so we can print.
		li $v0, 4
		la $a0, Cel
		syscall
		
		
		la $a0, ($t0)
		li $v0, 1	
		syscall		

		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
		
		#output to K
					
		la $t0, ($t3)
		
		addi  $t0, $t0, 460
		mul $t0, $t0, 5
		div $t0, $t0, 9		
		
		li $v0, 4
		la $a0, Kel
		syscall
	
		la $a0, ($t0)
		li $v0, 1
		syscall	
		
		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
		
		
		#t0 back to it's default state.
		la $t0, ($t3)
		#t0 incriments
		addi $t0, $t0, 1
		
			
		li $v0, 4
		la $a0, newLine
		syscall
		
		j LowToHigh2
		
	j EndProgram
KelvinInput:
	li $v0, 4
	la $a0, s4
	syscall
	
	li $v0, 4
	la $a0, s5
	syscall
	
	#read int
	li $v0, 5
	syscall
	#read second int
	move $t0, $v0	
	li $v0, 5
	syscall
	move $t1, $v0
	#not ints are stored in $t0 and $t1
	#low is stored in t0.
	#first we convert to Fahrenheit
	#first we multiply by 9.
	
	#We loop through the table, if $v0 < $v1 convert that to both K and F and output. then inc v0.
	LowToHigh3:
		#convert from K->C 
				
		li $v0, 4
		la $a0, Kel
		syscall
		li $v0, 1
		la $a0, ($t0)
		syscall
		li $v0, 4
		la $a0, empty
		syscall
		
		bgt $t0, $t1, EndProgram #while less than 
		la $t3, ($t0) #placeholder value of t0 in t3.
		sub $t0, $t0, 273
		
		#output to C
		#move $a0, $t0 #move to v0 from t0 so we can print.
		
		li $v0, 4
		la $a0, Cel
		syscall
	
		
		la $a0, ($t0)
		li $v0, 1	
		syscall		

		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
		
		#output to F
					
		la $t0, ($t3)
		
		mul $t0, $t0, 9
		div $t0, $t0, 5		
		sub  $t0, $t0, 460
		
		li $v0, 4
		la $a0, Far
		syscall
	
		
		
		la $a0, ($t0)
		li $v0, 1
		syscall	
		
		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
				
		#t0 back to it's default state.
		la $t0, ($t3)
		#t0 incriments
		addi $t0, $t0, 1
		
			
		li $v0, 4
		la $a0, newLine
		syscall
		
		j LowToHigh3
	
	
	j EndProgram
	
EndProgram:
