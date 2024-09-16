# Exercise 3
# Max Score: 12 points

# Students: Giuseppe Pongelupe Giacoia (33%), Carson Keegan (33%), Leo Dickinson (33%)
.data
list1:		.word		3, 9, -1, 0, 6, 5, -4, -7, -8,
list2:		.word		9, 5, 0, 3, -4, 5, 6, -7, 8, 9,
.text
.globl	tomato
tomato:
addi	$sp, $sp, -8		# $sp -= 8
addi	$t0, $a0, -1		# $t0 = $a0 - 1
sw  	$t0, 0($sp)		# mem[$sp] = $t0
sw  	$ra, 4($sp)		# mem[$sp + 4] = $ra
bne 	$a0, $zero, orange	# if $a0 != 0 jump to orange
li  	$v0, 0			# $v0 = 0
addi	$sp, $sp, 8		# $sp += 8
jr 	$ra			# jump to $ra

orange:
add	$a0, $0, $t0		# $a0 = $t0?
jal	tomato			# jump to tomato
lw	$t0, 0($sp)		# $t0 = mem[$sp]
sll	$t1, $t0, 2		# $t1 = $t0 * 4
add	$t1, $t1, $a1		# $t1 += $a1
lw	$t2, 0($t1)		# $t0 = mem[$t1]
slt	$t3, $t2, $a2		# $t3 = $t2 < $a2
bne	$t3, $0, carrot		# if $t3 != 0 jump to carrot	if $t2 >= 5
add	$v0, $v0, $t2		# $v0 += $t2			then $v0 += $t2

carrot:
lw	$ra, 4($sp)		# $ra = mem[$sp + 4]
addi 	$sp, $sp, 8		# $sp += 8
jr 	$ra			# jump to $ra
########################################################################
.globl	test
test:
addi	$sp, $sp, -4		# $sp -= 4		Make space on stack
sw	$ra, 0($sp)		# mem[$sp] = $ra	Save return address
jal	tomato			# jump to tomato	call function
lw	$ra, 0($sp)		# $ra = mem[$sp]	Restore return address
addi	$sp, $sp, 4		# $sp += 4		Restore stack pointer
jr 	$ra			# jump $ra		Return
########################################################################
# main function starts here                                            #
.globl main
main:	addi	$sp, $sp, -4	# $sp -= 4		Make space on stack
	sw	$ra, 0($sp)	# mem[$sp] = $ra	Save return address
	la	$a1, list2	# $a1 = &list2
	li	$a0, 8		# $a0 = 8
	li	$a2, 5		# $a2 = 5
	jal	test		# jump to test after list2
	# nop			# break here #1
# What is the value of $v0 at this point? (v0)= 19        #
	la	$a1, list1	# $a1 = &list1
	li	$a0, 13		# $a0 = 13
	jal	test		# jump to test after list1
	# nop			# break here #2
# What is the value of $v0 at this point?	(v0) = 22       #
# What does this code compute? Your answer HERE: _ _ _ _ _ _ _ _ _ _ _ _ #

# The assembly code uses register $v0 to store a running sum, register $a0 to hold an offset,
# and $a2 to hold the minimum value to compare against. The code iterates through all numbers
# in the lists with an offset. In the traversal of list2, an offset of +13 is applied to the
# list starting address. In list1, an offset of -8 is applied. The code starts the iteration
# from the base address plus the offset. In the case of list1, the offset is negative so it
# starts iterating in the memory designated for list2. As the code iterates through each element,
# it finds the sum of all numbers that are greater than or equal to $a2.

# $v0 = 3 + 9 + 6 + 5 = 23
	# starts + 13
# $v0 = 0 (reset)
# $v0 = 9 + 6 + 5 + 9 + 5 = 34
	# starts - 8

return:
	li	$v0, 0		# $v0 = 0		Return value
	lw	$ra, 0($sp)	# $ra = mem[$sp]	Restore return address
	addi	$sp, $sp, 4	# $sp += 4		Restore stack pointer
	jr 	$ra		# jump to $ra		Return
