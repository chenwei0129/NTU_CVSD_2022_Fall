`define OP            31:26
`define RS            25:21
`define RT            20:16
`define RD            15:11
`define CONS_ADDR     15:0
module core #(                             //Don't modify interface
	parameter ADDR_W = 32,
	parameter INST_W = 32,
	parameter DATA_W = 32
)(
	input                   i_clk,
	input                   i_rst_n,
	output     [ ADDR_W-1 : 0 ] o_i_addr,
	input      [ INST_W-1 : 0 ] i_i_inst,
	output reg                  o_d_wen,
	output reg [ ADDR_W-1 : 0 ] o_d_addr,
	output reg [ DATA_W-1 : 0 ] o_d_wdata,
	input      [ DATA_W-1 : 0 ] i_d_rdata,
	output reg [        1 : 0 ] o_status,
	output reg                  o_status_valid
);
  
  wire [ ADDR_W-1 : 0 ] o_i_addr_reg;
  wire [ DATA_W-1 : 0 ] o_d_wdata_reg;
  wire [ ADDR_W-1 : 0 ] o_d_addr_reg;
  wire o_d_wen_reg;
  wire [        1 : 0 ] o_status_reg;
  wire o_status_valid_reg;
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      o_d_wdata <= 32'd0;
      o_d_addr = 32'd0;
      o_d_wen <= 1'd0;
      o_status <= 2'd0;
      o_status_valid <= 1'd0;
    end else begin
      o_d_wdata <= o_d_wdata_reg;
      o_d_addr = o_d_addr_reg;
      o_d_wen <= o_d_wen_reg;
      o_status <= o_status_reg;
      o_status_valid <= o_status_valid_reg;
    end
  end
  
  wire [33:0] new_pc;
  wire [4:0] write_reg_addr;
  wire [31:0] write_reg_data;
  wire [31:0] reg_data1;
  wire [31:0] source2;
  wire [33:0] pc_normal;
  wire [33:0] pc_branch;
  wire [2:0] ALU_result_ctrl;
  wire [1:0] ALU_overflow_ctrl;
  wire get_inst;
  wire [1:0] ALUsrc;
  
  reg [31:0] ins_reg ;
  
  always@(posedge i_clk)begin
    ins_reg <= i_i_inst;
  end
  
  PC PC(.i_clk      (i_clk),
        .i_rst_n    (i_rst_n),
        .i_pc_update(pc_update),
        .i_pc       (new_pc[31:0]),
        .o_pc       (o_i_addr));

  regfile regfile(.i_clk       (i_clk),
                  .i_rst_n     (i_rst_n),
                  .i_wen       (Reg_wen),
                  .i_read_addr1(ins_reg[`RS]),
                  .i_read_addr2(ins_reg[`RT]),
                  .i_w_addr    (write_reg_addr),
                  .i_w_data    (write_reg_data),
                  .o_data1     (reg_data1),
                  .o_data2     (o_d_wdata_reg));

  ALU ALU(.i_src1         (reg_data1),
          .i_src2         (source2),
		      .i_ctrl_result  (ALU_result_ctrl),
		      .i_ctrl_overflow(ALU_overflow_ctrl),
		      .o_zero         (zero),
		      .o_answer       (o_d_addr_reg),
          .o_overflow     (ALU_overflow));

  adder adder0(.i_src1  ({2'b0, o_i_addr}),
               .i_src2  (34'd4),
               .o_result(pc_normal));

  adder adder1(.i_src1  (pc_normal),
               .i_src2  ({18'b0, ins_reg[`CONS_ADDR]}),
               .o_result(pc_branch));

  MUX_5 MUX0(.a(ins_reg[`RD]),
             .b(ins_reg[`RT]),
		         .s(RegDst),
		         .o(write_reg_addr));


  MUX3_32 MUX1(.a(o_d_wdata_reg),
               .b({{16{ins_reg[15]}}, ins_reg[`CONS_ADDR]}),
               .c({16'b0, ins_reg[`CONS_ADDR]}),
		           .s(ALUsrc),
		           .o(source2));
  
  MUX_34 MUX2(.a(pc_normal),
              .b(pc_branch),
              .s(Branch),
              .o(new_pc));

  MUX_32 MUX3(.a(o_d_addr_reg),
              .b(i_d_rdata),
              .s(MemtoReg),
              .o(write_reg_data));

  control control(.i_clk              (i_clk),
                  .i_opcode           (ins_reg[`OP]),
                  .i_rst_n            (i_rst_n),
                  .i_zero             (zero),
                  .i_new_pc           (new_pc),
                  .i_ALU_overflow     (ALU_overflow),
                  .o_RegDst           (RegDst),
                  .o_Branch           (Branch),
                  .o_MemWrite         (o_d_wen_reg),
                  .o_MemtoReg         (MemtoReg),
                  .o_ALUsrc           (ALUsrc),
                  .o_RegWrite         (Reg_wen),
                  .o_ALU_result_ctrl  (ALU_result_ctrl),
                  .o_ALU_overflow_ctrl(ALU_overflow_ctrl),
                  .o_pc_update        (pc_update),
                  .o_status           (o_status_reg),
                  .o_status_valid     (o_status_valid_reg));

// ---------------------------------------------------------------------------
// Wires and Registers
// ---------------------------------------------------------------------------
// ---- Add your own wires and registers here if needed ---- //



// ---------------------------------------------------------------------------
// Continuous Assignment
// ---------------------------------------------------------------------------
// ---- Add your own wire data assignments here if needed ---- //



// ---------------------------------------------------------------------------
// Combinational Blocks
// ---------------------------------------------------------------------------
// ---- Write your conbinational block design here ---- //



// ---------------------------------------------------------------------------
// Sequential Block
// ---------------------------------------------------------------------------
// ---- Write your sequential block design here ---- //



endmodule