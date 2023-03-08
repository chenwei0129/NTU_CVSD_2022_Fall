`timescale 1ns/100ps
module control(
  input        i_clk,
  input [5:0]  i_opcode,
  input        i_rst_n,
  input        i_zero,
  input [33:0] i_new_pc,
  input        i_ALU_overflow,
  
  output           o_RegDst,
  output           o_Branch,
  output           o_MemWrite,
  output           o_MemtoReg,
  output     [1:0] o_ALUsrc,
  output           o_RegWrite,
  output reg [2:0] o_ALU_result_ctrl,
  output reg [1:0] o_ALU_overflow_ctrl,
  output           o_pc_update,
  output [1:0]     o_status,
  output           o_status_valid
);
  
  parameter  RST = 3'b000,
             IF  = 3'b001,
             ID  = 3'b010,
             EX  = 3'b011,
             MEM = 3'b100,
             WB  = 3'b101;
  
  reg [2:0] state;
  reg [2:0] n_state;
  wire overflow;
  wire overflow_2;
  //wire overflow_3;
  
  assign overflow = (i_ALU_overflow || overflow_2) && (state==EX);            //overflow occur, trigger the signal on state EX
  assign overflow_2 = (i_new_pc>34'd4095 && (i_opcode==6'd11&&i_zero || i_opcode==6'd12&&(~i_zero)))?1'b1:1'b0;                                        //I memory overflow
  //assign overflow_3 = (i_dmem_addr>33'd255 && (i_opcode==6'd6 || i_opcode==6'd7))?1'b1:1'b0;//D memory overflow
  
  assign o_status = (overflow)?2'd2:
                    (i_opcode==6'd14)?2'd3:
                    (i_opcode==6'd5 || i_opcode==6'd6 || i_opcode==6'd7 || i_opcode==6'd11 || i_opcode==6'd12)?2'd1:
                    2'd0;
  assign o_status_valid = (state==EX);
  
  //wire op_o_ALUsrc1 = (i_opcode==6'd5 || i_opcode==6'd6 || i_opcode==6'd7);
  //wire op_o_ALUsrc2 = i_opcode==6'd11 || i_opcode==6'd12;
  wire op_reg_write = (i_opcode!=6'd7 && i_opcode!=6'd11 && i_opcode!=6'd12 && i_opcode!=6'd14);//need to write data to register file
  
  assign o_RegDst = (i_opcode==6'd5 || i_opcode==6'd6)?1'b1:1'b0;
  assign o_Branch = (i_opcode==6'd11 && i_zero || i_opcode==6'd12 && ~i_zero)?1'b1:1'b0;
  assign o_MemWrite = (i_opcode==6'd7 && state==EX && ~overflow)?1'b1:1'B0;
  assign o_MemtoReg = (i_opcode==6'd6)?1'b1:1'b0;
  assign o_ALUsrc = (i_opcode==6'd5)?                  2'd2:
                    (i_opcode==6'd6 || i_opcode==6'd7)?2'b1:
                    2'd0;
  assign o_RegWrite = (op_reg_write && state==WB)?1'b1:1'b0;
  assign o_pc_update = (state==MEM)?1'b1:1'b0;
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      state <= RST;
    end else begin
      state <= n_state;
    end
  end
  
  always@(*)begin
    case(state)
      RST:n_state = (~i_rst_n)?RST:IF;
      IF :n_state = ID;
      ID :n_state = EX;
      EX :n_state = MEM;
      MEM:n_state = WB;
      WB :n_state = IF;
      default:n_state = RST;
    endcase
  end
  
  always@(*)begin
    o_ALU_result_ctrl = (i_opcode==6'd1 || i_opcode==6'd5)?                  3'd0://signed add
                        (i_opcode==6'd2)?                                    3'd1://signed sub
                        (i_opcode==6'd3 || i_opcode==6'd6 || i_opcode==6'd7)?3'd2://unsigned add
                        (i_opcode==6'd4)?                                    3'd3://unsigned sub
                        (i_opcode==6'd8)?                                    3'd4://AND
                        (i_opcode==6'd9)?                                    3'd5://OR
                        (i_opcode==6'd10)?                                   3'd6://NOR
                        (i_opcode==6'd13)?                                   3'd7://SLT
                        3'd0;                                                     //other, don't care
    
    o_ALU_overflow_ctrl = (i_opcode==6'd1 || i_opcode==6'd2 || i_opcode==6'd5)                    ?2'd0://signed overflow
                          (i_opcode==6'd3 || i_opcode==6'd4)                                      ?2'd1://unsigned overflow
                          (i_opcode==6'd6 || i_opcode==6'd7)                                      ?2'd2://D memory overflow
                          (i_opcode==6'd8 || i_opcode==6'd9 || i_opcode==6'd10 || i_opcode==6'd13)?2'd3://no overflow
                          2'd0;                                                                         //other, don't care
  end
  
endmodule
