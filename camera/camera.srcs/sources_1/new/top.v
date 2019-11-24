
module mfp_nexys4_ddr( 
    input                   CLK100MHZ,
    input                   CPU_RESETN,
    input                   BTNU, BTND, BTNL, BTNC, BTNR, 
    input  [15 :0] SW,
    output [15:0] LED,
    
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
    
    //JA pins for I2C TODO should these both be inout?
    inout [8:1] JA, //JA1 = SCL, JA2 = SDA
    /*
    JA1 : VSYNC
    JA2 : D7
    JA3 : D9
    JA4 : D11
    JA5 : HSYNC
    JA6 : D8
    JA7 : D10
    JA8 : PIXCLK
    */
    
    input [8:1] JX,
    /*
    JX1 : GPIO1
    JX2 : SDA
    JX3 : EXT CLK
    JX4 : D5
    JX5 : GPIO7
    JX6 : SCL
    JX7 : D4
    JX8 : D6
    */
    
    //JA pins
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
    
    input [8:1] JC
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

    wire clk_31_5MHz;
    clk_wiz_1 instance_name(
        // Clock out ports
        .clk_31_5MHz(clk_31_5MHz),     // output clk_31_5_Mhz
        
        // Clock in ports
        .clk_in1(CLK100MHZ)
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
        .reset(~CPU_RESETN),    //active high reset
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


