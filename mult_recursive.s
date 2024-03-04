.text 
main: 
    #pass the first argument to a0
    #pass the second argument to a1
    addi a0 zero 110
    addi a1 zero 50
    jal mult
    
    #print int
    mv a1 a0 #by convention the return value is always in a0
    addi a0 zero 1
    ecall
    
    #exit cleanly
    addi a0 x0 10
    ecall

mult:    
    #base case
    #compare a1 with 1, if the two are equal then exit the mult function
    addi t0 x0 1
    beq a1 t0 exit_base_case
    
    addi sp sp -4
    sw ra 0(sp)
    
    #revursive case
    #pass the first argument to a0
    #pass the second argument to a1
    addi sp sp -4
    sw a0 0(sp)
    addi a1 a1 -1
    jal mult
    # by convention he result is in a0
    #restore a0 and a1 on to the stack
    lw t1 0(sp)
    addi sp sp 4
    add a0 a0 t1
    
    lw ra 0(sp)
    addi sp sp 4
    jr ra
    
 
exit_base_case:
    jr ra
    