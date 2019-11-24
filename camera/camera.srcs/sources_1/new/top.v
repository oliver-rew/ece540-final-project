
module mfp_nexys4_ddr( 
    input                   CLK100MHZ,
    input                   CPU_RESETN,
    input                   BTNU, BTND, BTNL, BTNC, BTNR, 
    input  [15 :0] SW,
    output [15:0] LED,
    
    //Seven Seg Display Outputs
    output                  CA, CB, CC, CD, CE, CF, CG,
    output                  DP,
    output [ 7          :0] AN,
    
    inout  [ 8          :1] JB,
    input                   UART_TXD_IN,
    
    //vga signals
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS, VGA_VS,
    
    //JA pins for I2C TODO should these both be inout?
    inout [8:1] JA, //JA1 = SCL, JA2 = SDA
    /*
    JA1 : VSYNC
    JA2 : D7
    JA3 : D9
    JA4 : D11
    JA5 : HSYNC
    JA6 : D8
    JA7 : D10
    JA8 : PIXCLK
    */
    
    input [8:1] JX
    /*
    JX1 : GPIO1
    JX2 : SDA
    JX3 : EXT CLK
    JX4 : D5
    JX5 : GPIO7
    JX6 : SCL
    JX7 : D4
    JX8 : D6
    */
    

);
/*
TODO
- handle BRAM enable and write enable signals
- put in own file for portability
*/
    
    wire clk_31_5MHz, clk_10MHz;

    clk_wiz_1 instance_name(
        // Clock out ports
        .clk_31_5MHz(clk_31_5MHz),     // output clk_31_5_Mhz
        .clk_10MHz(clk_10MHz),     // output clk_10MHz
        // Clock in ports
        .clk_in1(CLK100MHZ)
    );      

    // absolute, current VGA pixel. can be used to address BRAM
    // since BRAM is 64 bit words holding 16 pixel shift pix_num
    // 4 places to the right to get the current word. The lowest
    // 4 bits will be used to address to pixel within the words
    wire [31:0] pix_num;
    wire [18:0] addra; 
    wire [3:0] dina; 
    wire [3:0] pix_val;
    
    test_pattern test(clk_10MHz, ~CPU_RESETN, addra, dina);
    
    //307,200 x 4 BRAM  640 x 480 x 4b Frame Buffer
    //640 x 480 x 4b = 1,228,800b
    //1,228,800 / 4 = 307,200 
    blk_mem_gen_0 bram (
        .clka(clk_10MHz),    // input wire clka
        .ena(1'b1),      // input wire ena
        .wea(1'b1),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [18 : 0] addra
        .dina(dina),    // input wire [3 : 0] dina
        .clkb(clk_31_5MHz),    // input wire clkb
        .enb(1'b1),      // input wire enb
        .addrb(pix_num[18:0]),  // hook pix num directly into the addr port
        .doutb(pix_val)  // output wire [3 : 0] doutb
    );
    
    wire video_on;
    
    dtg dtg(
        .clock(clk_31_5MHz),
        .rst(~CPU_RESETN), 
        .video_on(video_on), //TODO connect this to something
        .horiz_sync(VGA_HS), 
        .vert_sync(VGA_VS),
        .pixel_row(), //1024
        .pixel_column(), //768
        .pix_num(pix_num)
    );
    
    // since this is a monochrome sensor, assign all pixels the same value
    assign VGA_R = video_on ? pix_val: 4'h0;
    assign VGA_G = video_on ? pix_val: 4'h0;
    assign VGA_B = video_on ? pix_val: 4'h0;
    
//    assign VGA_R = video_on ? SW[3:0]: 4'h0;
//    assign VGA_G = video_on ? SW[3:0]: 4'h0;
//    assign VGA_B = video_on ? SW[3:0]: 4'h0;

endmodule





//    //TODO make this a module and test it
//    //Test pattern generator
//    always @(posedge clk_10MHz) begin
//        if(~CPU_RESETN) begin
//            test_col <= 0;
//            test_row <= 0;
//            test_addr <= 0;
//        end
//        else begin
//            if (test_addr >= ADDR_MAX)  
//                test_addr <= 32'b0;
//            else
//                test_addr <= test_addr + 32'b1;
                
//            addra <= test_addr[19:4];
//            test_word_data <= 64'h0123_4567_89AB_CDEF; //color bars
//        end
//     end
    
/*    //TODO make this a module and test it
    //Test pattern generator
    always @(posedge clk_10MHz) begin
        if(~CPU_RESETN) begin
            test_col <= 0;
            test_row <= 0;
            test_addr <= 0;
        end
        else begin
            //increment and wrap the test address, column, and row
            if (test_addr >= ADDR_MAX)  
                test_addr <= 32'b0;
            else
                test_addr <= test_addr + 32'b1;
                
            if (test_col >= COL_MAX)
                test_col <= 10'b0;
            else
                test_col <= test_col + 10'b1;
                
            if (test_row >= ROW_MAX)
                test_row <= 10'b0;
            else
                test_row <= 10'b1;
                
            // assign to the pixel based on the 4 LSb of the address
            case(test_addr[3:0])
                4'h0 : test_word[3:0] <= test_col[9:6];
                4'h1 : test_word[7:4] <= test_col[9:6];
                4'h2 : test_word[11:8] <= test_col[9:6];
                4'h3 : test_word[15:12] <= test_col[9:6];
                4'h4 : test_word[19:16] <= test_col[9:6];
                4'h5 : test_word[23:20] <= test_col[9:6];
                4'h6 : test_word[27:24] <= test_col[9:6];
                4'h7 : test_word[31:28] <= test_col[9:6];
                4'h8 : test_word[35:32] <= test_col[9:6];
                4'h9 : test_word[39:36] <= test_col[9:6];
                4'hA : test_word[43:40] <= test_col[9:6];
                4'hB : test_word[47:44] <= test_col[9:6];
                4'hC : test_word[51:48] <= test_col[9:6];
                4'hD : test_word[55:52] <= test_col[9:6];
                4'hE : test_word[59:56] <= test_col[9:6];
                4'hF : test_word[63:60] <= test_col[9:6];
            endcase
            
            // since we are filling up 64b, 16 pixel words, we can't write to
            // RAM until after the last pixel is recorded, but by that time the 
            // address counter will already be onto the next 64b word address. 
            // Thus, we keep a copy of the last address in 'addra', which is 
            // updated when we are on the last pixel of the word
            if (test_addr[3:0] == 4'hf)
                addra <= test_addr[19:4];
            
            // if the 3 LSb's of 'test_addr' are 0, we just finished a 16 pixel
            // word. In this case, write the test_word which we jsut constructed
            // the 'test_word_data', which is directly connected to the BRAM
            if (test_addr[3:0] == 4'h0)
                test_word_data <= test_word[19:4];
        end
    end*/

//    /*
//    49,152 x 64b BRAM frame buffer
//    1024x768x4b = 3,145,728 = 49,152 x 64b
//    */
//    blk_mem_gen_1 bram (
//        .clka(clk_10MHz),    // input wire clka
//        .ena(1'b1),      // input wire ena
//        .wea(1'b1),      // input wire [0 : 0] wea
//        .addra(addra),  // input wire [15 : 0] addra
//        .dina(test_word_data),    // input wire [63 : 0] dina
//        .clkb(clk_31_5MHz),    // input wire clkb
//        .enb(1'b1),      // input wire enb
        
//        // address BRAM output with VGA pixel address shifted
//        // 4 places to the right to divide by 16 because each
//        // 64 bit word holds 16 pixels
//        .addrb(pix_num[19:4]),  // input wire [15 : 0] addrb
//        .doutb(pixel_word)  // output wire [63 : 0] doutb
//    );

    //TODO try parallel case?
    //output the pixel value based one the current pixel offset within the pixel word
//    always @(posedge clk_31_5MHz) begin
//        if (video_on) begin
//            case(pix_num[3:0])
//                4'h0 : pix_val <= pixel_word[3:0];
//                4'h1 : pix_val <= pixel_word[7:4];
//                4'h2 : pix_val <= pixel_word[11:8];
//                4'h3 : pix_val <= pixel_word[15:12];
//                4'h4 : pix_val <= pixel_word[19:16];
//                4'h5 : pix_val <= pixel_word[23:20];
//                4'h6 : pix_val <= pixel_word[27:24];
//                4'h7 : pix_val <= pixel_word[31:28];
//                4'h8 : pix_val <= pixel_word[35:32];
//                4'h9 : pix_val <= pixel_word[39:36];
//                4'hA : pix_val <= pixel_word[43:40];
//                4'hB : pix_val <= pixel_word[47:44];
//                4'hC : pix_val <= pixel_word[51:48];
//                4'hD : pix_val <= pixel_word[55:52];
//                4'hE : pix_val <= pixel_word[59:56];
//                4'hF : pix_val <= pixel_word[63:60];
//                default: pix_val <= 4'h0;
//            endcase
//        end
//    end