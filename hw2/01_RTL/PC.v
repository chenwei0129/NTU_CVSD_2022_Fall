`timescale 1ns/100ps
module PC(
  input i_clk,
  input i_rst_n,
  input i_pc_update,
  input [31:0] i_pc,
  
  output reg [31:0] o_pc
);
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
	    o_pc <= 32'b0;
    end else if(i_pc_update)begin
      o_pc <= i_pc;
    end
  end

endmodule
