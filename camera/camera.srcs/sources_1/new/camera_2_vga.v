module camera_2_vga(
    // control inputs
    input reset, //active high reset
    input test,  //active high test mode enable

    //camera inputs
    input pix_clk,          // camera pixel clock
    input cam_vsync,        // active high vsync
    input cam_hsync,        // active high hsync
    input [7:0] cam_data,   // 8 bit camera data
    
    // VGA clock and outputs
    input vga_clk, //31.5MHz for 640x480
    output [3:0] vga_r, vga_g, vga_b,
    output vga_vs, vga_hs
);
    
    wire [31:0] cam_addr;
    wire [7:0] dout;
    wire cam_we;
    camera_decoder cam(
        .pixclk(pix_clk),
        .vsync(cam_vsync),  //active high vsync
        .hsync(cam_hsync),  //active high hsync
        .reset(reset),      //active high reset
        .din(cam_data),     // D11-4
        .addr(cam_addr),    //pix counter (address) to write to 1D BRAM
        .dout(dout), 
        .we(cam_we)
    );

    wire [31:0] pix_num;//BRAM output address
    wire [18:0] addra;  //BRAM input address
    wire [3:0] dina;    //BRAM pixel input
    wire [3:0] pix_val; //BRAM pixel output
    wire in_clk;        //BRAM input clock
    wire we;            //BRAM write enable
    
    wire [18:0] test_addr; 
    wire [3:0] test_data; 
    test_pattern test_gen(vga_clk, reset, test_addr, test_data);
    
    //assign to the BRAM based on switch
    assign in_clk   = test ? vga_clk : pix_clk;
    assign dina     = test ? test_data : dout[7:4];
    assign addra    = test ? test_addr : cam_addr;
    assign we       = test ? 1'b1 : cam_we;
    
    //307,200 x 4 BRAM  640 x 480 x 4b Frame Buffer
    //640 x 480 x 4b = 1,228,800b
    //1,228,800 / 4 = 307,200 
    blk_mem_gen_0 bram (
        .clka(in_clk),          // pixel input clock
        .ena(1'b1),             // enabled always assert because we use write enable
        .wea(we),               // write enable from camera decoder
        .addra(addra),          // BRAM input address
        .dina(dina),            // BRAM input data
        .clkb(vga_clk),         // VGA clock for BRAM output
        .enb(1'b1),             // output can always be enabled
        .addrb(pix_num[18:0]),  // hook pix num directly into the addr port
        .doutb(pix_val)         // VGA pixel value
    );
    
    wire video_on;
    
    dtg dtg(
        .clock(vga_clk),
        .rst(reset), 
        .video_on(video_on), //TODO connect this to something
        .horiz_sync(vga_hs), 
        .vert_sync(vga_vs),
        .pix_num(pix_num)
    );
    
    // since this is a monochrome sensor, assign all pixels the same value
    assign vga_r = video_on ? pix_val: 4'h0;
    assign vga_g = video_on ? pix_val: 4'h0;
    assign vga_b = video_on ? pix_val: 4'h0;

endmodule