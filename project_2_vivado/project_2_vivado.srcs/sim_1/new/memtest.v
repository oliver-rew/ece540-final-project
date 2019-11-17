`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2019 12:48:54 AM
// Design Name: 
// Module Name: memtest
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


module memtest();
    parameter tile = 4;
    //reg [(2**(tile+1))-1:0] icon [(2**tile)-1:0];
    reg [31:0] icon [15:0];
    reg [tile:0] i, j;
    
    initial begin
        $display("HELLLLLLOOOOOO");
        $readmemh("/home/rew/icontest.mem", icon);
       for(i = 0 ; i < 2**tile ; i = i + 1)
        for(j = 0 ; j < 2**tile ; j = j + 1)      
            $display("i: %d\tj: %d\tval: 0b%b", i, j,{icon[i][(2*j)+1],icon[i][2*j]}); 
            
       $finish;
    end
endmodule
