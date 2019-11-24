module test_pattern(
    input clk, 
    input reset, //active high reset
    output reg [18:0] addr, //current pixel num == (row * 640) + col
    output [3:0] data,
    output reg [9:0] col,
    output reg [9:0] row
);
    parameter COL_MAX = 640;
    parameter ROW_MAX = 480;
    parameter ADDR_MAX = COL_MAX * ROW_MAX;
    
    reg [3:0] val;
    
    assign data = val;
    
    //assign data = col[9:6];
    
    always @(posedge clk) begin
        if(reset) begin
            col <= 0;
            row <= 0;
            addr <= 0;
        end
        else begin
            //increment and wrap the test address, column, and row
            if (addr < ADDR_MAX - 1)  
                addr <= addr + 32'b1;
            else
                addr <= 32'b0;
                
                
            if (col < COL_MAX - 1)
                col <= col + 10'b1;
            else
                col <= 10'b0;
                
            //increment at end of row
            if ((row < ROW_MAX - 1) && (col == COL_MAX - 1))
                row <= row + 10'b1;
            
            //wrap
            else if((row == ROW_MAX - 1)  && (col == COL_MAX - 1))
                row <= 10'b0;
                
            // divide column into 4 quadrants and assign 
            // to the 2 LSb's of the output 
            if (col < (COL_MAX>>2)) 
                val[1:0] <= 4'h0;
            else if (col < (COL_MAX>>1))
                val[1:0] <= 4'h1;
            else if (col < (COL_MAX - (COL_MAX>>2)))
                val[1:0] <= 4'h2;
            // this case is critical, otherwise we the last value in the row
            // is displayed as the first value in the row
            else if (col < COL_MAX - 1)  
                val[1:0] <= 4'h3;  
            else
                val[1:0] <= 4'h0;    
                
            // divide row into 4 quadrants and assign 
            // to the 2 MSb's of the output 
            if (row < (ROW_MAX>>2)) 
                val[3:2] <= 4'h0;
            else if (row < (ROW_MAX>>1))
                val[3:2] <= 4'h1;
            else if (row < (ROW_MAX - (ROW_MAX>>2)))
                val[3:2] <= 4'h2;
            // this case is critical, otherwise we the last value in the row
            // is displayed as the first value in the row
            else if (row < ROW_MAX - 1)  
                val[3:2] <= 4'h3;  
            else
                val[3:2] <= 4'h0;    
                
            
                
                
        end
    end

endmodule