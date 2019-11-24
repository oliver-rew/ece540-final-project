module test_pattern_tb();
    reg clk = 0;
    
    reg rst = 0;
    wire [3:0] data;
    wire [9:0] col, row;
    wire [18:0] addr;

        parameter COL_MAX = 640;
    
    test_pattern test(clk, rst, addr, data, col, row);
   
    reg [31:0] i;  
    initial begin

        rst = 1'b1; //enable write enable
        clk_pulse;
        clk_pulse;
        rst = 1'b0;
        
        //run through a bunch of frames to ensure the count stays in sync with the pixel address
        for( i = 0; i < 2**10; i = i + 1) begin
            $display("ROW: %d\tCOL: %d\tADDR: %d\tDATA: %d", row, col, addr, data);
                if (((row * 640) + col) != addr)
                    $fatal;
            clk_pulse;
        end   
        $display("val: %d", COL_MAX>>1);
        $display("val: %d", COL_MAX>>2);
        $display("val: %d", (COL_MAX>>1) - (COL_MAX>>2));
    end
    
task clk_pulse;
  begin
  #1 clk = 1; 
  #1 clk = 0;
  end
endtask
endmodule