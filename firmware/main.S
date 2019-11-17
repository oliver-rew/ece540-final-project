/*
TODO COMMENTS
 */

// I2C regs
PRERLO              = 0xBF600000        # clock prescale low
PRERHI              = 0xBF600004        # clock prescale high
CTRL                = 0xBF600008        # control reg
TXRX                = 0xBF60000C        # TX/RX reg, TX on write, RX on read
CMDSTS              = 0xBF600010        # command/status reg, cmd on write, status on read
RESET               = 0xBF600014        # synch reset on i2c core

# I2C masks
TIP_MASK            = 0x02              # mask for TIP bit 1     

NUM_REGS            = 121               # number of init regs

/*
I2C prescale reg value to scale 50MHz down to 100KHz, see datasheet
TODO change to 400MHz
*/
I2C_PRESCALE        = 0x18


.globl main
main:
    li      $13, 0xBF800000 # LEDs address

    # set reset below init
    li      $18, RESET
    li      $19, 0x01
    sw      $19, 0($18)

    #wait
    li      $8, 1000
    jal DELAY;

    #clear reset
    li      $18, RESET
    li      $19, 0x00
    sw      $19, 0($18)

    #wait
    li      $8, 1000
    jal DELAY;

    # clear bit 7 in control reg to disable I2C core
    li      $18, CTRL
    li      $19, 0x00
    sw      $19, 0($18)

loop:

    # test last LED
    li		$12, 0x00008000
    sw      $12, 0($13)


    #load address of first camera init array value
    la      $16, CAM_INIT
    li      $11, 0          # $11 will keep track of the offset in the array

init: 

#TODO CONSTS


# we need to repeat the prescale set and core enable because there is some weird behavior 
# between the debug reset and the reset button. If they get out of sync, then the physical
# reset button doesn't reset to the right place, or something? Perhaps it could because I
# testing right now and the transmissions are not ACK'd?

    # set clock prescaler
    li      $18, PRERLO 
    li      $19, I2C_PRESCALE
    sw      $19, 0($18)     

    li      $18, PRERHI 
    li      $19, 0x00
    sw      $19, 0($18)

    # set bit 7 in control reg to enable I2C core
    li      $18, CTRL
    li      $19, 0x90
    sw      $19, 0($18)


    # get TXRX and CMDSTS addresses just once here
    li      $18, TXRX
    li      $21, CMDSTS

start:
    ###### I2C ADDRESS ######
    # load 0x20 into TX reg for image sensor
    # 0x10 is i2c addr 0x10 and a 0 for write
    li      $19, 0x20
    sw      $19, 0($18) # write to TXRX

    # set start condition(bit 7) and write (bit 4) in CMDSTS
    li      $19, 0x90
    sw      $19, 0($21)

    # wait for transfer to complete
    jal WAIT_FOR_TRANSFER
    nop
    #######################


    # calculate array address and load current value into reg $15
    sll     $9,  $11, 2     #multiple count by 4 for address offset
    add     $20, $16, $9
    lw      $15, 0($20)    

    ###########
    # Here we write the bytes in the current word, MSB to LSB
    ###########

first:
    ###### BYTE 4/4 ######
    srl     $14, $15, 24    # get MSB of word
    sw      $14, 0($18)     # write to TXRX

    # set write (bit 4) in CMDSTS
    li      $19, 0x10
    sw      $19, 0($21)

    # wait for transfer to complete
    jal WAIT_FOR_TRANSFER
    nop
    ######################


    ###### BYTE 3/4 ######
    srl     $14, $15, 16            # get 2nd MSB of word
    andi    $14, $14, 0x000000ff    # mask upper bytes
    sw      $14, 0($18)             # write to TXRX

    # set write (bit 4) in CMDSTS
    li      $19, 0x10
    sw      $19, 0($21)

    # wait for transfer to complete
    jal WAIT_FOR_TRANSFER
    nop
    ######################


    ###### BYTE 2/4 ######
    srl     $14, $15, 8             # get 2nd MSB of word
    andi    $14, $14, 0x000000ff    # mask upper bytes
    sw      $14, 0($18)             # write to TXRX

    # set write (bit 4) in CMDSTS
    li      $19, 0x10
    sw      $19, 0($21)

    # wait for transfer to complete
    jal WAIT_FOR_TRANSFER
    nop
    ######################


    ###### BYTE 1/4 ######
    andi    $14, $15, 0x000000ff    # mask upper bytes
    sw      $14, 0($18)             # write to TXRX

    # set stop condition(bit 6) and write (bit 4)
    li      $19, 0x50
    sw      $19, 0($21)     # write to CMDSTS

    # wait for transfer to complete
    jal WAIT_FOR_TRANSFER
    nop
    ######################

    #Delay before restarting
    li      $8, 10000
    jal DELAY;

    # continue init loop until we have written all regs
    add $11, $11, 1         # increment array offset
    li      $10, NUM_REGS
    bne     $11, $10, init

    # disable test LED
    li		$12, 0x00000000
    sw      $12, 0($13)

    #Delay before restarting
    li      $8, 100000000
    jal DELAY;


    beq     $0, $0, loop


# WAIT_FOR_TRANSFER waits for the Transfer-In-Progress (TIP) bit
# in the status register to be cleared. It clobbers regs $23-$25
WAIT_FOR_TRANSFER:
    li      $23, CMDSTS             # get status reg addr
    li      $24, TIP_MASK           # get TIP mask
    lw		$25, 0($23)             # load status reg
    and     $25, $25, $24           # mask status reg for TIP
    bnez    $25, WAIT_FOR_TRANSFER  # if TIP set, keep waiting
    jr      $ra
    nop

# DELAY delays for the number of cycles in $8
DELAY:
    addi    $8, $8 , -1     # Count down delay
    bgez    $8, DELAY
    nop                     # branch delay slot
    jr      $ra
    nop


#     # write back value to LEDs to be sure
#     #lw		$17, 0($18)
#     #sw      $17, 0($13)
.data

# CAM_INIT holds the register addresses and values that must
# be written to the image sensor at init. The upper two bytes
# are the register address, the lower 2 bytes are the value to
# written there. They should be sent MSB to LSB
CAM_INIT: 
.word  0x301A0001 # RESET #TODO WRITE THIS REG TWICE SINCE THE 1st does not always happen
.word  0x301A0001 # RESET
.word  0x301A10D8 # Disable Serial, Enable Parallel, Drive Outputs(no hi-z), lock reg
.word  0x30888000 # SEQ CTL PORT
.word  0x30860225 # SEQ RAM
.word  0x30865050 # SEQ RAM
.word  0x30862D26 # SEQ RAM
.word  0x30860828 # SEQ RAM
.word  0x30860D17 # SEQ RAM
.word  0x30860926 # SEQ RAM
.word  0x30860028 # SEQ RAM
.word  0x30860526 # SEQ RAM
.word  0x3086A728 # SEQ RAM
.word  0x30860725 # SEQ RAM
.word  0x30868080 # SEQ RAM
.word  0x30862917 # SEQ RAM
.word  0x30860525 # SEQ RAM
.word  0x30860040 # SEQ RAM
.word  0x30862702 # SEQ RAM
.word  0x30861616 # SEQ RAM
.word  0x30862706 # SEQ RAM
.word  0x30861736 # SEQ RAM
.word  0x308626A6 # SEQ RAM
.word  0x30861703 # SEQ RAM
.word  0x308626A4 # SEQ RAM
.word  0x3086171F # SEQ RAM
.word  0x30862805 # SEQ RAM
.word  0x30862620 # SEQ RAM
.word  0x30862804 # SEQ RAM
.word  0x30862520 # SEQ RAM
.word  0x30862027 # SEQ RAM
.word  0x30860017 # SEQ RAM
.word  0x30861E25 # SEQ RAM
.word  0x30860020 # SEQ RAM
.word  0x30862117 # SEQ RAM
.word  0x30861028 # SEQ RAM
.word  0x3086051B # SEQ RAM
.word  0x30861703 # SEQ RAM
.word  0x30862706 # SEQ RAM
.word  0x30861703 # SEQ RAM
.word  0x30861747 # SEQ RAM
.word  0x30862660 # SEQ RAM
.word  0x308617AE # SEQ RAM
.word  0x30862500 # SEQ RAM
.word  0x30869027 # SEQ RAM
.word  0x30860026 # SEQ RAM
.word  0x30861828 # SEQ RAM
.word  0x3086002E # SEQ RAM
.word  0x30862A28 # SEQ RAM
.word  0x3086081E # SEQ RAM
.word  0x30860831 # SEQ RAM
.word  0x30861440 # SEQ RAM
.word  0x30864014 # SEQ RAM
.word  0x30862020 # SEQ RAM
.word  0x30861410 # SEQ RAM
.word  0x30861034 # SEQ RAM
.word  0x30861400 # SEQ RAM
.word  0x30861014 # SEQ RAM
.word  0x30860020 # SEQ RAM
.word  0x30861400 # SEQ RAM
.word  0x30864013 # SEQ RAM
.word  0x30861802 # SEQ RAM
.word  0x30861470 # SEQ RAM
.word  0x30867004 # SEQ RAM
.word  0x30861470 # SEQ RAM
.word  0x30867003 # SEQ RAM
.word  0x30861470 # SEQ RAM
.word  0x30867017 # SEQ RAM
.word  0x30862002 # SEQ RAM
.word  0x30861400 # SEQ RAM
.word  0x30862002 # SEQ RAM
.word  0x30861400 # SEQ RAM
.word  0x30865004 # SEQ RAM
.word  0x30861400 # SEQ RAM
.word  0x30862004 # SEQ RAM
.word  0x30861400 # SEQ RAM
.word  0x30865022 # SEQ RAM
.word  0x30860314 # SEQ RAM
.word  0x30860020 # SEQ RAM
.word  0x30860314 # SEQ RAM
.word  0x30860050 # SEQ RAM
.word  0x30862C2C # SEQ RAM
.word  0x30862C2C # SEQ RAM
.word  0x309E0000 # DCDS_PROG_START_ADDR
.word  0x30E46372 # ADC_BITS_6_7
.word  0x30E27253 # ADC_BITS_4_5
.word  0x30E05470 # ADC_BITS_2_3
.word  0x30E6C4CC # ADC_CONFIG1
.word  0x30E88050 # ADC_CONFIG2
.word  0x30820029 # OP MODE CTL
.word  0x301E00C8 # DATA_PEDESTAL
.word  0x3EDA0F03 # DAC_LD_14_15
.word  0x3EDEC005 # DAC_LD_18_19
.word  0x3ED809EF # DAC_LD_12_13
.word  0x3EE2A46B # DAC_LD_22_23
.word  0x3EE0047D # DAC_LD_20_21
.word  0x3EDC0070 # DAC_LD_16_17
.word  0x30440404 # DARK_CONTROL
.word  0x3EE64303 # DAC_LD_26_27
.word  0x3EE4D208 # DAC_LD_24_25
.word  0x3ED600BD # DAC_LD_10_11
.word  0x30B01300 # DIGITAL_TEST
.word  0x30D4E007 # COLUMN_CORRECTION
.word  0x301200A0 # COARSE_INTEGRATION_TIME
.word  0x30320000 # DIGITAL_BINNING
.word  0x30020002 # Y_ADDR_START = 2
.word  0x30040000 # X_ADDR_START = 0
.word  0x300603C1 # Y_ADDR_END
.word  0x300804FF # X_ADDR_END = 1279
.word  0x300A03DE # FRAME_LENGTH_LINES
.word  0x300C0672 # LINE_LENGTH_PCK = 1650
.word  0x301A10D8 # RESET_REGISTER
.word  0x31D00001 # HDR_COMP
.word  0x302C000c # VT_SYS_CLK_DIV
.word  0x302A000a # VT_PIX_CLK_DIV
.word  0x302E0002 # PRE_PLL_CLK_DIV
.word  0x30300032 # PLL_MULTIPLIER
.word  0x30B01300 # DIGITAL_TEST
.word  0x31000000 # ae_ctrl_reg
.word  0x30641802 # DISABLE EMB. DATA
.word  0x301A10DC # Disable Serial, Enable Parallel, Drive Outputs(no hi-z), lock reg, streaming mode(not low power)

