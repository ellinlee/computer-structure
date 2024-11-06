.data
video:
    .float 0.5, 0.6, 0.4      # 3 time frames for the first pixel
    .float 0.3, 0.7, 0.3      # 3 time frames for the second pixel
    .float 0.2, 0.2, 0.8      # 3 time frames for the third pixel

threshold: .float 0.1
movement_detected: .string "Movement detected\n"
no_movement: .string "No movement detected\n"

.text
.globl _start
_start:
    j main                # Jump to main function (to avoid warning when executing)

main:
    li t0, 0              # Pixel index
    li t1, 3              # Total number of pixels (3 pixels)
    la t2, video          # Address of video data
    la t3, threshold      # Address of threshold(0.1) data
    flw ft0, 0(t3)        # Load threshold value

check_pixel:
    flw ft1, 0(t2)        # Pixel value from first frame
    flw ft2, 4(t2)        # Pixel value from second frame
    flw ft3, 8(t2)        # Pixel value from third frame

    fsub.s ft4, ft2, ft1  # Difference between first and second frame
    fabs.s ft4, ft4
    flt.s a0, ft0, ft4    # 1 if difference > threshold, else 0
    bnez a0, movement

    fsub.s ft4, ft3, ft2  # Difference between second and third frame
    fabs.s ft4, ft4
    flt.s a0, ft0, ft4    # 1 if difference > threshold, else 0
    bnez a0, movement

    addi t2, t2, 12       # Move to next pixel (3 floats = 12 bytes)
    addi t0, t0, 1        # Increment pixel counter
    blt t0, t1, check_pixel

    # No movement detected in any of the 3 pixels
    li a7, 4
    la a0, no_movement
    ecall
    j end

movement:
    # Movement detected in at least one pixel
    li a7, 4
    la a0, movement_detected
    ecall

end:
    li a7, 10             # Exit program
    ecall
