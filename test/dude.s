.data
# Define data memory for testing
N:      .word 3               # N: loop count
X:      .word -2, -4, 7       # X: array elements
SUM:    .word 0               # SUM: stores final sum
str:    .asciiz "The sum of the array is = "

.text
.globl main                   # Define 'main' globally

main:	
addi	$t0, $zero, 0





addi	$t1, $zero, 1





sll $t1, $t1, 8





sll $t1, $t1, 8





addi	$t1, $t1, 1 #t1 should be 1 + 15 (0) + 1





sh $t1, 4($t0) # should cut off to 15 (0) + 1





lw $t3, 4($t0)  # showing the change on register 3





addi $t2, $zero, 3 





sll $t2, $t2, 7





sll $t2, $t2, 8 # now t2 should be 11 + 15(0) + 1





addi $t2, $t2, 1





sw $t2, 8($t0) 





lh $t5, 8($t0)  #  should cut off to 1 + 14 (0) + 1 but sign extended 1's to the left





sh $t2, 12($t0) 





lw $t4, 12($t0)  #  registers t4 and t5 should be equal because one stores half then loads word the other does the opposite





j ARITHMETIC






BYTES: 
addi $t6, $zero, 1





sll $t6, $t6, 8 # t6 should be 256 0x100





addi $t6, $t6, 3 #t6 should be 259 0x103 0b100000011





sw $t6, 16($t0)





lb $t7, 16($t0)  #  t7 should cut off to 3 decimal





sb $t6, 20($t0) 





lw $t8, 20($t0)  #  t8 should be the same as t7





addi $t0, $zero, 75





jal LOGICAL
# do more stuff here





addi $t0, $zero, 100





addi $t1, $zero, 100





sub $t0, $t0, $t1





beq $t0, $zero, END






ARITHMETIC: 
addi $s0, $zero, 4





addi $s1, $zero, 10





mul $s2, $s1, $s0 #s2 should be 40 0x28





sub $s3, $s0, $s1 #s3 should be -6 0xffff_fffa





add $s4, $s3, $s2 #s4 should be 34 0x22





j BYTES






BEQZTEST:
or $s5, $zero, $zero # s5 should be 0





ori $s6, $s3, 65535 # s6 should be -1 0xffff_ffff





nor $s7, $s0, $s1 # s7 should be -15 0xffff_fff1





xori $t8, $s3, 882 # t8 should be -888 0xffff_fc88





sll $t8, $s3, 3	# t8 should be -48 0xffff_ffd0





srl $t9, $s3, 1 #t9 should be 2147483646 7fff_fffd (filled in with 0 at left, turning it positive)





addi $s6, $s6, 512 # s6 should be 511 0x1ff





addi $s3, $s3, 80 # s3 should be 74 0x4a





addi $s1, $s1, 10 # s1 should be 20 0x14






LOGICAL: # do some stuff
andi $s5, $s3, -3 # s5 first should be -8 0xffff_fff8, then 72 0x48
 # s3 = -6, then 74




and $s6, $s3, $s5 # s6 first should be -8 0xffff_fff8, then 72 0x48





xor $s7, $s0, $s1 # s7 first should be 14 0xe, then 16 0x10





slt $t8, $s7, $s6 # t8 first should be 0, then 1





slti $t9, $s6, 0 # t9 should be 1, then 0





bne $t9, $zero, BEQZTEST # branch on first loop / skip on second





addi $t0, $zero, 164 # should be 0xa4





jr $ra






END:
addi $s7, $zero, 4919





