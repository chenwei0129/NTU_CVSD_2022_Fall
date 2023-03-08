`timescale 1ns/100ps
module MUX_34(
  input [33:0] a,
  input [33:0] b,
  input s,
  
  output [33:0] o
);
  
  assign o = (s)?b:a;

endmodule
