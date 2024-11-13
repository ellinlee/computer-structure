    .data
result: .word 0    # Final result storage

    .text
    .globl main

main:
    # Load test values (can be modified as needed)
    li s0, 2    # First mantissa
    li s1, 1    # First exponent
    li s2, 3    # Second mantissa
    li s3, 1    # Second exponent

normalize:
    # Compare exponents
    beq s1, s3, add_mantissas    # If exponents equal, add mantissas
    slt t0, s1, s3               # If first exp < second exp
    beq t0, zero, shift_second   # If false, shift second number
    
shift_first:
    srl s0, s0, 1    # Shift mantissa right
    addi s1, s1, 1   # Increment exponent
    beq s1, s3, add_mantissas
    j shift_first

shift_second:
    srl s2, s2, 1    # Shift mantissa right
    addi s3, s3, 1   # Increment exponent
    beq s1, s3, add_mantissas
    j shift_second

add_mantissas:
    # 4-bit adder implementation
    li t4, 0          # Initialize carry to 0
    li t0, 15         # 4-bit mask (1111 in binary)
    and s0, s0, t0    # Ensure 4-bit numbers
    and s2, s2, t0

    # Bit 0
    and t1, s0, 1     # Get LSB of first number
    and t2, s2, 1     # Get LSB of second number
    xor t3, t1, t2    # Sum without carry
    xor a0, t3, t4    # Add carry (a0 stores the result mantissa)
    and t4, t1, t2    # Calculate new carry

    # Bit 1
    srl t1, s0, 1
    and t1, t1, 1
    srl t2, s2, 1
    and t2, t2, 1
    xor t3, t1, t2
    xor t3, t3, t4
    sll t3, t3, 1
    or a0, a0, t3
    and t4, t1, t2

    # Bit 2
    srl t1, s0, 2
    and t1, t1, 1
    srl t2, s2, 2
    and t2, t2, 1
    xor t3, t1, t2
    xor t3, t3, t4
    sll t3, t3, 2
    or a0, a0, t3
    and t4, t1, t2

    # Bit 3
    srl t1, s0, 3
    and t1, t1, 1
    srl t2, s2, 3
    and t2, t2, 1
    xor t3, t1, t2
    xor t3, t3, t4
    sll t3, t3, 3
    or a0, a0, t3

check_overflow:
    # Check if result needs normalization
    li t0, 8          # Check if result > 7 (overflow)
    slt t1, t0, a0
    beq t1, zero, store_result
    
    # Handle overflow
    srl a0, a0, 1    # Shift right
    addi s1, s1, 1   # Increment exponent

store_result:
    # Store final result
    move a1, s1      # Store exponent in a1
    la t5, result    # Load address of result into t5
    sw a0, 0(t5)    # Store mantissa in memory

exit:
    # Exit program
    li a7, 10        # Set up ecall for exit
    ecall
