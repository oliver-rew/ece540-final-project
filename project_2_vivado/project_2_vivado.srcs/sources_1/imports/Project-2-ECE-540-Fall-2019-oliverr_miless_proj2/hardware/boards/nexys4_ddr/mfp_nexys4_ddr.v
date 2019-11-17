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
    
    //JA pins for I2C TODO should these both be inout?
    inout [3:1] JA //JA1 = SCL, JA2 = SDA
);
    assign JA[3] = LED[15];

    // Press btnCpuReset to reset the processor. 
        
    wire clk_out, clk_out_75; 
    wire tck_in, tck;
    
    //debounce connections
    wire [5:0] PBTN_DB;
    wire [15:0] SW_DB;
  
    //rojobot connections
    wire [13:0] worldmap_addr;
    wire [1:0] worldmap_data;
    
    wire [7:0] MotCtl_in, LocX_reg, LocY_reg, Sensors_reg, BotInfo_reg;
    wire intAck, botUpdt;
    reg botUpdtSync; 
    
    wire clk_32MHz;
  
    clk_wiz_0 clk_wiz_0(
        .clk_in1(CLK100MHZ), 
        .clk_out1(clk_out), 
        .clk_out2(clk_out_75), 
        .clk_out3(clk_32MHz) //TODO this isn't used
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
        
        //Bot Control IO
        .IO_BotCtrl(MotCtl_in),
        .IO_Bot_Info({LocX_reg, LocY_reg, Sensors_reg, BotInfo_reg}),
        .IO_INT_ACK(intAck),
        .IO_BotUpdt_Sync(botUpdtSync),
        
        //I2C connections
        .i2c_scl(JA[1]),
        .i2c_sda(JA[2]),
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
  
    //instantiate rojobot
    rojobot31_0 rojobot31_0 (
        .MotCtl_in(MotCtl_in),            // input wire [7 : 0] MotCtl_in
        .LocX_reg(LocX_reg),              // output wire [7 : 0] LocX_reg
        .LocY_reg(LocY_reg),              // output wire [7 : 0] LocY_reg
        .Sensors_reg(Sensors_reg),        // output wire [7 : 0] Sensors_reg
        .BotInfo_reg(BotInfo_reg),        // output wire [7 : 0] BotInfo_reg
        .worldmap_addr(worldmap_addr),    // output wire [13 : 0] worldmap_addr
        .worldmap_data(worldmap_data),    // input wire [1 : 0] worldmap_data
        .clk_in(clk_out_75),              // input wire clk_in
        .reset(~PBTN_DB[5]),              // input wire reset 
        .upd_sysregs(botUpdt),            // output wire upd_sysregs 
        .Bot_Config_reg(SW_DB[7:0])       // input wire [7 : 0] Bot_Config_reg 
    );

    wire video_on;
    wire [11:0] pix_row, pix_col;
    wire [6:0]  world_row, world_col;
    wire [1:0]  world_data, icon_data;
    
    dtg dtg(
        .clock(clk_out_75),
        .rst(~PBTN_DB[5]), 
        .video_on(video_on),
        .horiz_sync(VGA_HS),
        .vert_sync(VGA_VS),
        .pixel_row(pix_row),
        .pixel_column(pix_col)
    );
    
    //instantiate world map
    world_map world_map(
        .clka(clk_out_75),
        .addra(worldmap_addr),
        .douta(worldmap_data),
        .clkb(clk_out_75),
        .addrb({world_row, world_col}),
        .doutb(world_data)
    );
    
    //divide pixel column by 8 with bit shift; 1024/128 == 8
    assign world_col = pix_col[9:3];
    
    //we need to divide the 768 pixel height down to the 128 pixel world.
    //shift the row address once to divide it down to 384, then use 9 bit 
    //LUT divide module to divide it by 3
    integer_divide_lut #(9, 3) div(
        .dividend(pix_row[9:1]),    //shift pix_row once to right
        .quotient(world_row[6:0])   //output lowest 7 bits for 128 pixel out
    );
    
    //instantiate colorizer module to ingest the icon and world 
    //pixel data output the correct value on the VGA lines
    colorizer color(
        .video_on(video_on),
        .vga_r(VGA_R),
        .vga_g(VGA_G),
        .vga_b(VGA_B),
        .world_color(world_data),
        .icon_color(icon_data) 
    );
    
    //instantiate icon module
    icon icon(
        .pix_row(pix_row), 
        .pix_col(pix_col),
        .LocX_reg(LocX_reg), 
        .LocY_reg(LocY_reg), 
        .BotInfo_reg(BotInfo_reg),
        .icon_color(icon_data),
        .clk(clk_out_75)
    );
    
    //always block to synchronize upd_sysregs from rojobot to MIPS core
    always @(posedge clk_out) begin
        if(intAck)
            botUpdtSync <= 1'b0;
        else if (botUpdt == 1'b1)
            botUpdtSync <= 1'b1;
        else    
            botUpdtSync <= botUpdtSync;
    end
            
endmodule

