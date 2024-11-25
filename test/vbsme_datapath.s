#  Fall 2024
#  Team Members:   Giuseppe Pongelupe Giacoia, Carson Keegan, Leo Dickinson 
#  % Effort    :   33%, 33%, 33%
#
# ECE369A,  
# 

########################################################################################################################
### data
########################################################################################################################
.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols  
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column

# test 0 For the 4x4 frame size and 2X2 window size
# small size for validation and debugging purpose
# The result should be 0, 2
asize0:  .word    4,  4,  2, 2    #i, j, k, l
frame0:  .word    0,  0,  1,  2, 
         .word    0,  0,  3,  4
         .word    0,  0,  0,  0
         .word    0,  0,  0,  0, 
window0: .word    1,  2, 
         .word    3,  4, 
# test 1 For the 16X16 frame size and 4X4 window size
# The result should be 12, 12
asize1:  .word    16, 16, 4, 4    #i, j, k, l
frame1:  .word    0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
         .word    1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
         .word    2, 3, 32, 1, 2, 3, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 
         .word    3, 4, 1, 2, 3, 4, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 
         .word    0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    0, 13, 26, 39, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
         .word    0, 14, 28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
         .word    0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6 
window1: .word    0, 1, 2, 3, 
         .word    1, 2, 3, 4, 
         .word    2, 3, 4, 5, 
         .word    3, 4, 5, 6 

# test 2 For the 16X16 frame size and a 4X8 window size
# The result should be 0, 4
asize2:  .word    16, 16, 4, 8    #i, j, k, l
frame2:  .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
         .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
         .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
         .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
         .word    0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 0, 0, 0, 0, 70,  75, 
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 0, 0, 0, 0, 84, 90, 
         .word    0, 4, 8, 8, 8, 8, 42, 49, 56, 63, 0, 0, 0, 0, 98, 105, 
         .word    0, 1, 8, 8, 8, 8, 48, 56, 64, 72, 0, 0, 0, 0, 112, 120, 
         .word    0, 1, 8, 8, 8, 8, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 8, 8, 8, 8, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
         .word    9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
         .word    9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6 
window2: .word    0, 0, 0, 0, 0, 0, 0, 0, 
         .word    0, 0, 0, 0, 0, 0, 0, 0, 
         .word    0, 0, 0, 0, 0, 0, 0, 0, 
         .word    0, 0, 0, 0, 0, 0, 0, 0

         
newline: .asciiz     "\n" 


########################################################################################################################
### main
########################################################################################################################

.text

.globl main

main: 
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address
         
    # Start test 1 
    ############################################################
    la      $a0, asize1     # 1st parameter: address of asize1[0]
    la      $a1, frame1     # 2nd parameter: address of frame1[0]
    la      $a2, window1    # 3rd parameter: address of window1[0] 
   
    jal     vbsme           # call function
    #jal print_result    # print results to console
    
    ############################################################
    # End of test 1   

   
    # Start test 2 
    ############################################################
    la      $a0, asize2     # 1st parameter: address of asize2[0]
    la      $a1, frame2     # 2nd parameter: address of frame2[0]
    la      $a2, window2    # 3rd parameter: address of window2[0] 
   
    jal     vbsme           # call function
    #jal print_result    # print results to console
    ############################################################
    # End of test 2   
                    
               

# vbsme.s 
# motion estimation is a routine in h.264 video codec that 
# takes about 80% of the execution time of the whole code
# given a frame(2d array, x and y dimensions can be any integer 
# between 16 and 64) where "frame data" is stored under "frame"  
# and a window (2d array of size 4x4, 4x8, 8x4, 8x8, 8x16, 16x8 or 16x16) 
# where "window data" is stored under "window" 
# and size of "window" and "frame" arrays are stored under "asize"

# - initially current sum of difference is set to a very large value
# - move "window" over the "frame" one cell at a time starting with location (0,0)
# - moves are based circular pattern 
# - for each move, function calculates  the sum of absolute difference (SAD) 
#   between the window and the overlapping block on the frame.
# - if the calculated sum of difference is LESS THAN the current sum of difference
#   then the current sum of difference is updated and the coordinate of the top left corner 
#   for that matching block in the frame is recorded. 

# for example SAD of two 4x4 arrays "window" and "block" shown below is 3  
# window         block
# -------       --------
# 1 2 2 3       1 4 2 3  
# 0 0 3 2       0 0 3 2
# 0 0 0 0       0 0 0 0 
# 1 0 0 5       1 0 0 4

# program keeps track of the window position that results 
# with the minimum sum of absolute difference. 
# after scannig the whole frame
# program returns the coordinates of the block with the minimum SAD
# in $v0 (row) and $v1 (col) 


# Sample Inputs and Output shown below:
# Frame:
#
#  0   1   2   3   0   0   0   0   0   0   0   0   0   0   0   0 
#  1   2   3   4   4   5   6   7   8   9  10  11  12  13  14  15 
#  2   3  32   1   2   3  12  14  16  18  20  22  24  26  28  30 
#  3   4   1   2   3   4  18  21  24  27  30  33  36  39  42  45 
#  0   4   2   3   4   5  24  28  32  36  40  44  48  52  56  60 
#  0   5   3   4   5   6  30  35  40  45  50  55  60  65  70  75 
#  0   6  12  18  24  30  36  42  48  54  60  66  72  78  84  90 
#  0   7  14  21  28  35  42  49  56  63  70  77  84  91  98 105 
#  0   8  16  24  32  40  48  56  64  72  80  88  96 104 112 120 
#  0   9  18  27  36  45  54  63  72  81  90  99 108 117 126 135 
#  0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 
#  0  11  22  33  44  55  66  77  88  99 110 121 132 143 154 165 
#  0  12  24  36  48  60  72  84  96 108 120 132   0   1   2   3 
#  0  13  26  39  52  65  78  91 104 117 130 143   1   2   3   4 
#  0  14  28  42  56  70  84  98 112 126 140 154   2   3   4   5 
#  0  15  30  45  60  75  90 105 120 135 150 165   3   4   5   6 

# Window:
#  0   1   2   3 
#  1   2   3   4 
#  2   3   4   5 
#  3   4   5   6 

# cord x = 12, cord y = 12 returned in $v0 and $v1 registers

.text
.globl  vbsme

# Your program must follow circular search pattern.  

# Preconditions:
#   1st parameter (a0) address of the first element of the dimension info (address of asize[0])
#   2nd parameter (a1) address of the first element of the frame array (address of frame[0][0])
#   3rd parameter (a2) address of the first element of the window array (address of window[0][0])
# Postconditions:	
#   result (v0) x coordinate of the block in the frame with the minimum SAD
#          (v1) y coordinate of the block in the frame with the minimum SAD


# Begin subroutine
vbsme:  
    li      $v0, 0              # reset $v0 and $V1
    li      $v1, 0

    # insert your code here
    lw $t0, 0($a0) # t0 = i 
    lw $t1, 4($a0) # t1 = j 
    lw $t2, 8($a0) # t2 = k
    lw $t3, 12($a0) # t3 = l
    
    add $s0, $zero, $zero # s0 = x = 0
    add $s1, $zero, $zero # s1 = y = 0
    
    add $s2, $zero, $zero # s2 = leftWall 0
    add $s3, $zero, $zero # s3 = roof = 0 
    sub $s4, $t1, $t3     # s4 = rightWall = j-l
    sub $s5, $t0, $t2     # s5 = flor = i-k
    
    li $s7, 0 # s7 = direction = 0
    li $t8, 0 # currIndex = 0;
    li $s6, 1000000 # s6 = "set to a very large value"
    li $t3, 0 #TO BE THE FINAL INDEX 
    # registers t0, t1, t2, t3 are now free
    
loop:
    # bgt $s2, $s4, loopOut # replaced with sub bgtz
    # bgt $s3, $s5, loopOut # if roof>flor replaced with sub bgtz
    sub $sp, $s2, $s4
    bgtz $sp, loopOut # if leftwall>rightWall exit loop
    sub $sp, $s3, $s5
    bgtz $sp, loopOut # if roof>flor
    #based on x and y calculate the current position
    # move $t8, $s0 # replaced with add
    add $t8, $zero, $s0

    lw $t1, 4($a0) # t1 = j 
    mul $t0, $s1, $t1
    add $t8, $t8, $t0 # currIndex = x+y*j
    # call function now to calculate the cell
    j calculate
back:
    # bge $t7, $s6, skip #skips if the found value is not a new minimum
    sub $sp, $t7, $s6
    bgez $sp, skip
    #move $s6, $t7
    add $s6, $zero, $t7
    # move $t3, $t8#NEW FINAL INDEX
    add $t3, $zero, $t8
skip: 
    #end of call to funciton
    beq $s7, $zero, direction0
    addi $sp, $zero, 1
    beq $s7, $sp, direction1
    addi $sp, $zero, 2
    beq $s7, $sp, direction2
    addi $sp, $zero, 3
    beq $s7, $sp, direction3

orange:
    j loop
    
direction0: 
    slt $t0, $s0, $s4 # check if x<rightWall
    beq $t0, $zero, direction0_change
    addi $s0, $s0, 1 #update x
    j orange

direction0_change:
    li $s7, 1 # sets direction as 1
    addi $s3, $s3, 1 # adds 1 to roof
    addi $s1, $s1, 1 #moves it down
    j orange
    
direction1:
    slt $t0, $s1, $s5 # check if y<floor
    beq $t0, $zero, direction1_change
    addi $s1, $s1, 1 #update y
    j orange
    
direction1_change: 
    li $s7, 2 # sets direction as 2
    addi $s4, $s4, -1 # subtracts 1 from right wall
    addi $s0, $s0, -1 #updates x
    j orange

direction2:
    # bgt $s0, $s2, direction2_move # check if x>leftWall
    sub $sp, $s0, $s2
    bgtz $sp, direction2_move
    li $s7, 3 # sets direction as 2
    addi $s5, $s5, -1 # subtracts 1 from flor
    addi $s1, $s1, -1
    j orange
    
direction2_move: 
    addi $s0, $s0, -1 #update x
    j orange
    
direction3:
    # bgt $s1, $s3, direction3_move # check if y>roof
    sub $sp, $s1, $s3
    bgtz $sp, direction3_move
    li $s7, 0 # sets direction as 0
    addi $s2, $s2, 1 # adds 1 to left wall
    addi $s0, $s0, 1
    j orange
    
direction3_move: 
    addi $s1, $s1, -1 #update y
    j orange
    
    
loopOut: 
    # here none of the previous stored values matter with the exception of t3
    lw $s0, 0($a0) # s0 = i 
    lw $s1, 4($a0) # s1 = j 
     #now we have to v0 = x = index % j (number of columns)
     #now we have to v1 = y = index // j 
    # move $s2, $t3
    add $s2, $zero, $t3
    li $s3, 0 #s2 = x, s3 = y
loopx:
    # blt $s2, $s1, exitx
    sub $sp, $s2, $s1
    bltz $sp, exitx
    sub $s2, $s2, $s1 #calculate temp -=j 
    addi $s3, $s3, 1
    j loopx
exitx:
    # move $v1, $s2
    add $v1, $zero, $s2
    # move $v0, $s3
    add $v0, $zero, $s3
    jr $ra
    
calculate: 
    lw $t1, 4($a0) # t1 = j 
    lw $t2, 8($a0) # t2 = k
    lw $t1, 12($a0) # t1 = l
    mul $t4, $t2, $t1 # i = k*l;
    lw $t1, 4($a0) # t1 = j 
    li $t5, 0 #index = 0;
    lw $t1, 12($a0) # t1 = l
    # move $t6, $t1 #rightCount = l
    add $t6, $zero, $t1
    lw $t1, 4($a0) # t1 = j 
    li $t7, 0 #sum = 0;
    li $t0, 0 #temp =0;
    # move $t9, $t8 # currIndex = w;
    add $t9, $zero, $t8
    # t2 are free to be used
calculateLoop: 
    # bge $t5, $t4, calculateLoopExit #if index >= i exit
    sub $sp, $t5, $t4
    bgez $sp, calculateLoopExit
    addi $sp, $zero, 4
    mul $t2, $t5, $sp # gets correct index as 4 bytes per word
    add $t2, $t2, $a2
    lw $t0, 0($t2) #temp = window[index]
    mul $t2, $t9, $sp
    add $t2, $t2, $a1
    lw $t2, 0($t2) #temp2 = grid[currIndex]
    sub $t0, $t0, $t2 #temp = window[index] - grid[currIndex]
    
    # Check if temp is negative
    li $t2, 0 
    # bge $t0, $t2, positive#go to greater than 0
    sub $sp, $t0, $t2
    bgez $sp, positive
    addi $sp, $zero, -1
    mul $t0, $t0, $sp
positive:
    add $t7, $t7, $t0 #sum +=temp
    
    #update currIndex
    addi $t9, $t9, 1 #currIndex +=1;
    addi $t6, $t6, -1 #rightCount -=1;
    
    bne $t6, $t2, notzero # skip if rightCount != 0
    lw $t1, 12($a0) # t1 = l
    sub $t9, $t9, $t1 #currIndex = currIndex - (l)
    lw $t1, 4($a0) # t1 = j 
    add $t9, $t9, $t1 # currIndex +=j
    lw $t1, 12($a0) # t1 = l
    # move $t6, $t1 #rightCount = l
    add $t6, $zero, $t1
    lw $t1, 4($a0) # t1 = j 
notzero: 
    addi $t5, $t5, 1 #index +=1
    j calculateLoop
    
calculateLoopExit: 
    j back # FIXME check if it returns correctly. 
