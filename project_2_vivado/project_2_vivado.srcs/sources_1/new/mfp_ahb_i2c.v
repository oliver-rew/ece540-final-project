// mfp_ahb_gpio.v
//
// General-purpose I/O module for Altera's DE2-115 and 
// Digilent's (Xilinx) Nexys4-DDR board


`include "mfp_ahb_const.vh"

module mfp_ahb_i2c(
    input                        HCLK,
    input                        HRESETn,
    input      [  3          :0] HADDR,
    input      [  1          :0] HTRANS,
    input      [ 31          :0] HWDATA,
    input                        HWRITE,
    input                        HSEL,
    output [ 31          :0] HRDATA,
    
    //I2C
    inout i2c_sda,
    inout i2c_scl,
    input i2c_clk
);
/*
since memory reference must be 32 bit aligned, the AHB bus addresses
map to the I2C controllers registers as such:
AHB  --> I2C Reg
0x00 --> 0x00
0x04 --> 0x01
0x08 --> 0x02
0x0C --> 0x03
0x10 --> 0x04
0x14 --> 0x05 SYNC RESET REG
*/


    reg  [3:0]  HADDR_d;
    reg         HWRITE_d;
    reg         HSEL_d;
    reg  [1:0]  HTRANS_d;
    wire        we;            // write enable
    
    //If HWRITE_d is high, then put HADDR_d on the address bus instead of HADDR. This has
    //this effect of holding the address on the bus for 2 cycles
    //wire [3:0] addr;
    //assign addr = HWRITE_d ? HADDR_d : HADDR;

    // delay HADDR, HWRITE, HSEL, and HTRANS to align with HWDATA for writing
    always @ (posedge HCLK) 
    begin
    HADDR_d  <= HADDR;
    HWRITE_d <= HWRITE;
    HSEL_d   <= HSEL;
    HTRANS_d <= HTRANS;
    end
  
    //SHOULD I TRY THIS?
    // overall write enable signal
    assign we = (HTRANS_d != `HTRANS_IDLE) & HSEL_d & HWRITE_d;
  
    wire scl_padoen_oe, sda_padoen_oe; //i2c line OE enables
    wire scl_pad_o, sda_pad_o; //i2c line outputs
    wire scl_pad_i, sda_pad_i; //i2c line inputs
      
    //i2c line in/out select
    assign i2c_scl = scl_padoen_oe ? 1'bz : scl_pad_o;
    assign i2c_sda = sda_padoen_oe ? 1'bz: sda_pad_o;
    assign scl_pad_i = i2c_scl;
    assign sda_pad_i = i2c_sda;
    
    //this essentially implements a synchronus reset register
    //LSb of 0x05 (AHB 0x14) controls the active high reset
    reg reset;
    always @(posedge HCLK or negedge HRESETn)
       if (~HRESETn) 
         reset <= 1'b0; 
       else if(HSEL_d && HADDR_d == 4'h05)
         reset <= HWDATA[0]; 
    
    //instantiate I2C module
    i2c_master_top i2c(
        .wb_clk_i(i2c_clk), 
        .wb_rst_i(reset), //this is controller by a reg, TODO maybe remove below?
        .arst_i(HRESETn), //active low TODO be sure about the polarity here
        .wb_adr_i(HADDR_d[2:0]), //always use delayed address as wishbone operations take only one cycle
        .wb_dat_i(HWDATA[7:0]), //HWDATA is not delayed because AHB is pipelined and data is on the second clock 
        .wb_dat_o(HRDATA[7:0]), //attach data out to HRDATA, should I pad the rest with zeros elsewhere?
        .wb_we_i(HWRITE_d),           //Write enable: must be assert ond writes
        
        //HSEL_d should work for strobe and cycle because there writes should only be one clock cycle
        .wb_stb_i(HSEL_d),      
        .wb_cyc_i(HSEL_d),      
        
        .wb_ack_o(),            //Ack: slave ACKs after receives STB, but we aren't using this
        .wb_inta_o(),           //Interrupt out: unused
        .scl_pad_i(scl_pad_i), 
        .scl_pad_o(scl_pad_o), 
        .scl_padoen_o(scl_padoen_oe), 
        .sda_pad_i(sda_pad_i), 
        .sda_pad_o(sda_pad_o), 
        .sda_padoen_o(sda_padoen_oe)
    );

endmodule

