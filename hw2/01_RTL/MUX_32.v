`timescale 1ns/100ps
module MUX_32(
  input [31:0] a,
  input [31:0] b,
  input s,
  
  output [31:0] o
);
  
  assign o = (s)?b:a;

endmodule
