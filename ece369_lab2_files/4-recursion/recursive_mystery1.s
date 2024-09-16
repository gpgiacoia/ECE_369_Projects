# Exercise 3
# Max Score: 12 points
.data
list1:		.word		3, 9, 1, 2, 6, 3, -4, -7, -8, 4, -2,  8, 7, 6
.text 		# list1 is an array of integers storing the given sequence of values
.globl	tomato
tomato:
addi	$sp, $sp, -8	    # $sp -= 8
addi	$t0, $a0, -1	    # $t0 = $a0 - 1
sw  	$t0, 0($sp)	    # mem[$sp] = $t0
sw  	$ra, 4($sp)	    # mem[$sp + 4] = $ra
bne 	$a0, $zero, orange  # if $a0 is not zero, branch orange
li  	$v0, 0		    # $v0 = 0
addi	$sp, $sp, 8	    # $sp += 8
jr 	$ra		    # jump to $ra
orange:
move	$a0, $t0
jal   	tomato
lw    	$t0, 0($sp)	    # $t0 = mem[$sp]
sll	$t1, $t0, 2	    # $t1 = $t0 * 4
add   	$t1, $t1, $a1	    # $t1 += $a1
lw    	$t2, 0($t1)	    # $t2 = mem[$t1]
add   	$v0, $v0, $t2	    # $v0 += $t2
lw    	$ra, 4($sp)	    # $ra = mem[$sp + 4]
addi 	$sp, $sp, 8	    # $sp += 8
jr 	$ra		    # jump to $ra
# main function starts here
.globl main
main:
	addi	$sp, $sp, -4	# $sp -= 4	    Make space on stack
	sw	$ra, 0($sp)	# mem[$sp] = $ra    Save return address
	la	$a1, list1	#		    a1 has the base address pointing to the first
				#		    element of the “list1” array declared in .data section above
	li	$a0, 9		# $a0 = 9	    loads the immediate value into the destination register
	jal	tomato
return:
	li	$v0, 0		# $v0 = 0	    Return value
	lw	$ra, 0($sp)	# $ra = mem[$sp]    Restore return address
	addi	$sp, $sp, 4	# $sp += 4	    Restore stack pointer
	jr 	$ra		#		    Return
# Step through this code in your simulator and monitor the register values.
# What does the tomato function do?
# 1. Decrements the stack pointer by 8 to make space for 2x 32 bit values.
# 2. Store $a0 - 1 at $sp
# 3. Store $ra at $sp + 4
# 4. If $a0 is not equal to 0, jump to label orange
#   a. Move $t0 to $a0
#   b. Jump back to start of tomato
# 5. Store 0 in $v0
# 6. Increment $sp by 8, putting it back where it was before tomato was called
# 7. Jump to $ra
#
# The tomato function is used to make space in the stack and store some values in memory.
# First, it moves the stack pointer back by 8 bytes to make room for 2 words to be stored.
# Then, at the new location of the stack pointer, $a0 - 1 is stored. Then, $ra is stored 4
# bytes or 1 word ahead of that. If $a0 is not 0, then we jump to orange. In orange, we
# move $t0 to $a0 and then return to tomato. This will continue recursively until $a0 is 0.
# Since we moved $t0 to $a0, this reuses the value from the previous calls.
#
# Once $a0 is 0, then we store 0 in $v0 and increment $sp by 8 to return the stack to where
# it was. Then we jump to the return address. All of the previous calls will finish out
# these last 3 steps which will return the stack pointer to where it started from.
# 
# The overall purpose of 'tomato' is to store some amount of values recursively into the stack.
