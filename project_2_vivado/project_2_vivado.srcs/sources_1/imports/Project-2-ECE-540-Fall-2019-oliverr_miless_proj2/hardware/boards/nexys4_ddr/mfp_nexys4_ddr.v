// mfp_nexys4_ddr.v
// January 1, 2017
//
// Instantiate the mipsfpga system and rename signals to
// match the GPIO, LEDs and switches on Digilent's (Xilinx)
// Nexys4 DDR board

// Outputs:
// 16 LEDs (IO_LED) 
// Inputs:
// 16 Slide switches (IO_Switch),
// 5 Pushbuttons (IO_PB): {BTNU, BTND, BTNL, BTNC, BTNR}
//

`include "mfp_ahb_const.vh"

module mfp_nexys4_ddr( 
    input                   CLK100MHZ,
    input                   CPU_RESETN,
    input                   BTNU, BTND, BTNL, BTNC, BTNR, 
    input  [`MFP_N_SW-1 :0] SW,
    output [`MFP_N_LED-1:0] LED,
    
    //Seven Seg Display Outputs
    output                  CA, CB, CC, CD, CE, CF, CG,
    output                  DP,
    output [ 7          :0] AN,
    
    inout  [ 8          :1] JB,
    input                   UART_TXD_IN,
    
    //vga signals
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS, VGA_VS,
    
    //Camera Signals
    inout [8:1] JD,
    /*
    JD1 : VSYNC
    JD2 : D7
    JD3 : D9
    JD4 : D11
    JD5 : HSYNC
    JD6 : D8
    JD7 : D10
    JD8 : PIXCLK
    */
    
    inout [8:1] JC
    /*
    JC1 : GPIO1
    JC2 : SDA
    JC3 : EXT CLK
    JC4 : D5
    JC5 : GPIO7
    JC6 : SCL
    JC7 : D4
    JC8 : D6
    */
);

    wire clk_out, clk_out_75, clk_31_5MHz; 
    wire tck_in, tck;
    
    //debounce connections
    wire [5:0] PBTN_DB;
    wire [15:0] SW_DB;
  
    clk_wiz_0 clk_wiz_0(
        .clk_in1(CLK100MHZ), 
        .clk_50MHz(clk_out), 
        .clk_75MHz(clk_out_75),
        .clk_31_5MHz(clk_31_5MHz)
    );
    
    IBUF IBUF1(.O(tck_in),.I(JB[4]));
    BUFG BUFG1(.O(tck), .I(tck_in));
    
    mfp_sys mfp_sys(
        .SI_Reset_N(PBTN_DB[5]),     //use debounced signal
        .SI_ClkIn(clk_out),
        .HADDR(),
        .HRDATA(),
        .HWDATA(),
        .HWRITE(),
        .HSIZE(),
        .EJ_TRST_N_probe(JB[7]),
        .EJ_TDI(JB[2]),
        .EJ_TDO(JB[3]),
        .EJ_TMS(JB[1]),
        .EJ_TCK(tck),
        .SI_ColdReset_N(JB[8]),
        .EJ_DINT(1'b0),
        .IO_Switch(SW_DB),          //use debounced signal
        .IO_PB(PBTN_DB[4:0]),       //use debounced signal
        .IO_LED(LED),
        .UART_RX(UART_TXD_IN),
        
        //seven segment IO
        .IO_SEV_SEG_CATH({CA, CB, CC, CD, CE, CF, CG}),
        .IO_SEV_SEG_DP(DP),
        .IO_SEV_SEG_AN(AN),
        
        //I2C connections
        .i2c_scl(JC[6]),
        .i2c_sda(JC[2]),
        .i2c_clk(clk_out) //give I2C module uninterrupted 50MHz clock
    );                   
        
    //add debounce module to debounce all buttons
    debounce debounce(
        .clk(clk_out),      //clock
        .pbtn_in({CPU_RESETN, BTNU, BTND, BTNL, BTNC, BTNR}), //push button inputs
        .switch_in(SW),     //switch inputs
        .pbtn_db(PBTN_DB),  //push button debounced output
        .swtch_db(SW_DB)    //switch debounced output
    );
    
    wire pix_clk, buf_clk;
    
    // external clock buffer. JD8 is a special clock capable pin, and the
    // IBUFG buffers this clock into the internal global clock fabric so
    // it can be used to clock other resources. It might be just fine to 
    // use a non-clock capable external pin, but this _might_ need to be 
    // changed to a BUFG to use it in that configuration
    IBUFG ibufg1(.I(JD[8]), .O(buf_clk));
    BUFG bug1(.I(buf_clk), .O(pix_clk));
    
    camera_2_vga cam_vga(
        // control inputs
        .reset(~PBTN_DB[5]),    //active high reset
        .test(SW[0]),                  //active high test mode enable
    
        //camera inputs
        .pix_clk(pix_clk),
        .cam_vsync(JD[1]),  
        .cam_hsync(JD[5]),
        .cam_data({JD[4], JD[7], JD[3], JD[6], JD[2], JC[8], JC[4], JC[7]}), // D11, D10, D9, D8, D7, D6, D5, D4
        
        // VGA clock and outputs
        .vga_clk(clk_31_5MHz), //31.5MHz for 640x480
        .vga_r(VGA_R), 
        .vga_g(VGA_G), 
        .vga_b(VGA_B),
        .vga_vs(VGA_VS), 
        .vga_hs(VGA_HS)
    );
            
endmodule

