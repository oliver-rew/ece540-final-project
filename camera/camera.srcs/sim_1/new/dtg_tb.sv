module dtg_tb();
    reg clk = 0;
    
    reg rst = 0;
    wire video_on;
    wire [11:0] pix_row, pix_col;
    wire [31:0] pix_num;
    
    dtg dtg(
        .clock(clk),
        .rst(rst), 
        .video_on(video_on), //TODO connect this to something
        .horiz_sync(), 
        .vert_sync(),
        .pixel_row(pix_row), //1024
        .pixel_column(pix_col), //768
        .pix_num(pix_num)
    );
   
    reg [31:0] i;  
    initial begin

        rst = 1'b1; //enable write enable
        clk_pulse;
        clk_pulse;
        rst = 1'b0;
        
        //run through a bunch of frames to ensure the count stays in sync with the pixel address
        for( i = 0; i < 2**22; i = i + 1) begin
            $display("ROW: %d\tCOL: %d\tNUM: %d\tON: %b", pix_col, pix_row, pix_num, video_on);
            if(video_on)
                if (((pix_row * 640) + pix_col) != pix_num)
                    $fatal;
            clk_pulse;
        end   
    end
   
        
    
    
    
task clk_pulse;
  begin
  #1 clk = 1; 
  #1 clk = 0;
  end
endtask
endmodule