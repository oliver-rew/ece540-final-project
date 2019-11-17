//configurable width integer divide LUT
//divisor must be specified at compile time
module integer_divide_lut(
  dividend,
  quotient
);
  //LUT bit width
  parameter width = 8;
  
  parameter divisor = 3;
  
  input [width-1:0] dividend;
  output reg [width-1:0] quotient;

  reg [width-1:0]lut[2**width:0];

  //generate LUT
  reg [width:0] i;
  initial
    for(i = 0 ; i < 2**width ; i = i + 1)
      lut[i] = i/divisor;

  //output from LUT based on dividend
  always @(dividend)
    quotient = lut[dividend];

endmodule

