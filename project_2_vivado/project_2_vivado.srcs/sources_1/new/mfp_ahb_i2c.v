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
    output [ 31          :0] HRDATA, //TODO I removed reg from this because it's registered in the I2c module?
    
    //I2C
    inout i2c_sda,
    inout i2c_scl,
    input i2c_clk

//// memory-mapped I/O
//    input      [`MFP_N_SW-1  :0] IO_Switch,
//    input      [`MFP_N_PB-1  :0] IO_PB,
//    output reg [`MFP_N_LED-1 :0] IO_LED,

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
*/



    reg  [3:0]  HADDR_d;
    reg         HWRITE_d;
    reg         HSEL_d;
    reg  [1:0]  HTRANS_d;
    wire        we;            // write enable
    
    //If HWRITE_d is high, then put HADDR_d on the address bus instead of HADDR. This has
    //this effect of holding the address on the bus for 2 cycles
    wire [3:0] addr;
    assign addr = HWRITE_d ? HADDR_d : HADDR;

    // delay HADDR, HWRITE, HSEL, and HTRANS to align with HWDATA for writing
    //TODO NOT SURE ABOUT THESE DELAYS?
    always @ (posedge HCLK) 
    begin
    HADDR_d  <= HADDR;
    HWRITE_d <= HWRITE;
    HSEL_d   <= HSEL;
    HTRANS_d <= HTRANS;
    end
  
    // overall write enable signal
    assign we = (HTRANS_d != `HTRANS_IDLE) & HSEL_d & HWRITE_d;
    //assign we = (HTRANS != `HTRANS_IDLE) & HSEL & HWRITE;
  
    wire scl_padoen_oe, sda_padoen_oe; //i2c line OE enables
    wire scl_pad_o, sda_pad_o; //i2c line outputs
    wire scl_pad_i, sda_pad_i; //i2c line inputs
    
//    reg [5:0] count = 0;
//    always @(posedge i2c_clk) begin
//        if(~HRESETn)
//            count <= 6'b0;
//        else
//           count <= count + 1;
//    end
//    //i2c line in/out select
//    assign i2c_scl = count[5];
//    assign i2c_sda = count[4];
      
    //i2c line in/out select
    //assign i2c_scl = scl_pad_o;
    //assign i2c_sda = sda_pad_o;
    //TODO FIX
    assign i2c_scl = scl_padoen_oe ? 1'bz : scl_pad_o;
    assign i2c_sda = sda_padoen_oe ? 1'bz: sda_pad_o;
    assign scl_pad_i = i2c_scl;
    assign sda_pad_i = i2c_sda;
    
    /*
    we only want strobe to be asserted on the first cycle of a transaction. 
    therefore, we save the last state of select and strobe here, and assert
    strobe based on those values.
    TODO I should write a test bench for this!
    */
    
    //delay assignment of last val for one cycle TODO NOT SURE UGH!!!@!
//    wire strobe;
//    reg last_strobe, last_strobe2, last_sel;
//    always @(posedge HCLK) begin
//        last_strobe <= #1 strobe;
//        last_strobe2 <= last_strobe;
//        last_sel <= #1 HSEL_d;
//    end
    
    //only assert strobe when the HSEL is asserted
    //and the last strobe and select values were 0
    //TODO not sure I need trinary here, but want to make sure either 0 or one are set
    //.assign strobe = (~last_strobe2 && ~last_sel && HSEL_d) ?  1'b1 : 1'b0;
    
    /*
    TOMORROW:
    last attempts
    - keep address on bus for 2 cycles with "addr" and HADDR_d
    - hookup we, stb, and cyc to HWRITE_d and HSEL_d
    - WHOA it sorta worked, I can read back!?! Try that with all read write registers in same program
    - lines were low on logic analyzer, so I should add pullups
    -  
    */
  
    //instantiate I2C module
    i2c_master_top i2c(
        .wb_clk_i(i2c_clk), 
        .wb_rst_i(1'b0), //we're using async reset, so tie this low(inactive) 
        .arst_i(HRESETn), //active low TODO be sure about the polarity here
        .wb_adr_i(addr[2:0]), //TODO NOT SURE this worked?
        .wb_dat_i(HWDATA[7:0]), 
        .wb_dat_o(HRDATA[7:0]), //attach data out to HRDATA, should I pad the rest with zeros elsewhere?
        .wb_we_i(HWRITE_d),           //Write enable: must be assert on writes //TODO try existing WE here, but might not work
        .wb_stb_i(HSEL_d),      //Strobe: asserted on first cycle of transfer 
        .wb_cyc_i(HSEL_d),      //Cycle: must be asserted for entire length on transfer //TODO try HSEL_d here, but might not work
        .wb_ack_o(),            //Ack: slave ACKs after receives STB, but we aren't using this
        .wb_inta_o(),           //Interrupt out: unused
        .scl_pad_i(scl_pad_i), 
        .scl_pad_o(scl_pad_o), 
        .scl_padoen_o(scl_padoen_oe), 
        .sda_pad_i(sda_pad_i), 
        .sda_pad_o(sda_pad_o), 
        .sda_padoen_o(sda_padoen_oe)
    );

//    always @(posedge HCLK or negedge HRESETn)
//       if (~HRESETn) begin
//         IO_LED <= `MFP_N_LED'b0;  
//       end else if (we)
//         case (HADDR_d)
//           //4'h0 [5:2] == 0x00
//           `H_LED_IONUM: IO_LED <= HWDATA[`MFP_N_LED-1:0];
           
//           //4'h4 [5:2] == 0x10 BotCtrl
//           `H_BOT_CTRL_IONUM: IO_BotCtrl <= HWDATA[7:0];
           
//           //4'h6 [5:2] == 0x18 Bot Int Ack
//           `H_BOT_ACK_IONUM: IO_INT_ACK <= HWDATA[0];
//         endcase
    
//	always @(posedge HCLK or negedge HRESETn)
//       if (~HRESETn)
//         HRDATA <= 32'h0;
//       else
//	     case (HADDR)
//	       //4'h1 [5:2] == 0x04
//           `H_SW_IONUM: HRDATA <= { {32 - `MFP_N_SW {1'b0}}, IO_Switch };
           
//           //4'h2 [5:2] == 0x08
//           `H_PB_IONUM: HRDATA <= { {32 - `MFP_N_PB {1'b0}}, IO_PB };
           
//           //4'h3 [5:2] == 0x0c IO_Bot_Info 
//           `H_BOT_INFO_IONUM: HRDATA <= IO_Bot_Info;
           
//           //4'h5 [5:2] == 0x14 IO_BotUpdt_Sync
//           `H_BOT_SYNC_IONUM: HRDATA <= {{31{1'b0}}, IO_BotUpdt_Sync};
           
//            default:    HRDATA <= 32'h00000000;
//         endcase
endmodule

