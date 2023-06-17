        .data
x:      .word 0
y:      .word 2
z:      .word 4

        .text
        lw $t0, y
        lw $t1, z
        mult $t0 , $t1
        mfhi $t1
        sw $t0, x

        lw $t0, x
        div $t0, 4
        mflo
        sw $t0, x

        lw $a0, y
        addi $v0, $t0, 5
        syscall