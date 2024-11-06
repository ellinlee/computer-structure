# Movement Detection Program (RISC-V Assembly)

## Description
This program is a **movement detection application** written in RISC-V assembly language. It checks for movement by comparing brightness changes across three consecutive frames for each pixel.

## How It Works
1. **Pixel Data**: Brightness values for three pixels over three frames are provided.
2. **Threshold Comparison**: The program checks if the brightness difference between frames exceeds a set threshold (0.1).
3. **Output**:
   - If movement is detected, it prints "Movement detected."
   - If no movement is detected, it prints "No movement detected."

## File Structure
- `video`: Brightness data for each pixel.
- `threshold`: The threshold value for detecting movement.
- `movement_detected`, `no_movement`: Output messages.
