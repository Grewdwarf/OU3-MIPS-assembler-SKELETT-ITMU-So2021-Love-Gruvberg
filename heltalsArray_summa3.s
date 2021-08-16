.data # data section

array_nr1: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19

output_nr1: .asciiz "Sum a = "
new_line: .asciiz "\n"

.text # text section

.globl main # call main by SPIM

main:
# out of loop when we got 10 numbers
la	$t0, array_nr1
#la	$t1, array_b
li	$t2, 0            # int i
li	$t3, 0            # int sum

# sum all number in a array "a"
loopA:
# condition to terminal loop
sltiu $t7, $t2, 20
beq   $t7, $0,  endA
# load array to $t4
lw    $t4, ($t0)
addu $t3, $t3, $t4
# advance $t0 by 4
addiu	$t0, $t0, 4
# i++
addiu $t2, $t2, 1
j loopA
endA:

# print string "sum"
la	$a0, output_nr1
li	$v0, 4
syscall

#print sum of "a"
addu	$a0, $0, $t3
li	$v0, 1
syscall

# new line
la	$a0, new_line
li	$v0, 4
syscall

# reset `i` and `sum`
li	$t2, 0            # int i
li	$t3, 0            # int sum

# sum all number in a array "b"
#loopB:
# condition to terminal loop
#sltiu $t7, $t2, 10
#beq   $t7, $0,  endB
# load array to $t4
#lw    $t4, ($t1)
#addu $t3, $t3, $t4
# advance $t0 by 4
#addiu	$t1, $t1, 4
# i++
#addiu $t2, $t2, 1
#j loopB
#endB:

# print string "sum"
#la	$a0, output_b
#li	$v0, 4
#syscall

#print sum of "b"
#addu	$a0, $0, $t3
#li	  $v0, 1
#syscall


# call exit once everything is done
li	$v0, 10
syscall
