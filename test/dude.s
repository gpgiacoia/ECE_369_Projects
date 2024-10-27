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
nop
nop
nop
nop
nop
addi	$t1, $zero, 1
nop
nop
nop
nop
nop
sll $t1, $t1, 8
nop
nop
nop
nop
nop
sll $t1, $t1, 8
nop
nop
nop
nop
nop
addi	$t1, $t1, 1 #t1 should be 1 + 15 (0) + 1
nop
nop
nop
nop
nop
sh $t1, 4($t0) # should cut off to 15 (0) + 1
nop
nop
nop
nop
nop
lw $t3, 4($t0)  # showing the change on register 3
nop
nop
nop
nop
nop
addi $t2, $zero, 3 
nop
nop
nop
nop
nop
sll $t2, $t2, 7
nop
nop
nop
nop
nop
sll $t2, $t2, 8 # now t2 should be 11 + 15(0) + 1
nop
nop
nop
nop
nop
addi $t2, $t2, 1
nop
nop
nop
nop
nop
sw $t2, 8($t0) 
nop
nop
nop
nop
nop
lh $t5, 8($t0)  #  should cut off to 1 + 14 (0) + 1 but sign extended 1's to the left
nop
nop
nop
nop
nop
sh $t2, 12($t0) 
nop
nop
nop
nop
nop
lw $t4, 12($t0)  #  registers t4 and t5 should be equal because one stores half then loads word the other does the opposite
nop
nop
nop
nop
nop
j ARITHMETIC
nop
nop
nop
nop
nop

BYTES: 
addi $t6, $zero, 1
nop
nop
nop
nop
nop
sll $t6, $t6, 8 # t6 should be 256 0x100
nop
nop
nop
nop
nop
addi $t6, $t6, 3 #t6 should be 259 0x103 0b100000011
nop
nop
nop
nop
nop
sw $t6, 16($t0)
nop
nop
nop
nop
nop
lb $t7, 16($t0)  #  t7 should cut off to 3 decimal
nop
nop
nop
nop
nop
sb $t6, 20($t0) 
nop
nop
nop
nop
nop
lw $t8, 20($t0)  #  t8 should be the same as t7
nop
nop
nop
nop
nop
addi $t0, $zero, 75
nop
nop
nop
nop
nop
jal LOGICAL
# do more stuff here
nop
nop
nop
nop
nop
addi $t0, $zero, 100
nop
nop
nop
nop
nop
addi $t1, $zero, 100
nop
nop
nop
nop
nop
sub $t0, $t0, $t1
nop
nop
nop
nop
nop
beq $t0, $zero, END
nop
nop
nop
nop
nop

ARITHMETIC: 
addi $s0, $zero, 4
nop
nop
nop
nop
nop
addi $s1, $zero, 10
nop
nop
nop
nop
nop
mul $s2, $s1, $s0 #s2 should be 40 0x28
nop
nop
nop
nop
nop
sub $s3, $s0, $s1 #s3 should be -6 0xffff_fffa
nop
nop
nop
nop
nop
add $s4, $s3, $s2 #s4 should be 34 0x22
nop
nop
nop
nop
nop
j BYTES
nop
nop
nop
nop
nop

BEQZTEST:
or $s5, $zero, $zero # s5 should be 0
nop
nop
nop
nop
nop
ori $s6, $s3, 65535 # s6 should be -1 0xffff_ffff
nop
nop
nop
nop
nop
nor $s7, $s0, $s1 # s7 should be -15 0xffff_fff1
nop
nop
nop
nop
nop
xori $t8, $s3, 882 # t8 should be -888 0xffff_fc88
nop
nop
nop
nop
nop
sll $t8, $s3, 3	# t8 should be -48 0xffff_ffd0
nop
nop
nop
nop
nop
srl $t9, $s3, 1 #t9 should be 2147483646 7fff_fffd (filled in with 0 at left, turning it positive)
nop
nop
nop
nop
nop
addi $s6, $s6, 512 # s6 should be 511 0x1ff
nop
nop
nop
nop
nop
addi $s3, $s3, 80 # s3 should be 74 0x4a
nop
nop
nop
nop
nop
addi $s1, $s1, 10 # s1 should be 20 0x14
nop
nop
nop
nop
nop

LOGICAL: # do some stuff
andi $s5, $s3, -3 # s5 first should be -8 0xffff_fff8, then 72 0x48
nop # s3 = -6, then 74
nop
nop
nop
nop
and $s6, $s3, $s5 # s6 first should be -8 0xffff_fff8, then 72 0x48
nop
nop
nop
nop
nop
xor $s7, $s0, $s1 # s7 first should be 14 0xe, then 16 0x10
nop
nop
nop
nop
nop
slt $t8, $s7, $s6 # t8 first should be 0, then 1
nop
nop
nop
nop
nop
slti $t9, $s6, 0 # t9 should be 1, then 0
nop
nop
nop
nop
nop
bne $t9, $zero, BEQZTEST # branch on first loop / skip on second
nop
nop
nop
nop
nop
addi $t0, $zero, 164 # should be 0xa4
nop
nop
nop
nop
nop
jr $ra
nop
nop
nop
nop
nop

END:
addi $s7, $zero, 4919
nop
nop
nop
nop
nop
