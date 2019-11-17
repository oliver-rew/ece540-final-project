// mfp_ahb_gpio.v
//
// General-purpose I/O module for Altera's DE2-115 and 
// Digilent's (Xilinx) Nexys4-DDR board


`include "mfp_ahb_const.vh"

module mfp_ahb_gpio(
    input                        HCLK,
    input                        HRESETn,
    input      [  3          :0] HADDR,
    input      [  1          :0] HTRANS,
    input      [ 31          :0] HWDATA,
    input                        HWRITE,
    input                        HSEL,
    output reg [ 31          :0] HRDATA,

// memory-mapped I/O
    input      [`MFP_N_SW-1  :0] IO_Switch,
    input      [`MFP_N_PB-1  :0] IO_PB,
    output reg [`MFP_N_LED-1 :0] IO_LED,
    
    //Bot Control IO
    output reg [7:0] IO_BotCtrl,
    input [31:0] IO_Bot_Info,
    output reg IO_INT_ACK,
    input IO_BotUpdt_Sync
);

  reg  [3:0]  HADDR_d;
  reg         HWRITE_d;
  reg         HSEL_d;
  reg  [1:0]  HTRANS_d;
  wire        we;            // write enable

  // delay HADDR, HWRITE, HSEL, and HTRANS to align with HWDATA for writing
  always @ (posedge HCLK) 
  begin
    HADDR_d  <= HADDR;
	HWRITE_d <= HWRITE;
	HSEL_d   <= HSEL;
	HTRANS_d <= HTRANS;
  end
  
  // overall write enable signal
  assign we = (HTRANS_d != `HTRANS_IDLE) & HSEL_d & HWRITE_d;

    always @(posedge HCLK or negedge HRESETn)
       if (~HRESETn) begin
         IO_LED <= `MFP_N_LED'b0;  
       end else if (we)
         case (HADDR_d)
           //4'h0 [5:2] == 0x00
           `H_LED_IONUM: IO_LED <= HWDATA[`MFP_N_LED-1:0];
           
           //4'h4 [5:2] == 0x10 BotCtrl
           `H_BOT_CTRL_IONUM: IO_BotCtrl <= HWDATA[7:0];
           
           //4'h6 [5:2] == 0x18 Bot Int Ack
           `H_BOT_ACK_IONUM: IO_INT_ACK <= HWDATA[0];
         endcase
    
	always @(posedge HCLK or negedge HRESETn)
       if (~HRESETn)
         HRDATA <= 32'h0;
       else
	     case (HADDR)
	       //4'h1 [5:2] == 0x04
           `H_SW_IONUM: HRDATA <= { {32 - `MFP_N_SW {1'b0}}, IO_Switch };
           
           //4'h2 [5:2] == 0x08
           `H_PB_IONUM: HRDATA <= { {32 - `MFP_N_PB {1'b0}}, IO_PB };
           
           //4'h3 [5:2] == 0x0c IO_Bot_Info 
           `H_BOT_INFO_IONUM: HRDATA <= IO_Bot_Info;
           
           //4'h5 [5:2] == 0x14 IO_BotUpdt_Sync
           `H_BOT_SYNC_IONUM: HRDATA <= {{31{1'b0}}, IO_BotUpdt_Sync};
           
            default:    HRDATA <= 32'h00000000;
         endcase
endmodule

