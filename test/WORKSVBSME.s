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
         .word    0,  0,  3,  4,
         .word    0,  0,  0,  0,
         .word    0,  0,  0,  0
window0: .word    1,  2, 
         .word    3,  4
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
    la      $a0, asize0     # 1st parameter: address of asize1[0]
    la      $a1, frame0    # 2nd parameter: address of frame1[0]
    la      $a2, window0    # 3rd parameter: address of window1[0] 
   
    jal     vbsme           # call function

    addi $k0, $t0, 20
    
    ############################################################
    # End of test 1   

   
    # Start test 2 
    ############################################################
    la      $a0, asize2     # 1st parameter: address of asize2[0]
    la      $a1, frame2     # 2nd parameter: address of frame2[0]
    la      $a2, window2    # 3rd parameter: address of window2[0] 
   
    jal     vbsme           # call function
    ############################################################
    # End of test 2   
                    

.text
.globl  vbsme


vbsme:  
    addi $k0, $zero, -1
    addi $v0, $zero, 0              # reset $v0 and $V1
    addi $v1, $zero, 0

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
    
    addi $s7, $zero, 0 # s7 = direction = 0
    addi $t8, $zero, 0 # currIndex = 0;
    addi $s6, $zero, 32767 # s6 = "set to a very large value"
    addi $t3, $zero, 0 #TO BE THE FINAL INDEX 
    # registers t0, t1, t2, t3 are now free
    
loop: 
    #bgt $s2, $s4, loopOut # if leftwall>rightWall exit loop
    sub $a3, $s2, $s4      # Calculate $s2 - $s4
    bgtz $a3, loopOut       # If the result is greater than 0, branch to loopOut

    #bgt $s3, $s5, loopOut # if roof>flor
    #based on x and y calculate the current position
    sub $a3, $s3, $s5      # Calculate $s3 - $s5
    bgtz $a3, loopOut       # If the result is greater than 0 (roof > floor), branch to loopOut

    add $t8, $zero, $s0
    lw $t1, 4($a0) # t1 = j 
    mul $t0, $s1, $t1
    add $t8, $t8, $t0 # currIndex = x+y*j
    # call function now to calculate the cell
    j calculate
back:
    #bge $t7, $s6, skip #skips if the found value is not a new minimum
    sub $a3, $t7, $s6      # Calculate $t7 - $s6
    bgez $a3, skip         # If $t7 >= $s6, branch to skip

    add $s6, $zero, $t7
    add $t3, $zero, $t8#NEW FINAL INDEX
skip: 
    #end of call to funciton
    addi $a3, $zero, 0
    beq $s7, $a3, direction0
    addi $a3, $zero, 1

    beq $s7, $a3, direction1
    addi $a3, $zero, 2

    beq $s7, $a3, direction2
    addi $a3, $zero, 3
    beq $s7, $a3, direction3

    
direction0: 
    slt $t0, $s0, $s4 # check if x<rightWall
    beq $t0, $zero, direction0_change
    addi $s0, $s0, 1 #update x
    j loop

direction0_change:
    li $s7, 1 # sets direction as 1
    addi $s3, $s3, 1 # adds 1 to roof
    addi $s1, $s1, 1 #moves it down
    j loop
    
direction1:
    slt $t0, $s1, $s5 # check if y<floor
    beq $t0, $zero, direction1_change
    addi $s1, $s1, 1 #update y
    j loop
    
direction1_change: 
    li $s7, 2 # sets direction as 2
    addi $s4, $s4, -1 # subtracts 1 from right wall
    addi $s0, $s0, -1 #updates x
    j loop

direction2:
    #bgt $s0, $s2, direction2_move # check if x>leftWall
    sub $a3, $s0, $s2      # Calculate $s0 - $s2
    bgtz $a3, direction2_move # If $s0 > $s2, branch to direction2_move

    addi $s7, $zero, 3 # sets direction as 2
    addi $s5, $s5, -1 # subtracts 1 from flor
    addi $s1, $s1, -1
    j loop
    
direction2_move: 
    addi $s0, $s0, -1 #update x
    j loop
    
direction3:
    #bgt $s1, $s3, direction3_move # check if y>roof
    sub $a3, $s1, $s3       # Calculate $s1 - $s3
    bgtz $a3, direction3_move # If $s1 > $s3, branch to direction3_move

    addi $s7, $zero, 0 # sets direction as 0
    addi $s2, $s2, 1 # adds 1 to left wall
    addi $s0, $s0, 1
    j loop
    
direction3_move: 
    addi $s1, $s1, -1 #update y
    j loop
    
    
loopOut: 
    # here none of the previous stored values matter with the exception of t3
    lw $s0, 0($a0) # s0 = i 
    lw $s1, 4($a0) # s1 = j 
     #now we have to v0 = x = index % j (number of columns)
     #now we have to v1 = y = index // j 
    move $s2, $t3
    li $s3, 0 #s2 = x, s3 = y
loopx:
    #blt $s2, $s1, exitx
    sub $a3, $s2, $s1      # Calculate $s2 - $s1
    bltz $a3, exitx        # If $s2 < $s1, branch to exitx

    sub $s2, $s2, $s1 #calculate temp -=j 
    addi $s3, $s3, 1
    j loopx
exitx:
    move $v1, $s2
    move $v0, $s3
    jr $ra
    
calculate: 
    lw $t1, 4($a0) # t1 = j 
    lw $t2, 8($a0) # t2 = k
    lw $t1, 12($a0) # t1 = l
    mul $t4, $t2, $t1 # i = k*l;
    lw $t1, 4($a0) # t1 = j 
    li $t5, 0 #index = 0;
    lw $t1, 12($a0) # t1 = l
    move $t6, $t1 #rightCount = l
    lw $t1, 4($a0) # t1 = j 
    li $t7, 0 #sum = 0;
    li $t0, 0 #temp =0;
    move $t9, $t8 # currIndex = w;
    # t2 are free to be used
calculateLoop: 
    #bge $t5, $t4, back #if index >= i exit
    sub $a3, $t5, $t4      # Calculate $t5 - $t4
    bgez $a3, back         # If $t5 >= $t4, branch to back
    addi $a3, $zero, 4
    mul $t2, $t5, $a3 # gets correct index as 4 bytes per word
    add $t2, $t2, $a2
    lw $t0, 0($t2) #temp = window[index]
    addi $a3, $zero, 4
    mul $t2, $t9, $a3
    add $t2, $t2, $a1
    lw $t2, 0($t2) #temp2 = grid[currIndex]
    sub $t0, $t0, $t2 #temp = window[index] - grid[currIndex]
    
    # Check if temp is negative
    li $t2, 0 
    #bge $t0, $t2, positive#go to greater than 0
    sub $t1, $t0, $t2      # Calculate $t0 - $t2
    bgez $t1, positive      # If $t0 >= $t2, branch to positive
    addi $a3, $zero, -1
    mul $t0, $t0, $a3

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
    move $t6, $t1 #rightCount = l
    lw $t1, 4($a0) # t1 = j 
notzero: 
    addi $t5, $t5, 1 #index +=1
    j calculateLoop
    




    
    
    
   
