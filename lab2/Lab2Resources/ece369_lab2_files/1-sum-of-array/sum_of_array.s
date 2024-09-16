# Exercise 
# 'sum_of_array.s' - This program performs the sum of the array
#  Max Score: 5 points
#
# Students: 
#
#
# Insert your answers below each question:-
# 1(a) What is the address location of the first element of the array, X.
#	0x10010004 (hex)
# 1(b) What is the address location of the last element (element 7) of the array, X.
#	0x1001000c (hex)
# 2.   What are the values at location 'SUM' as the program executes?
#
#      SUM is at address 0x10010010
#	Beginning: 0
#	End: 1
# 3.   Traverse the program in single-step mode. Write down the intermediate 
#      values stored in register $s1 as the program progresses.
#	$s1 is used to hold the running sum
#	The program executes -2 + -4 + 7 = 1
#
#	0: 0
#	1: 0xfffffffe	= -2
#	2: 0xfffffffa	= -6
#	3: 0x1		= 1
#
# 4.   What is the purpose of register $t0 in this program?
#	As we traverse the array X, we use $t0 to store the address of the current element in the array.
#	We use the address stored at $t0 to perform a read from memory at that address location to get
#	the value that is stored there. This value is the current element in the array. We initialize
#	$t0 with the starting address of X, and then we increment by 4 each time to read the next word,
#	which is 4 bytes ahead in memory from the current word.
#
.data                   	# Put Global Data here
N:      .word 3 		# 'N' is the address which contains the loop count, 5
X:      .word -2, -4, 7 	# 'X' is the address of the 1st element in the array to be added
SUM:    .word 0			# 'SUM' is the address that stores the final sum
str:    .asciiz "The sum of the array is = " 

.text				# Put program here 
.globl main			# globally define 'main' 

main: 
    lw      $s0, N		# load loop counter from the address location 'N' and stores into register $s0 
    #	    $1, 4097		  loads 0x10010000 into $1
    #				  loads 3 into $16
    la      $t0, X		# load the address of X and stores into register $t0 
    #	    $1, 4097 [X]	  loads 0x10010000 into $1
    #				  loads 0x10010004 into $8
    and     $s1, $s1, $zero	# performs 'AND' operation between $s1 and $zero, and stores the result into register $s1
    #	    $17, $17		  loads 0 into $17
loop: 
### Loop 1
    lw      $t1, 0($t0)		# load the next value from address location, X+4 into register $t1
    #	    $9, 0($8)		  loads 0xfffffffe into $9
    addu    $s1, $s1, $t1	# add the next value to the running sum
    # sw    $s1, SUM		# sum debug test
    #	    $17, $17, $9	  adds $9 to $17, $17 is now 0xfffffffe
    addi    $t0, $t0, 4 	# increment to the next address
    #				  adds 4 to $8, $8 is now 0x10010008
    addi    $s0, $s0, -1	# decrement the loop counter
    #				  $16 goes from 3 to 2
    bne     $0, $s0, loop	# loop back to label 'loop' when $0 is not equal to $s0
    #	    $0, $16, -16 [loop-0x00400048]
### Loop 2
    # lw      $t1, 0($t0)	# load the next value from address location, X+4 into register $t1
    #	      $9, 0($8)		  loads 0xfffffffc into $9
    # addu    $s1, $s1, $t1	# add the next value to the running sum
    #	      $17, $17, $9	  adds $17 to $9, $17 is now 0xfffffffa
    # addi    $t0, $t0, 4 	# increment to the next address
    #				  adds 4 to $8, $8 is now 0x1001000c
    # addi    $s0, $s0, -1	# decrement the loop counter
    #				  $16 goes from 2 to 1
    # bne     $0, $s0, loop	# loop back to label 'loop' when $0 is not equal to $s0
### Loop 3
    # lw      $t1, 0($t0)	# load the next value from address location, X+4 into register $t1
    #	      $9, 0($8)		  loads 0x7 into $9
    # addu    $s1, $s1, $t1	# add the next value to the running sum
    #	      $17, $17, $9	  adds $9 to $17, $17 is now 0x1
    # addi    $t0, $t0, 4 	# increment to the next address
    #				  adds 4 to $8, $8 is now 0x10010010
    # addi    $s0, $s0, -1	# decrement the loop counter
    #				  $16 goes from 1 to 0
    # bne     $0, $s0, loop	# loop back to label 'loop' when $0 is not equal to $s0

    sw      $s1, SUM 		# store the final total sum into address location 'SUM'
    #	    $1, 4097		  loads addr 4097 into $1
    #	    $17, 16($1)		  loads 1 into $17
    li      $v0, 10 		# syscall to exit cleanly from main only
    syscall			# this ends execution 
.end

# [-2]	    [-4]	[7]
# 0x10010004
# 0x10010004 = 268500996
# 268500996 + 32 * 4 = 268500996
# 0x1001000c = 268501004
# SUM = first byte of 0x10010010 in data segment
