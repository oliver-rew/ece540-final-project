//colorizer takes in the world color and the icon color for
//the current pixel and output the correct RGB VGA value
module colorizer(
   output reg [3:0] vga_r, vga_g, vga_b,
   input [1:0] world_color, icon_color,
   input video_on
);

    //world color keys
    parameter wc_back_key   = 2'b00;
    parameter wc_line_key   = 2'b01;
    parameter wc_obs_key    = 2'b10;
    parameter wc_res_key    = 2'b11;
    
    //icon color keys
    parameter icon_trans_key    = 2'b00; 
    parameter icon1             = 2'b01;
    parameter icon2             = 2'b10;
    parameter icon3             = 2'b11;   
    
    //colors represented as 12 bit fields composed of 4 bits
    //each red, green, and blue, respectively
    parameter white     = 12'hfff; //white reserved
    parameter green     = 12'h0f0; //green obstructions
    parameter black     = 12'h000; //black line
    parameter red       = 12'hf00; //red background
    parameter blue      = 12'h00f; //blue
    parameter yellow    = 12'hff0; //red + green == yellow
    parameter violet    = 12'hf0f; //red + blue == violet
    parameter teal      = 12'h0ff; //blue + green == teal
    
    always @(*)
        //if video of the RGB output should be all low
        if(~video_on)
            {vga_r, vga_g, vga_b} = black;
            
        //if icon color is transparent, display the world color
        else if(icon_color == icon_trans_key)
            case(world_color)
                wc_back_key : {vga_r, vga_g, vga_b} = blue;
                wc_line_key : {vga_r, vga_g, vga_b} = black;
                wc_obs_key  : {vga_r, vga_g, vga_b} = green; 
                wc_res_key  : {vga_r, vga_g, vga_b} = white;
                default     : {vga_r, vga_g, vga_b} = white;
            endcase
            
         //else display the icon color
         else
            case(icon_color)
                icon1       : {vga_r, vga_g, vga_b} = blue;
                icon2       : {vga_r, vga_g, vga_b} = yellow;
                icon3       : {vga_r, vga_g, vga_b} = violet;
                default     : {vga_r, vga_g, vga_b} = white;
            endcase
endmodule