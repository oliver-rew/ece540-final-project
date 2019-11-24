`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 11:36:59 AM
// Design Name: 
// Module Name: cam_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cam_decoder_tb();
    reg clk = 0;
    
    reg rst = 0;
    wire [31:0] addr, col, row;
    reg vsync, hsync;
    wire [7:0] dout;
    reg [7:0] din;
    wire we;

    parameter COL_MAX = 640;
    
    //test_pattern test(clk, rst, addr, data, col, row);
        camera_decoder cam(
        .pixclk(clk),
        .vsync(vsync), //active high vsync
        .hsync(hsync), //active high hsync
        .reset(rst), //active high reset
        .din(din), // D11, D10, D9, D8, D7, D6, D5, D4
        .addr(addr), //pix counter (address) to write to 1D BRAM
        .dout(dout),
        .we(we),
        .col(col),
        .row(row)
    );
    
    //assign din = addr;
    
    always @(posedge clk)
        if (rst)
            din <= 8'h00;
        else if (hsync && vsync)
            din <= din + 1;

   
    reg [31:0] i;  
    initial begin

        rst = 1'b1; //enable write enable
        vsync = 1'b0;
        hsync = 1'b0;
        @(negedge clk);
        
        $monitor("HSYNC: %b\tVSYNC: %b\tADDR: %d\tDIN: %d\tDOUT: %d", hsync, vsync, addr, din, dout);
        
        rst = 1'b0;
        @(negedge clk);
        @(negedge clk);;
        vsync = 1'b1;
        
        repeat(6) @(negedge clk);
        
        hsync = 1'b1;
        
        repeat(700) @(negedge clk);
        
        hsync = 1'b0;
        
        repeat(6) @(negedge clk);
        
        hsync = 1'b1;
        
        repeat(700) @(negedge clk);
        
        vsync = 1'b0;
        hsync = 1'b0;
         
        repeat(50) @(negedge clk);
        
        vsync = 1'b1;
        
        repeat(6) @(negedge clk);
        
        hsync = 1'b1;
        
        repeat(700) @(negedge clk);
        
        $finish;
    end
   
    
  // Instantiate free running clock per half cycle width defined above
  initial begin 
    clk = 1'b0;
    forever #1 clk = ~clk;
  end
  
//  task clk_pulse;
//  begin
//  if (hsync && vsync)
//    din <= din + 1;
//  @(negedge clk);
//  end
//endtask
    
endmodule
