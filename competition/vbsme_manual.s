.text
main:
        la $2, asize1
        la $3, frame1
        la $4, window1

        lw $5, 0($2)         # frame_y
        lw $6, 4($2)         # frame_x
        lw $7, 8($2)         # window_y
        lw $8, 12($2)        # window_x

        sub $9, $5, $7           # frame_y - window_y
        sub $10, $6, $8          # frame_x - window_x

        add $11, $zero, $zero    # y
        add $12, $zero, $zero    # x
        add $13, $zero, $zero    # i
        add $14, $zero, $zero    # j

        addi $23, $zero, 16000    # min_sad
        add $24, $zero, $zero    # min_y
        add $25, $zero, $zero    # min_x

        jal vbsme
        j loop

sad:
loop_i:
loop_j:
        add $15, $11, $13       # temp0 = y + i
        add $16, $12, $14       # temp1 = x + j
        mul $17, $15, $6        # temp2 = y * frame_x
        add $18, $17, $16       # frame_index = temp2 + temp1
        lw $15, 0($18)          # temp0 = frame[frame_index]

        mul $16, $13, $8        # temp1 = i * window_x
        add $18, $16, $14       # window_index = temp1 + j
        lw $17, 0($18)          # temp2 = window[window_index]

        sub $19, $15, $17       # SAD = temp0 - temp2
        bgez $19, positive      # if (SAD >= 0) j positive
        addi $15, $zero, -1     # temp0 = -1
        mul $19, $19, $15       # SAD *= -1
positive:
        addi $14, $14, 1        # j++
        bne $14, $8, loop_j     # if j != window_x
        addi $13, $13, 1        # i++
        bne $13, $7, loop_i     # if i != window_y
        jr $ra

vbsme:
loop_y:
        addi $11, $11, 1        # y++
loop_x:
        jal sad
        slt $15, $19, $23       # temp0 = SAD < min_sad
        beq $15, $zero, not_min # if (temp0 == 0) j not_min
        add $23, $zero, $19     # min_sad = SAD
        add $24, $zero, $11    # min_y = y
        add $25, $zero, $12    # min_x = x

not_min:
        addi $12, $12, 1        # x++
        bne $12, $10, loop_x    # if x != frame_x - window_x
        bne $11, $9, loop_y     # if y != frame_y - window_y
        jr $ra

loop:
        j loop

.data
asize1:  .word    16, 16, 8, 4    #i, j, k, l
frame1:  .word    7, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
         .word    7, 8, 8, 8, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
         .word    7, 8, 8, 8, 2, 8, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 
         .word    7, 8, 8, 8, 8, 8, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 
         .word    0, 4, 8, 8, 8, 8, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
         .word    0, 5, 8, 8, 8, 8, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75, 
         .word    0, 6, 8, 8, 8, 8, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90, 
         .word    0, 4, 8, 8, 8, 8, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105, 
         .word    0, 1, 8, 8, 8, 8, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120, 
         .word    0, 1, 8, 8, 8, 8, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135, 
         .word    0, 10, 8, 8, 8, 8, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165, 
         .word    9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3, 
         .word    9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4, 
         .word    9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5, 
         .word    9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6 
window1: .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8, 
         .word    8, 8, 8, 8
