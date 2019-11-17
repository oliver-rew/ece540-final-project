// mfp_ahb.v
//
// Modified by Oliver Rew 10/19/19
//
// AHB-lite bus module with 3 slaves: boot RAM, program RAM, and
// GPIO (memory-mapped I/O: switches and LEDs from the FPGA board).
// The module includes an address decoder and multiplexer (for
// selecting which slave module produces HRDATA).

`include "mfp_ahb_const.vh"


module mfp_ahb
(
    input                       HCLK,
    input                       HRESETn,
    input      [ 31         :0] HADDR,
    input      [  2         :0] HBURST,
    input                       HMASTLOCK,
    input      [  3         :0] HPROT,
    input      [  2         :0] HSIZE,
    input      [  1         :0] HTRANS,
    input      [ 31         :0] HWDATA,
    input                       HWRITE,
    output     [ 31         :0] HRDATA,
    output                      HREADY,
    output                      HRESP,
    input                       SI_Endian,

    // memory-mapped I/O
    input      [`MFP_N_SW-1 :0] IO_Switch,
    input      [`MFP_N_PB-1 :0] IO_PB,
    output     [`MFP_N_LED-1:0] IO_LED,    
    
    //Seven Seg outputs
    output [6:0]            IO_SEV_SEG_CATH,
    output                  IO_SEV_SEG_DP,
    output [7:0]            IO_SEV_SEG_AN, 
    
    //Bot Control IO
    output [7:0] IO_BotCtrl,
    input [31:0] IO_Bot_Info,
    output IO_INT_ACK,
    input IO_BotUpdt_Sync,
    
    //I2C
    inout i2c_sda,
    inout i2c_scl,
    input i2c_clk
);


  wire [31:0] HRDATA3, HRDATA2, HRDATA1, HRDATA0;
  wire [ 4:0] HSEL;
  reg  [ 4:0] HSEL_d;

  assign HREADY = 1;
  assign HRESP = 0;
	
  // Delay select signal to align for reading data
  always @(posedge HCLK)
    HSEL_d <= HSEL;

  // Module 0 - boot ram
  mfp_ahb_b_ram mfp_ahb_b_ram(HCLK, HRESETn, HADDR, HBURST, HMASTLOCK, HPROT, HSIZE,
                              HTRANS, HWDATA, HWRITE, HRDATA0, HSEL[0]);
  // Module 1 - program ram
  mfp_ahb_p_ram mfp_ahb_p_ram(HCLK, HRESETn, HADDR, HBURST, HMASTLOCK, HPROT, HSIZE,
                              HTRANS, HWDATA, HWRITE, HRDATA1, HSEL[1]);
  // Module 2 - GPIO
  mfp_ahb_gpio mfp_ahb_gpio(
    HCLK, 
    HRESETn, 
    HADDR[5:2], 
    HTRANS, 
    HWDATA, 
    HWRITE, 
    HSEL[2],
    HRDATA2, 
    IO_Switch, 
    IO_PB, 
    IO_LED, 
    IO_BotCtrl, 
    IO_Bot_Info,//TODO connection by name here
    IO_INT_ACK,
    IO_BotUpdt_Sync
  );
  
  //instantiate i2c module
  //TODO connect by name here
  mfp_ahb_i2c i2c(
    HCLK, 
    HRESETn, 
    
    /*
    even though the i2c ctrl's registers are 8 bit, 
    they each use a single 32 bit as to be aligned
    */
    HADDR[5:2], 
    
    HTRANS, 
    HWDATA, 
    HWRITE, 
    HSEL[4],
    HRDATA3, 
    
    //I2C
    i2c_sda,
    i2c_scl,
    i2c_clk
  );
                            
  //Module 3 - Seven Segment Display
  mfp_ahb_seven_seg_ctrl mfp_ahb_seven_seg_ctrl(
    HCLK, 
    HRESETn, 
    HADDR[5:2], 
    HTRANS, 
    HWDATA, 
    HWRITE, 
    HSEL[3], 
    IO_SEV_SEG_CATH, 
    IO_SEV_SEG_DP, 
    IO_SEV_SEG_AN
  );
 
 
  ahb_decoder ahb_decoder(HADDR, HSEL);
  ahb_mux ahb_mux(HCLK, HSEL_d, HRDATA3, HRDATA2, HRDATA1, HRDATA0, HRDATA);

endmodule

module ahb_decoder
(
    input  [31:0] HADDR,
    output [ 4:0] HSEL
);

  // Decode based on most significant bits of the address
  assign HSEL[0] = (HADDR[28:22] == `H_RAM_RESET_ADDR_Match); // 128 KB RAM  at 0xbfc00000 (physical: 0x1fc00000)
  assign HSEL[1] = (HADDR[28]    == `H_RAM_ADDR_Match);       // 256 KB RAM at 0x80000000 (physical: 0x00000000)
  assign HSEL[2] = (HADDR[28:22] == `H_LED_ADDR_Match);       // GPIO at 0xbf800000 (physical: 0x1f800000)
  assign HSEL[3] = (HADDR[28:20] == `H_7_SEG_ADDR_Match);   // 7 Segment Display at 0xbf70000 (physical: 0x1f700000)
  
  //TODO const this!!!!
  assign HSEL[4] = (HADDR[28:20] == 9'h1f6);     //I2C ctrl at 0xbf60_0000 (physical: 0x1f60_0000)
endmodule


module ahb_mux
(
    input             HCLK,
    input      [ 4:0] HSEL,
    input      [31:0] HRDATA3, HRDATA2, HRDATA1, HRDATA0,
    output reg [31:0] HRDATA
);

    always @(*)
      casez (HSEL)
	      5'b????1:     HRDATA = HRDATA0;
	      5'b???10:     HRDATA = HRDATA1;
	      5'b00100:     HRDATA = HRDATA2;
	      5'b10000:     HRDATA = HRDATA3; //I2C
	      default:     HRDATA = HRDATA1;
      endcase
endmodule

