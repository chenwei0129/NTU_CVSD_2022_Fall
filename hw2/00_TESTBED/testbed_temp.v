`timescale 1ns/100ps
`define CYCLE       10.0
`define HCYCLE      (`CYCLE/2)
`define MAX_CYCLE   120000

`ifdef p0
    `define Inst "../00_TESTBED/PATTERN/p0/inst.dat"
`endif

module testbed;

	wire clk, rst_n;
	wire [ 31 : 0 ] imem_addr;
	wire [ 31 : 0 ] imem_inst;
	wire            dmem_wen;
	wire [ 31 : 0 ] dmem_addr;
	wire [ 31 : 0 ] dmem_wdata;
	wire [ 31 : 0 ] dmem_rdata;
	wire [  1 : 0 ] mips_status;
	wire            mips_status_valid;

	initial $readmemb (`Inst, u_inst_mem.mem_r);

	core u_core (
		.i_clk(),
		.i_rst_n(),
		.o_i_addr(),
		.i_i_inst(),
		.o_d_wen(),
		.o_d_addr(),
		.o_d_wdata(),
		.i_d_rdata(),
		.o_status(),
		.o_status_valid()
	);

	inst_mem  u_inst_mem (
		.i_clk(),
		.i_rst_n(),
		.i_addr(),
		.o_inst()
	);

	data_mem  u_data_mem (
		.i_clk(),
		.i_rst_n(),
		.i_wen(),
		.i_addr(),
		.i_wdata(),
		.o_rdata()
	);





endmodule



