`timescale 1ns/100ps
module MUX3_32(
  input [31:0] a,
  input [31:0] b,
  input [31:0] c,
  input [1:0]  s,
  
  output [31:0] o
);
  
  assign o = (s==2'd2)?b:
             (s==2'd1)?c:
             a;

endmodule
