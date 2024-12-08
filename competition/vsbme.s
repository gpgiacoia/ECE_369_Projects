.data
$LC0:
        .word   7
        .word   8
        .word   8
        .word   8
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   0
        .word   7
        .word   8
        .word   8
        .word   8
        .word   4
        .word   5
        .word   6
        .word   7
        .word   8
        .word   9
        .word   10
        .word   11
        .word   12
        .word   13
        .word   14
        .word   15
        .word   7
        .word   8
        .word   8
        .word   8
        .word   2
        .word   8
        .word   12
        .word   14
        .word   16
        .word   18
        .word   20
        .word   22
        .word   24
        .word   26
        .word   28
        .word   30
        .word   7
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   18
        .word   21
        .word   24
        .word   27
        .word   30
        .word   33
        .word   36
        .word   39
        .word   42
        .word   45
        .word   0
        .word   4
        .word   8
        .word   8
        .word   8
        .word   8
        .word   24
        .word   28
        .word   32
        .word   36
        .word   40
        .word   44
        .word   48
        .word   52
        .word   56
        .word   60
        .word   0
        .word   5
        .word   8
        .word   8
        .word   8
        .word   8
        .word   30
        .word   35
        .word   40
        .word   45
        .word   50
        .word   55
        .word   60
        .word   65
        .word   70
        .word   75
        .word   0
        .word   6
        .word   8
        .word   8
        .word   8
        .word   8
        .word   36
        .word   42
        .word   48
        .word   54
        .word   60
        .word   66
        .word   72
        .word   78
        .word   84
        .word   90
        .word   0
        .word   4
        .word   8
        .word   8
        .word   8
        .word   8
        .word   42
        .word   49
        .word   56
        .word   63
        .word   70
        .word   77
        .word   84
        .word   91
        .word   98
        .word   105
        .word   0
        .word   1
        .word   8
        .word   8
        .word   8
        .word   8
        .word   48
        .word   56
        .word   64
        .word   72
        .word   80
        .word   88
        .word   96
        .word   104
        .word   112
        .word   120
        .word   0
        .word   1
        .word   8
        .word   8
        .word   8
        .word   8
        .word   54
        .word   63
        .word   72
        .word   81
        .word   90
        .word   99
        .word   108
        .word   117
        .word   126
        .word   135
        .word   0
        .word   10
        .word   8
        .word   8
        .word   8
        .word   8
        .word   60
        .word   70
        .word   80
        .word   90
        .word   100
        .word   110
        .word   120
        .word   130
        .word   140
        .word   150
        .word   0
        .word   11
        .word   22
        .word   33
        .word   44
        .word   55
        .word   66
        .word   77
        .word   88
        .word   99
        .word   110
        .word   121
        .word   132
        .word   143
        .word   154
        .word   165
        .word   9
        .word   9
        .word   9
        .word   9
        .word   48
        .word   60
        .word   72
        .word   84
        .word   96
        .word   108
        .word   120
        .word   132
        .word   0
        .word   1
        .word   2
        .word   3
        .word   9
        .word   9
        .word   9
        .word   9
        .word   52
        .word   65
        .word   78
        .word   91
        .word   104
        .word   114
        .word   130
        .word   143
        .word   1
        .word   2
        .word   3
        .word   4
        .word   9
        .word   9
        .word   9
        .word   9
        .word   56
        .word   70
        .word   84
        .word   98
        .word   112
        .word   126
        .word   140
        .word   154
        .word   2
        .word   3
        .word   4
        .word   5
        .word   9
        .word   9
        .word   9
        .word   9
        .word   60
        .word   75
        .word   90
        .word   105
        .word   120
        .word   135
        .word   150
        .word   165
        .word   3
        .word   4
        .word   5
        .word   6
$LC1:
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
        .word   8
.text
main:
        la     $2, $LC0       # tmp199, 
        addi   $sp, $sp, -1216  #, , 
        li      $3, 16000                    # 0x3e80         # tmp198, 
        addi   $4, $2, 1024     # tmp202,  tmp200, 
        sw      $3, 1192($sp)         # tmp198,  min_sad
        sw      $31, 1212($sp)        #, 
        sw      $0, 1200($sp)         #,  min_x
        sw      $0, 1196($sp)         #,  min_y
        addi   $3, $sp, 40      # tmp226, , 
$L29:
        lw      $8, 0($2)             # tmp203, 
        lw      $7, 4($2)             # tmp204, 
        lw      $6, 8($2)             # tmp205, 
        lw      $5, 12($2)          # tmp206, 
        addi   $2, $2, 16       # tmp200,  tmp200, 
        sw      $8, 0($3)     # tmp203, 
        sw      $7, 4($3)     # tmp204, 
        sw      $6, 8($3)     # tmp205, 
        sw      $5, 12($3)    # tmp206, 
        addi   $3, $3, 16       # tmp201,  tmp201, 
        bne     $2, $4, $L29         #,  tmp200,  tmp202, 
        la     $2, $LC1       # tmp207, 
        addi   $3, $sp, 1064    # tmp227, , 
        addi   $4, $2, 128      # tmp210,  tmp208, 
$L30:
        lw      $8, 0($2)             # tmp211, 
        lw      $7, 4($2)             # tmp212, 
        lw      $6, 8($2)             # tmp213, 
        lw      $5, 12($2)          # tmp214, 
        addi   $2, $2, 16       # tmp208,  tmp208, 
        sw      $8, 0($3)     # tmp211, 
        sw      $7, 4($3)     # tmp212, 
        sw      $6, 8($3)     # tmp213, 
        sw      $5, 12($3)    # tmp214, 
        addi   $3, $3, 16       # tmp209,  tmp209, 
        bne     $2, $4, $L30         #,  tmp208,  tmp210, 
        addi   $2, $sp, 1192    # tmp215, , 
        sw      $2, 32($sp)   # tmp215, 
        addi   $2, $sp, 1196    # tmp216, , 
        sw      $2, 28($sp)   # tmp216, 
        addi   $2, $sp, 1200    # tmp217, , 
        sw      $2, 24($sp)   # tmp217, 
        addi   $2, $sp, 1064    # tmp228, , 
        sw      $2, 20($sp)   # tmp228, 
        addi   $2, $sp, 40      # tmp229, , 
        sw      $2, 16($sp)   # tmp229, 
        li      $7, 4                        # 0x4    #, 
        li      $6, 8                        # 0x8    #, 
        li      $5, 16                 # 0x10   #, 
        li      $4, 16                 # 0x10   #, 
        jal     vbsme      #
        lw      $2, 1200($sp)                 # min_x,  min_x
        lw      $3, 1196($sp)                 # min_y,  min_y
        lw      $4, 1192($sp)                 # min_sad,  min_sad
        add $9,  $zero,  $2        # min_x
add $10,  $zero,  $3       # min_y
add $11,  $zero,  $4       # min_sad


vbsme:
        addi   $sp, $sp, -32    #, , 
        sw      $22, 24($sp)  #, 
        sub    $22, $4, $6        # _50,  tmp247,  window_y
        sw      $21, 20($sp)  #, 
        sw      $20, 16($sp)  #, 
        sw      $18, 8($sp)   #, 
        sw      $16, 0($sp)   #, 
        lw      $18, 52($sp)    # window,  window
        lw      $20, 56($sp)    # min_x,  min_x
        lw      $21, 60($sp)    # min_y,  min_y
        lw      $16, 64($sp)    # min_sad,  min_sad
        sw      $23, 28($sp)  #, 
        sw      $19, 12($sp)  #, 
        sw      $17, 4($sp)   #, 
        bltz    $22, $L1
        nop
        sub    $25, $5, $7        # _55,  frame_x,  window_x
        bltz    $25, $L1
        nop
        lw      $17, 48($sp)    # ivtmp.54,  frame
        move    $12, $6   # window_y,  tmp249
        sll     $11, $5, 2   # _100,  frame_x, 
        addi   $22, $22, 1      # _104,  _50, 
        sll     $13, $7, 2   # _58,  window_x, 
        move    $19, $0   # y, 
        addi   $25, $25, 1      # _49,  _55, 
$L4:
        blez    $12, $L26
        nop
        move    $14, $0   # x, 
        move    $15, $0   # ivtmp.50, 
$L13:
        lw      $24, 0($16)       # *min_sad_18(D),  *min_sad_18(D)
$L9:
        add    $9, $17, $15       # ivtmp.45,  ivtmp.54,  ivtmp.50
        move    $8, $18   # ivtmp.46,  window
        move    $6, $0    # sad, 
        blez    $7, $L5
        nop
        move    $10, $0   # i, 
$L7:
        move    $5, $8    # ivtmp.40,  ivtmp.46
        move    $4, $9    # ivtmp.39,  ivtmp.45
        move    $3, $0    # j, 
$L6:
        lw      $2, 0($5)             # MEM <int> [(int[0:D.1919] *)_83],  MEM <int> [(int[0:D.1919] *)_83]
        lw      $23, 0($4)          # MEM <int> [(int[0:D.1914] *)_84],  MEM <int> [(int[0:D.1914] *)_84]
        addi   $3, $3, 1        # j,  j, 
        sub    $23, $23, $2       # _40,  MEM <int> [(int[0:D.1914] *)_84],  MEM <int> [(int[0:D.1919] *)_83]
        sra     $2, $23, 31  # temp,  _40, 
        xor     $23, $23, $2         # x,  _40,  temp
        andi    $2, $2, 0x1        # _43,  temp, 
        add    $2, $2, $23        # x_44,  _43,  x
        add    $6, $6, $2         # sad,  sad,  x_44
        addi   $4, $4, 4        # ivtmp.39,  ivtmp.39, 
        addi   $5, $5, 4        # ivtmp.40,  ivtmp.40, 
        bne     $7, $3, $L6
        nop
        addi   $10, $10, 1      # i,  i, 
        add    $9, $9, $11        # ivtmp.45,  ivtmp.45,  _100
        add    $8, $8, $13        # ivtmp.46,  ivtmp.46,  _58
        bne     $12, $10, $L7
        nop
$L5:
        slt     $2, $6, $24  # tmp243,  sad,  *min_sad_18(D)
        bne     $2, $0, $L8
        nop
        addi   $14, $14, 1      # x,  x, 
        addi   $15, $15, 4      # ivtmp.50,  ivtmp.50, 
        bne     $14, $25, $L9
        nop
$L10:
        addi   $19, $19, 1      # y,  y, 
        add    $17, $17, $11      # ivtmp.54,  ivtmp.54,  _100
        bne     $19, $22, $L4
        nop
$L1:
        lw      $23, 28($sp)    #, 
        lw      $22, 24($sp)    #, 
        lw      $21, 20($sp)    #, 
        lw      $20, 16($sp)    #, 
        lw      $19, 12($sp)    #, 
        lw      $18, 8($sp)       #, 
        lw      $17, 4($sp)       #, 
        lw      $16, 0($sp)       #, 
        addi   $sp, $sp, 32     #, , 
        jr      $31
        nop
$L8:
        sw      $6, 0($16)    # sad,  *min_sad_18(D)
        sw      $14, 0($20)   # x,  *min_x_20(D)
        addi   $14, $14, 1      # x,  x, 
        sw      $19, 0($21)   # y,  *min_y_22(D)
        addi   $15, $15, 4      # ivtmp.50,  ivtmp.50, 
        bne     $25, $14, $L13
        nop
        addi   $19, $19, 1      # y,  y, 
        add    $17, $17, $11      # ivtmp.54,  ivtmp.54,  _100
        bne     $19, $22, $L4
        nop
        j $L1
        nop
$L26:
        lw      $24, 0($16)       # *min_sad_18(D),  *min_sad_18(D)
        move    $2, $0    # x, 
$L14:
        bgtz    $24, $L11
        nop
$L27:
        addi   $2, $2, 1        # x,  x, 
        beq     $25, $2, $L10
        nop
        blez    $24, $L27
        nop
$L11:
        sw      $0, 0($16)    #,  *min_sad_18(D)
        sw      $2, 0($20)    # x,  *min_x_20(D)
        addi   $2, $2, 1        # x,  x, 
        sw      $19, 0($21)   # y,  *min_y_22(D)
        beq     $25, $2, $L10
        nop
        lw      $24, 0($16)       # *min_sad_18(D),  *min_sad_18(D)
        j $L14
        nop


$L31:
        j $L31   #
loop:
$L36:
        j $L36
        nop
