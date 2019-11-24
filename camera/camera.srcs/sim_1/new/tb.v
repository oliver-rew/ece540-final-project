`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2019 11:11:47 PM
// Design Name: 
// Module Name: tb
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


module tb();
    reg clk = 0;
        /*
    38400 x 32 block RAM
    This can hold 1280 x 960 4 bit pixels. Each line is 
    40 x 32 bit chunks with 8 pixels each
    */
    
    reg [15:0] addra, addrb;
    reg [31:0] dina, temp;
    wire [31:0] doutb;
    reg we;
    
    blk_mem_gen_0 bram (
      .clka(clk),    // input wire clka
      .ena(1'b1),      // input wire ena
      .wea(we),      // input wire [0 : 0] wea
      .addra(addra),  // input wire [15 : 0] addra
      .dina(dina),    // input wire [31 : 0] dina
      .clkb(clk),    // input wire clkb
      .enb(1'b1),      // input wire enb
      .addrb(addrb),  // input wire [15 : 0] addrb
      .doutb(doutb)  // output wire [31 : 0] doutb
    );
    reg [15:0] i;  
    initial begin

        we = 1'b1; //enable write enable
        
        for( i = 0; i < 38400; i = i + 1) begin
            addra = i;
            dina = i;
            clk_pulse;
        end
        
        clk_pulse;
        we = 1'b0; //disable write enable
        clk_pulse;
        
        for( i = 0; i < 38400; i = i + 1) begin
            addrb = i;
            clk_pulse;
            clk_pulse; //NEED 2 Cycles for data to come out?
            temp = doutb;
            $display("ADDR: %x\tDATA: %d", i, temp);
            
        end        
    end
   
        
    
    
    
    task clk_pulse;
  begin
  #10 clk = 1; 
  #10 clk = 0;
  end
endtask
endmodule
