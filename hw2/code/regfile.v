`timescale 1ns/100ps
module regfile(
  input        i_clk,
  input        i_rst_n,
  input        i_wen,
  input [4:0]  i_read_addr1,
  input [4:0]  i_read_addr2,
  input [4:0]  i_w_addr,
  input [31:0] i_w_data,
  
  output reg [31:0] o_data1,
  output reg [31:0] o_data2
);
  
  reg [31:0] REGFILE [0:31];
  
  integer i;
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      for(i=0;i<32;i=i+1)begin
        REGFILE[i] <= 32'b0;
      end
    end else if(i_wen)begin
      REGFILE[i_w_addr] <= i_w_data;
    end
  end

  always@(posedge i_clk)begin
    o_data1 <= REGFILE[i_read_addr1];
    o_data2 <= REGFILE[i_read_addr2];
  end

endmodule
