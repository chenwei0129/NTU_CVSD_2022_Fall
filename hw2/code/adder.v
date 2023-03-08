`timescale 1ns/100ps
module adder(
  input [33:0] i_src1,
  input [33:0] i_src2,
  
  output [33:0] o_result
);
  
  assign o_result = i_src1 + i_src2;

endmodule
