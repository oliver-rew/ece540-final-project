/*
 * main.S - ECE 540 project #1 starter code for microAptiv_UP MIPS core
 * running on Nexys4 DDR FPGA target board
 *
 * Copyright Srivatsa Yogendra, 2017
 *
 * Created By:      Srivatsa Yogendra
 * Last Modified:   01-Oct-2017 (RK)
 *
 * Description:
 * Reads the switches on the FPGA board and writes
 * the values to the LEDs and the seven segment display
 *
 * Assumes the existance of an AHB-Lite peripheral for the 8 digit
 * 7-segment display on the Nexys4 DDR.  The peripheral has 4 memory
 * mapped I/O registers:
 *  PORT_SEVENSEG_EN - (8 bits) Individual enables for each digit. Set bit to 0 to enable digit
 *                                  Digit7 = bit[7], Digit6 = bit[6], Digit5 = bit[5], Digit4 = bit[4],
 *                                  Digit3 = bit[3], Digit2 = bit[2], Digit1 = bit[1], Digit0 = bit[0]
 *  PORT_SEVENSEG_HGH = (32 bits) Value of digit.  Each digit has the range of 31:0, top 3 bits ignored
 *                                  Digit7 = bits[31:24], Digit6 = bits[23:16],
 *                                  Digit5 = bits[15:8] , Digit4 = bits[7:0]
 *  PORT_SEVENSEG_LOW = (32 bits) Value of digit.  Each digit has the range of 31:0, top 3 bits ignored
 *                                  Digit3 = bits[31:24], Digit2 = bits[23:16],
 *                                  Digit1 = bits[15:8] , Digit0 = bits[7:0]
 *  PORT_SEVENSEG_DP - (8 bits) Individual decimal points for each digit. Set bit to 0 to turn on the decimal point
 *                                  DP7 = bit[7], DP6 = bit[6], DP5 = bit[5], DP4 = bit[4],
 *                                  DP3 = bit[3], DP2 = bit[2], DP1 = bit[1], DP0 = bit[0]
 */

/* Segment Display Registers */
PORT_SEVENSEG_EN    = 0xBF700000        # (o) 7 Segment enable
PORT_SEVENSEG_HGH   = 0xBF700004        # (o) 7 Segment Higher Display
PORT_SEVENSEG_LOW   = 0xBF700008        # (o) 7 Segment Lower Display
PORT_SEVENSEG_DP    = 0xBF70000C        # (o) 7 segment Decimal Point Display
PORT_PUSHBUTTONS    = 0xBF800008        # (i) Pushbutton input

/* Button input masks */
BTN_RIGHT           = 0x01              # Mask for Right Button
BTN_CENTER          = 0x02              # Mask for Center Button
BTN_LEFT            = 0x04              # Mask for Left Button
BTN_DOWN            = 0x08              # Mask for Down Button
BTN_UP              = 0x10              # Mask for Up Button

/* Motor control fields */
MOTOR_RIGHT_FWD     = 0x01              # Right motor forward bit
MOTOR_LEFT_FWD      = 0x10              # Left motor forward bit
MOTOR_RIGHT_ON      = 0x02              # Right motor on/off bit
MOTOR_LEFT_ON       = 0x20              # Left motor on/off bit

/* Constant values */
DELAY_COUNT         = 17000000          # ~1Hz delay count

// I2C regs
PRERLO              = 0xBF600000        # clock prescale low
PRERHI              = 0xBF600004        # clock prescale high
CTRL                = 0xBF600008        # control reg
TXRX                = 0xBF60000C        # TX/RX reg, TX on write, RX on read
CMDSTS              = 0xBF600010        # command/status reg, cmd on write, status on read

# I2C masks
TIP_MASK            = 0x02              # mask for TIP bit 1

/*
I2C prescale reg value to scale 50MHz down to 100KHz, see datasheet
TODO change to 400MHz
*/
I2C_PRESCALE        = 0x18

# NOTE NEED 2~3 NOPs after writing in order to read back the correct value


.globl main
main:
    #test
    li      $13, 0xBF800000 # LEDs address

    #li		$17, 0xAA
    #sw      $17, 0($13)

    # set clock prescaler
    li      $18, PRERLO 
    li      $19, I2C_PRESCALE
    sw      $19, 0($18)    

    nop
    nop
    nop

    # set clock prescaler
    li      $18, PRERLO 
    li      $19, I2C_PRESCALE
    sw      $19, 0($18)    

    nop
    nop
    nop

    # write back value to LEDs to be sure
    # lw		$17, 0($18)
    # sw      $17, 0($13)

    # nop
    # nop
    # nop

    li      $18, PRERHI 
    li      $19, 0x00
    sw      $19, 0($18)

    nop
    nop
    nop

    # set bit 7 in control reg to enable I2C ctrl
    li      $18, CTRL
    li      $19, 0xC0
    sw      $19, 0($18)

    nop
    nop
    nop

    # load 0x30 into TX reg
    # 0x30 is i2c addr 0x18 and a 0 for write
    li      $18, TXRX
    li      $19, 0x30
    sw      $19, 0($18)

    nop
    nop
    nop

    # set start condition(bit 7) and write (bit 4)
    li      $18, CMDSTS
    li      $19, 0x90
    sw      $19, 0($18)

    nop
    nop
    nop

    # Check TIP (bit 7) in status reg, when TIP is cleared
    # the transfer is complete
CHECK_TIP1:
    nop
    nop
    nop
    li      $18, CMDSTS     # get status reg addr
    li      $19, TIP_MASK   # get TIP mask
    lw		$17, 0($18)     # load status reg
    #sw      $17, 0($13)
    and     $17, $17, $19   # mask status reg for TIP
    bnez    $17, CHECK_TIP1  # if TIP set, keep waiting

    nop
    nop
    nop

    # load 0xC3 into TX reg
    li      $18, TXRX
    li      $19, 0xC3
    sw      $19, 0($18)

    nop
    nop
    nop

    # set stop condition(bit 6) and write (bit 4)
    li      $18, CMDSTS
    li      $19, 0x50
    sw      $19, 0($18)

    nop
    nop
    nop

    # Check TIP (bit 7) in status reg, when TIP is cleared
    # the transfer is complete
CHECK_TIP2:
    nop
    nop
    nop
    li      $18, CMDSTS     # get status reg addr
    li      $19, TIP_MASK   # get TIP mask
    lw		$17, 0($18)     # load status reg
    #sw      $17, 0($13)
    and     $17, $17, $19   # mask status reg for TIP
    bnez    $17, CHECK_TIP2  # if TIP set, keep waiting

end:
    nop
    nop
    nop
    beq     $0, $0, end



#     /* Delay so we can see the updates */
#     li      $8, 100000000
# delay:
#     addi    $8, $8 , -1                 # Count down delay
#     bgez    $8, delay
#     nop # branch delay slot

#     # write back value to LEDs to be sure
#     #lw		$17, 0($18)
#     #sw      $17, 0($13)
    



#     # li      $15, 0xBF600008
#     # lw		$16, 0($15) #read prescale low reg
#     # sw      $16, 0($13)
#     beq     $0, $0, main  
#     nop # branch delay slot
 