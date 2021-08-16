.data
anvInput: .space 20	# Användarinput.
newline: .asciiz "\n"	# Ny rad med '\n'
str1: .asciiz "\nInput: \n"
.text	
main:
	# Här tar systemet emot input från användaren
	li $v0, 8 # 'Load Immediate' 8 bytes tilldelas åt $v0. Denhär raden förbereder systemet
		  # på att det kommer att få läsa av användarens indata!
	li $a1, 20	# 20 (bytes för max 20 tecken) dvs. maxlängden på användarens input-text.
	la $a0, anvInput
	syscall		# Med syscall säger vi till systemet att exekvera.
	
	li $v0, 4
	li $t0, 0

loop:
	lb $t1, anvInput($t0)
	beq $t1, 0, avslut
	blt $t1, 'a', versal	# blt -> 'Branch'/'förgrena' OM = 'mindre än' |	Från lilla 'a' i alfabetet
	bgt $t1, 'ö', versal	# bgt -> 'Branch'/'förgrena' OM = 'större än' | till lilla 'ö' i alfabetet.
	sub $t1, $t1, 32	# sub -> 'subtrahera' med 'overflow'
	sb $t1, anvInput($t0)	# sb -> 'store byte' från $t1 till anvInput $t0

versal: 
	addi $t0, $t0, 1
    j loop

avslut:
    li $v0, 4
    la $a0, anvInput
    syscall

    li $v0, 10
    syscall