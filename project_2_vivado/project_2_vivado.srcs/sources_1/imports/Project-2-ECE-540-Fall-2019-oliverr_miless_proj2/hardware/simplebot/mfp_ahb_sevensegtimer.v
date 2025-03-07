/*
 * Seven-segment display timer for the Nexys4 DDR board
 *
 * January 25, 2017
 * 
 * On August 9th, 2017
 * Modified by Srivatsa Yogendra to include the decimal points and to 
 * display special characters on the seven segment display.
 */

module mfp_ahb_sevensegtimer(
                     input            clk,          //AHB clock
                     input            resetn,       //AHB reset
                     input     [ 7:0] EN,           //digit enable register
                     input     [63:0] DIGITS,       //digit value registers
                     input     [ 7:0] dp,           //DP in reg
                     output    [ 7:0] DISPENOUT,    //This drives the anodes
                     output    [ 7:0] DISPOUT);     //DISPOUT drives the cathodes, with the MSb as the DP

  wire [15:0] cnt16;
  wire [ 2:0] cntSel;
  wire [ 7:0] en0, en1, en2, en3, en4, en5, en6, en7;
  wire [ 5:0] numout;

  assign en0 = (EN | 8'hfe);
  assign en1 = (EN | 8'hfd);
  assign en2 = (EN | 8'hfb);
  assign en3 = (EN | 8'hf7);
  assign en4 = (EN | 8'hef);
  assign en5 = (EN | 8'hdf);
  assign en6 = (EN | 8'hbf);
  assign en7 = (EN | 8'h7f);

  mfp_ahb_sevensegdec sevensegdec(.data(numout), .seg(DISPOUT));

  counter #(16) counter16(clk, resetn, cnt16);
  counter #(3)  counterSel(cnt16[15], resetn, cntSel);

  mux8    #(8) 	mux8_7segen(en0, en1, en2, en3, en4, en5, en6, en7,
                            cntSel, DISPENOUT);
  mux8    #(6) 	mux8_7segdigits({dp[0],DIGITS[4:0]},
                                {dp[1],DIGITS[12:8]},
                                {dp[2],DIGITS[20:16]},
                                {dp[3],DIGITS[28:24]},
                                {dp[4],DIGITS[36:32]},
                                {dp[5],DIGITS[44:40]},
                                {dp[6],DIGITS[52:48]},
                                {dp[7],DIGITS[60:56]},
                                cntSel, numout);

endmodule


// parameterized counter
module counter
#(parameter WIDTH=8)
(     input                    clk,
      input                    resetn,
      output reg [(WIDTH-1):0] cnt);

  always @(posedge clk, negedge resetn)
    if (~resetn) cnt <= 0;
    else         cnt <= cnt + 1;

endmodule


// 8-bit multiplexer
module mux8 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0]     d0, d1, d2, d3, d4, d5, d6, d7,
              input  [2:0]           s, 
              output reg [WIDTH-1:0] y);

  always @(*)
    case (s)
      3'b000:    y = d0;
      3'b001:    y = d1;
      3'b010:    y = d2;
      3'b011:    y = d3;
      3'b100:    y = d4;
      3'b101:    y = d5;
      3'b110:    y = d6;
      3'b111:    y = d7;
      default:   y = d0;
    endcase

endmodule

