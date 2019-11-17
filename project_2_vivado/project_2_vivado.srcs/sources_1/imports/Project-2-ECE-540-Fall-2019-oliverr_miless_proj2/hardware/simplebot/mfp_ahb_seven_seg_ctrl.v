/*
mfp_ahb_seven_seg_ctrl.v

Oliver Rew
10/14/2019

`mfp_ahb_seven_seg_ctrl` interfaces the `mfb_ahb` module with the `mfb_ahb_sevgensegtimer` 
module. It is strongly derived from the `mfb_ahb_gpio` module.

This code was developed for ECE540 Project 1 Simple Bot
*/

module mfp_ahb_seven_seg_ctrl
(
    input                        HCLK,
    input                        HRESETn,
    input      [  3          :0] HADDR,
    input      [  1          :0] HTRANS,
    input      [ 31          :0] HWDATA,
    input                        HWRITE,
    input                        HSEL,

    //Seven Seg outputs
    output [6:0]            IO_SEV_SEG_CATH,
    output                  IO_SEV_SEG_DP,
    output [7:0]            IO_SEV_SEG_AN 
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
  
  reg [7:0]     SEG_EN;         //segment enable lines from addr function decoder to sevensegtimer
  reg [31:0]    SEG7_4, SEG3_0; //segment digit lines from addr function decoder to sevensegtimer
  reg [7:0]     SEG_DP;         //DP enable lines from addr function decoder to sevensegtimer
  
  //7 segment address function decoder
  always @(posedge HCLK or negedge HRESETn)
   if (~HRESETn) begin
     SEG_EN <= 8'hff; //on reset de-assert all enables
   end else if (we)
     case (HADDR_d)
       //send lowest 8 bits from 8 bit enable register
       //addr [5:2] 4'h0 == addr [3:0] 0x0000 8 bit Enable Register ACTIVE LOW
       `H_7_SEG_EN_IONUM: SEG_EN <= HWDATA[7:0];
       
       //send 32 bits from segments 7-4 digit register
       //addr [5:2] 4'h1 == addr [3:0] 0x0004 32 bit Segment 7-4 digit reg
       `H_7_SEG_7_4_IONUM: SEG7_4 <= HWDATA[31:0];    
       
       //send 32 bits from segments 3-0 digit register
       //addr [5:2] 4'h2 == addr [3:0] 0x0008 32 bit Segment 3-0 digit reg
       `H_7_SEG_3_0_IONUM: SEG3_0 <= HWDATA[31:0];    
       
       //send lowest bits from 8 bit DP register
       //addr [5:2] 4'h3 == addr [3:0] 0x000C 8 bit DP register ACTIVE LOW
       `H_7_SEG_DP_IONUM: SEG_DP <= HWDATA[7:0];     
       
       //No default infers a latch, but I guess this is preferable
     endcase
 
 //Instantiate sevensegtimer connected to addr function decoder above and segment outputs
 mfp_ahb_sevensegtimer mfp_ahb_sevensegtimer(
     HCLK,                              // AHB clock
     HRESETn,                           // Bus reset
     SEG_EN,                            // 8 bits from enable register
     {SEG7_4, SEG3_0},                  // 64 bits from both 32 digit regsiters
     
     //outputs to display
     SEG_DP,                            // from DP reg
     IO_SEV_SEG_AN,                     // out to anodes
     {IO_SEV_SEG_DP, IO_SEV_SEG_CATH}   // out to cathodes, including DP
  );

endmodule
