.data 
    arr1:    .word 55,44,33,22,11  
    #arr2:    .word 44,44,44,44,44
    #arr3:    .word 11,55,33,22,55
    #arr4:    .word 10,9,8,7,6,5,4,3,2,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2

    arrSize: .word 5
    #arrSize2:.word 35
    target:   .word 1 
    Lbracket: .string "["
    Rbracket: .string "]"
    Blank: .string " "
    
.text

main:
    la a0, Lbracket # a0 is return value register
    li a7,4         # Print string by specifiy the value of a7 register t0 4 
    ecall           # First print "["
    
    li   t5,0
    
    addi  s1,x0,0    # Number of sorted elements(Outer_Loop counter)
    addi  s3,x0,0    # is equal to 1 if target was finded in sorted vector
    
    
    la    t2,arrSize # Load base address of arrSize
    lw    t2,0(t2)   # Load arrSize to t2 
    addi  t2,t2,-1   # vector length and counter of Find

 

Outer_Loop:
    la    a2,arr1    # base address of array 
    lw    t0,0(a2)   # t0=arr[j]
    
    sub   s2,t2,s1   # Inner_Loop counter, inner do arrSize - i times
    
Inner_Loop:
    lw    t1,4(a2)        # t1=arr[j+1]
    blt   t0,t1,NoSwap    # If arr[j]<arr[j+1], then don't swap
     
    sw    t1,0(a2)           # Swap(arr[j],arr[j+1])
    sw    t0,4(a2)           # Swap(arr[j],arr[j+1])
    
NoSwap:    # Let bigger number between t0,t1 in t0
    
    bgt   t0,t1,Skip    # If t0 is bigger, then keep t0 the same
    add   t0,t1,x0      # If t1 is bigger, then let t0 = t1
    
Skip:
    addi  a2,a2,4    #next element of vector
    addi  s2,s2,-1   
    
    bne   s2,x0,Inner_Loop    # If s3=0, means that one Inner_Loop has done
    
Inner_End:
    addi  s1,s1,1             # After a loop has done, sorted number +1
    
    beq s1,t2,Outer_End       # If s1 (Outer_Loop counter) = t2 (Arrsize), end the sorting
    j   Outer_Loop            # Else keep the sorting
    
Outer_End:
    
    la   t3,target
    lw   t3,0(t3)    #target 

Find:
    lw   t4,-4(a2)    # get the first sorted vector element
    addi a2,a2,4      # get the nexr element of sorted vector
    
    beq  t3,t4,Print  # If target=element of vector, then print the index
    
    bgt  s3,x0,End    # If target is matched in vector, and there is another element of vector not martched,then don't find anymore
    
    
    addi t5,t5,1      # index+1
    
    beq  t5,t2,End    # If t5 (index of vector) >= t2 (arrSize), 
    bgt  t5,t2,End    
    j    Find         # Else Keep Finding


Print:
    li  s3,1
    
    add a0, t5, x0 # return value
    li  a7, 1 # print integer
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
    
    
    
    
    
    
    
    
    
    
    
    
