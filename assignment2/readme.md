# Floating-Point Addition Simulator

This code is a MIPS assembly program that simulates floating-point addition using integer arithmetic. The program handles mantissa and exponent values, aligns exponents, adds mantissas, and normalizes the result if necessary.

## Description

The code takes two floating-point-like numbers, each represented by a mantissa and an exponent, and performs the following operations:
1. **Exponent Alignment**: Ensures both numbers have the same exponent by shifting the mantissa of the number with the smaller exponent.
2. **Mantissa Addition**: Adds the mantissas using a 4-bit binary adder.
3. **Overflow Check**: Checks if the result exceeds the 4-bit limit and normalizes it if necessary.
4. **Result Storage**: Saves the final normalized mantissa and exponent.

## Program Flow

1. **Load Test Values**: Initializes mantissa and exponent values for two numbers.
2. **Normalization (`normalize` label)**: Aligns the exponents by shifting the mantissa of the number with the smaller exponent until both exponents match.
3. **Addition of Mantissas (`add_mantissas` label)**: Adds the mantissas bit by bit, simulating a 4-bit binary adder with carry propagation.
4. **Overflow Handling (`check_overflow` label)**: If the result mantissa exceeds 4 bits, shifts it right and increments the exponent to normalize.
5. **Result Storage (`store_result` label)**: Stores the final mantissa and exponent in memory at the `result` label.

## How to Use

1. Load the program in a MIPS simulator or appropriate environment.
2. Run the program to execute the floating-point addition.
3. The final result, including the mantissa and exponent, is stored in memory at the label `result`.

## Example

With the provided initial values:
- First number: Mantissa = 2, Exponent = 1
- Second number: Mantissa = 3, Exponent = 1

The program will align exponents, add mantissas, and store the normalized result.

## Code Structure

- **normalize**: Aligns exponents by shifting mantissas.
- **add_mantissas**: Adds mantissas using a 4-bit binary adder.
- **check_overflow**: Normalizes the result if it exceeds 4 bits.
- **store_result**: Saves the result to memory.

## Exit

The program uses an `ecall` to terminate.
