//icon takes in the currect pixel address and the location of
//rojobot, and output the icon color

//the input resolution is 1024x768 and this is scaled down to
//512x512, which corresponds to the 128x128 world map, but is 
//higher resolution

module icon(
    //12 bit pix row(768) and column(1024)
    input [11:0] pix_row, pix_col,
    
    //info registers to determine location and orientation
    input [7:0] LocX_reg, LocY_reg, BotInfo_reg,

    //the icon's output for the current pixel
    output reg [1:0] icon_color,
    
    input clk
);

//scale resolution down to 512
//1024 --> 512 == 2
//768  --> 512 == 1.5

wire [8:0] column, row;

// shift pix column to right to divide by 2
// 1024 / 2 = 512 
assign column = pix_col[9:1];

//To get 512 from 768, we multiply the pix row by 2 with a 
//left shift and then divide by 3 with a lut divide module
// ( 768 * 2 ) / 3 = 512
integer_divide_lut #(12, 3) div(
    //multiply dividend by 2 with left shift
    .dividend({pix_row[10:0], 1'b0}),    
    
    //grab the lowest 9 bits for the 512 output
    .quotient(row[8:0])   
);

//scale 7 bit 128x128 location to 9 bit 512x512 pixel space
wire [8:0] loc_x, loc_y;

//vars to keep track of icon tile extents
wire [8:0] xmin, xmax, ymin, ymax;

//size of the icon tile square in bits, 4bits ==16
parameter tile = 4;

//multiply by 2 with 2 bit left shift
assign loc_x = {LocX_reg,2'b00}; 
assign loc_y = {LocY_reg,2'b00}; 

//set tile boundaries. 
//2**(tile-1) == half of tile width
//2**(5-1) == 8 
assign xmin = loc_x - (2**(tile-1));
assign xmax = loc_x + (2**(tile-1)) - 1;
assign ymin = loc_y - (2**(tile-1));
assign ymax = loc_y + (2**(tile-1)) - 1;

//16x16x2 icon, 16 rows, 32 bits each
reg [(2**(tile+1))-1:0] icon [(2**tile)-1:0];
reg [(2**(tile+1))-1:0] icon_diag [(2**tile)-1:0];

//initialize tile values, these are generated 
//with an icon builder spreadsheet
initial begin
    $readmemh("/home/rew/icon.mem", icon, 0);
    $readmemh("/home/rew/icon_diag.mem", icon_diag, 0);
end


always @(posedge clk) begin
    //if current pixel is with the tiles extent,
    //out the pixel data for that tile pixel
    if(
        column >= xmin && 
        column <= xmax && 
        row >= ymin && 
        row <= ymax
    ) 
        //select bits from icon based on current position
        //I have to do it in this weird way because you can't
        //do a multiple bit select with a variable?
       
        case(BotInfo_reg[2:0])
            //NORTH
            3'h0: icon_color <= { icon       [ row-ymin ]    [ (2*(column-xmin))+1 ],    icon[ row-ymin ]        [ 2*(column-xmin) ] }; 
            
            //NORTHEAST
            3'h1: icon_color <= { icon_diag  [ row-ymin ]    [ (2*(column-xmin))+1 ],    icon_diag[ row-ymin ]   [ 2*(column-xmin) ] }; 
            
            //EAST == right 90, flip x and y, then read columns backwards
            3'h2: icon_color <= { icon       [ xmax-column ] [ (2*(row-ymin))+1 ],       icon[ xmax-column ]     [ 2*(row-ymin) ] }; 
            
            //SOUTHEAST
            3'h3: icon_color <= { icon_diag  [ xmax-column ] [ (2*(row-ymin))+1 ],       icon_diag[ xmax-column ][ 2*(row-ymin) ] }; 
            
            //SOUTH == 180, read columns and rows backwards
            3'h4: icon_color <= { icon       [ ymax-row ]    [ (2*(xmax-column))+1 ],    icon[ ymax-row ]        [ 2*(xmax-column) ] }; 
            
            //SOUTHWEST
            3'h5: icon_color <= { icon_diag  [ ymax-row ]    [ (2*(xmax-column))+1 ],    icon_diag[ ymax-row ]   [ 2*(xmax-column) ] }; 
          
            //WEST == left 90, flip x and y, read rows backwards
            3'h6: icon_color <= { icon       [ column-xmin ] [ (2*(ymax-row))+1 ],       icon[ column-xmin ]     [ 2*(ymax-row) ] }; 
            
            //NORTHWEST
            3'h7: icon_color <= { icon_diag  [ column-xmin ] [ (2*(ymax-row))+1 ],       icon_diag[ column-xmin ][ 2*(ymax-row) ] }; 
            
            default: icon_color <= 2'b00;
         endcase

    //otherwise output 0 so the background shows
    else
        icon_color <= 2'b00;

end
endmodule