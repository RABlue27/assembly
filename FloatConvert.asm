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

nine: .double 9.0
five: .double 5.0
threetwo: .double 32.0
twoseventhree: .double 273.15
one: .double 1.0
fourfivenine: .double 459.67


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
	
	#transform ints to flaots.
	mtc1.d $t0, $f2
	cvt.d.w $f2, $f2
	mtc1.d $t1, $f4
	cvt.d.w $f4, $f4
	
	
	#We loop through the table, if $v0 < $v1 convert that to both K and F and output. then inc v0.
	LowToHigh:
		#conditional 
		c.eq.d $f2, $f4
		bc1t EndProgram
		
		li $v0, 4
		la $a0, Cel
		syscall
		li $v0, 3 
		mov.d $f12, $f2
		syscall
		li $v0, 4
		la $a0, empty
		syscall

		mov.d $f8, $f12 #Holding $f2 in $f8
		l.d $f10, nine
		mul.d $f12, $f12, $f10
		l.d  $f10, five
		div.d $f12, $f12, $f10
		l.d $f10, threetwo
		add.d $f12, $f12, $f10 
		#addi $t0, $t0, 32
		#output to F
		#move $a0, $t0 #move to v0 from t0 so we can print.
		
		li $v0, 4
		la $a0, Far
		syscall
		
		li $v0, 3
		mov.d $f12, $f12	
		syscall		

		#add space
		la $a0, empty
		li $v0, 4
		syscall
		
		#output to K
			
		mov.d $f2, $f8
				
		l.d $f10, twoseventhree
		add.d $f2, $f2, $f10 
		
		li $v0, 4
		la $a0, Kel
		syscall	
		
		
		li $v0, 3
		mov.d $f12, $f2	
		syscall		

		#add space
		la $a0, empty
		li $v0, 4
		syscall
		
		
		#t0 back to it's default state.
		mov.d $f2, $f8
		#t0 incriments
		
		l.d $f10, one
		add.d $f2, $f2, $f10 
		
			
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
	
	#transform ints to flaots.
	mtc1.d $t0, $f2
	cvt.d.w $f2, $f2
	mtc1.d $t1, $f4
	cvt.d.w $f4, $f4
	
	#We loop through the table, if $v0 < $v1 convert that to both K and F and output. then inc v0.
	LowToHigh2:
		#convert from F->C 
		c.eq.d $f2, $f4
		bc1t EndProgram
		
		li $v0, 4
		la $a0, Far
		syscall
		li $v0, 3 
		mov.d $f12, $f2
		syscall
		li $v0, 4
		la $a0, empty
		syscall
		
		  
		mov.d $f8, $f12 #Holding $f2 in $f8
		l.d $f10, threetwo
		sub.d $f2, $f2, $f10
		l.d $f10, five
		mul.d $f2, $f2, $f10
		l.d $f10, nine
		div.d $f2, $f2, $f10
		
		#output to F
		#move $a0, $t0 #move to v0 from t0 so we can print.
		li $v0, 4
		la $a0, Cel
		syscall
		
		
		li $v0, 3
		mov.d $f12, $f2	
		syscall		
		

		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
		
		#output to K
					
		mov.d $f2, $f8
		l.d $f10, fourfivenine
		add.d $f2, $f2, $f10
		l.d $f10, five
		mul.d $f2, $f2, $f10
		l.d $f10, nine
		div.d $f2, $f2, $f10
		
		li $v0, 4
		la $a0, Kel
		syscall
	
			
		li $v0, 3
		mov.d $f12, $f2	
		syscall		

		
		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
		
		
		
		
		#t0 back to it's default state.
		mov.d $f2, $f8
		#t0 incriments
		
		l.d $f10, one
		add.d $f2, $f2, $f10 
		
			
		li $v0, 4
			
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
	
	mtc1.d $t0, $f2
	cvt.d.w $f2, $f2
	mtc1.d $t1, $f4
	cvt.d.w $f4, $f4
	
	#We loop through the table, if $v0 < $v1 convert that to both K and F and output. then inc v0.
	LowToHigh3:
		#convert from K->C 
		c.eq.d $f2, $f4
		bc1t EndProgram
				
		li $v0, 4
		la $a0, Kel
		syscall
		li $v0, 3 
		mov.d $f12, $f2
		syscall
		li $v0, 4
		la $a0, empty
		syscall
		
		mov.d $f8, $f12 #Holding $f2 in $f8
		l.d $f10, twoseventhree
		sub.d $f2, $f2, $f10

		
		#output to C
		#move $a0, $t0 #move to v0 from t0 so we can print.
		
		li $v0, 4
		la $a0, Cel
		syscall
	
			
		li $v0, 3
		mov.d $f12, $f2	
		syscall		

		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
		
		#output to F
					
		mov.d $f2, $f8
		l.d $f10, nine
		mul.d $f2, $f2, $f10
		l.d $f10, five
		div.d $f2, $f2, $f10
		l.d $f10, fourfivenine	
		sub.d  $f2, $f2, $f10
		
		li $v0, 4
		la $a0, Far
		syscall
	
		
		li $v0, 3
		mov.d $f12, $f2	
		syscall		

		
		#make it pretty
		la $a0, empty
		li $v0, 4
		syscall
				
		#t0 back to it's default state.
		mov.d $f2, $f8
		#t0 incriments
		l.d $f10, one
		add.d $f2, $f2, $f10
		
			
		li $v0, 4
		la $a0, newLine
		syscall
		
		j LowToHigh3
	
	
	j EndProgram
	
	
#I don't actually know if this is what you're supposed to do, but I just jump to the end of the program after each method to make sure we don't run them all	
EndProgram:
