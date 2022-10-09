.data 
    arr1:    .word 55,44,33,22,11 
    #arr1:    .word 44,11,44,66,55
    #arr1:    .word 11,55,33,22,55
    arrSize: .word 5
    target:   .word 44
    Lbracket: .string "["
    Rbracket: .string "]"
    Blank: .string " "
    
.text

main:
    la a0, Lbracket # a0 is return value register
    li a7,4         # Print string by specifiy the value of a7 register t0 4 
    ecall           # First print "["
    
    li   t5,0
    
    addi  s1,x0,0    # Number of sorted elements
    addi  s2,x0,0    # Outer_loop counter
    
    
    la    t2,arrSize # Load base address of arrSize
    lw    t2,0(t2)   # Load arrSize to t2

    addi  t2,t2,-1   # vector length and counter of Find

 

Outer_Loop:
    la    a2,arr1    # base address of array 
    lw    t0,0(a2)   # t0=arr[j]
    
    sub   s3,t2,s1
    
Inner_Loop:
    lw    t1,4(a2)        # t1=arr[j+1]
    blt   t0,t1,NoSwap    # If arr[j]<arr[j+1], then don't swap
    
    sw    t1,0(a2)           # Swap(arr[j],arr[j+1])
    sw    t0,4(a2)           # Swap(arr[j],arr[j+1])
    
NoSwap:
    bgt   t0,t1,Skip

    
    add   t0,t1,x0
    
Skip:
    addi  a2,a2,4
    addi  s3,s3,-1
    
    bne   s3,x0,Inner_Loop
    
Inner_End:
    addi  s1,s1,1
    
    blt s1,t2,Outer_End
    
Outer_End:
    addi s2,s2,1
    bne  s2,t2,Outer_Loop
    
    la   t3,target
    lw   t3,0(t3)    #target 

Find:
    #li   t6,0 
    lw   t4,-4(a2)    # get the first sorted vector element
    addi a2,a2,4      # get the nexr element of sorted vector
    
    beq  t3,t4,Print  # if target=element of vector, then print the index 
    
    
    addi t5,t5,1      # index+1
    
    beq  t5,t2,End    # if the index greater than of equal to arrSize, then end the Find and print "]"
    bgt  t5,t2,End    #
    j Find


Print:
    
    
    add a0, t5, x0 # return value
    li a7, 1 # print integer
    ecall    
    
    la a0, Blank #a0 is return value register
    li a7,4 # print string by specifiy the value of a7 register t0 4 
    ecall   
    
    addi t5,t5,1 
    j    Find
     
End:
    la a0, Rbracket #a0 is return value register
    li a7,4 # print string by specifiy the value of a7 register t0 4 
    ecall   
    nop
    
    
    
    
    
    
    
    
    
    
    
    