.data 
    a: .word 1, 2, 3, 4, 5
    b: .word 6, 7, 8, 9, 10
    output: .asciiz "The dot product is: "
    
.text 
main:
    # x0-x4, x10-x17 are prohibited.
    li x5 0 # i=0
    li x6 0 # sop=0
    li x7 5 # x7=5
    la x8 a # x8 = base address of a
    la x9 b # x9 = base address of b
    li x23 4
    j loop
 
 loop:
    bge x5 x7 exit
    #calculate offset
    mul x18 x5 x23 # x18 = i*4
    add x20 x18 x8 #add offset of array a to x20
    add x21 x18 x9 #add offset of array b to x21
    lw x24 0(x20) # x24 = a[i]
    lw x25 0(x21) # x25 = b[i]
    mul x22 x24 x25 # x22=a[i]*b[i]
    add x6 x6 x22 #sop = a[i]*b[i]
    li x22 0 #reset x22 
    addi x5 x5 1 # i = i + 1
    j loop
    
    
 exit:
    la a1 output
    addi a0 x0 4
    ecall
    add a1 x6 zero
    li a0 1
    ecall