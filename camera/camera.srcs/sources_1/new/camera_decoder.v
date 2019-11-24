`timescale 1ns / 1ps
//TODO COMMENTS
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2019 10:58:13 AM
// Design Name: 
// Module Name: camera_decoder
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

//TODO OMG TEST THIS PLEASE FOR THE LOVE OF GOD

module camera_decoder(
    input pixclk,
    input vsync, //active high vsync
    input hsync, //active high hsync
    input reset, //active high reset
    input [7:0] din,
    output memclk, //TODO might not need this
    output reg [31:0] addr, //pix counter (address) to write to 1D BRAM
    output reg [7:0] dout, //TODO I should just make this 8 bits
    output we,
    //TODO write enable?
    output reg [31:0] col,
    output reg [31:0] row
    );
    
    reg [31:0] pix_cnt;
    
    parameter COLS = 640, ROWS = 480;
    
    assign we = ((col <= COLS) && (row <= ROWS)) ? 1'b1 : 1'b0;
    
    //TODO this might be 1 greater than col index, so subtract maybe?
    //increment col on every clock when hsync and vsync are high
    always @(posedge pixclk)
        if (hsync & vsync)
            col <= col + 1;
        else 
            col <= 0;
            
        //TODO this might be 1 greater than col index, so subtract maybe?
    //increment col on every clock when hsync and vsync are high
    always @(posedge pixclk)
        if (~vsync)
            row <= 0;
        else if (col == COLS - 1)
            row <= row + 1;
    
    always @(posedge pixclk) begin
        //TODO keeping this requires "set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets buf_clk]" in XDC file
        //delay the address so it aligns with the data
        addr <= pix_cnt;
        
        if (reset) begin
            pix_cnt <= 0;
            dout <= 0;
        end 
        
        //TODO There is definitely an off by one error here
        
        // if VSYNC is low, reset the address counter because the 
        // next frame hasn't started yet        
        else if (~vsync) begin
            pix_cnt <= 0;
            dout <= 4'hf; //TODO FIX, output data here as white to detect out of sync pixels
        end
        
        // increment address on every pixel clock when vsync and hsync are both high
        // and when we are with the desired frame i.e. we
        //TODO not sure I need to decrement rows here
        else if (vsync && hsync && ((col <= COLS - 1) && (row <= ROWS - 1))) begin
            pix_cnt <= pix_cnt + 32'b1;
            dout <= din;        
        end
        
    end
endmodule
