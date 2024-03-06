.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
print_text: .asciiz "The dot product is: "

.text
main:
    # a0 = a, a1 = b, a2 = size
    la a0 a # Load address of array1 into a0
    la a1 b # Load address of array1 into a1
    addi a2 x0 5 # Initialize size to 5
    # Call the dot_product function
    jal dot_product 
    
    j exit

dot_product:
    # Reserve space on the stack
    addi sp sp -16 # Allocate 16 bytes on the stack for 4 integers.
    
    # Save registers on the stack
    sw ra 0(sp) 
    sw a0 4(sp) 
    sw a1 8(sp) 
    sw a2 12(sp) 
    
    # Check for base case
    addi t0 x0 1 # t0 = temporary 1
    bne a2 t0 callback # call function recursively

    # Base case: Calculate dot product
    addi sp sp 16 # Reset stack pointer
    lw t1 0(a0) # a[0]
    lw t2 0(a1) # b[0]
    mul a0 t1 t2 # a[0]*b[0]
    jr ra # Return to caller
    
callback:
    # Recursive case: Update pointers and size, and make recursive call
    addi a0 a0 4 # a + 1
    addi a1 a1 4 # b + 1
    addi a2 a2 -1 # size - 1
    jal dot_product
    
    # Restore registers from the stack
    lw ra 0(sp) # load ra
    lw t0 4(sp) # load t0 = a
    lw t1 8(sp) # load t1 = b
    lw t2 12(sp) # load t2 = size
    addi sp sp 16 # Reset stack pointer
    
    # Calculate dot product
    lw t3 0(t0) # load value of a[0]
    lw t4 0(t1) # load value of b[0]
    mul t5 t3 t4 # a[0]*b[0] 
    add a0 a0 t5 
    jr ra
    
exit:
    mv t0, a0            # Move dot product to t0

    # Print dot product
    addi a0, x0, 4       # Service code for print integer
    la a1, print_text # Load address of print message
    ecall                # Execute system call to print message

    mv a1, t0            # Move dot product to a1
    addi a0, x0, 1       # Service code for print integer
    ecall                # Execute system call to print dot product

    addi a0, x0, 10      # Service code for exit
    ecall                # Execute system call to exit