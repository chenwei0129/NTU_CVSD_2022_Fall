module ALU(
  input [31:0] i_src1,
  input [31:0] i_src2,
  input [2:0] i_ctrl_result,
  input [1:0] i_ctrl_overflow,
  
  output [31:0] o_answer,
  output reg o_overflow,
  output o_zero
);
  
  reg [32:0] answer_temp;
  
  assign o_answer = answer_temp[31:0];
  assign o_zero = (i_src1==i_src2);
  
  always@(*)begin
    case(i_ctrl_result)
      3'd0:answer_temp = $signed(i_src1) + $signed(i_src2);
      3'd1:answer_temp = $signed(i_src1) - $signed(i_src2);
      3'd2:answer_temp = i_src1 + i_src2;
      3'd3:answer_temp = $signed({1'b0, i_src1}) - $signed({1'b0, i_src2});
      3'd4:answer_temp = i_src1 & i_src2;
      3'd5:answer_temp = i_src1 | i_src2;
      3'd6:answer_temp = ~(i_src1 | i_src2);
      3'd7:answer_temp = ($signed(i_src1)<$signed(i_src2))?33'd1:33'd0;
      default:answer_temp = $signed(i_src1) + $signed(i_src2);
    endcase
  end
  
  always@(*)begin
    case(i_ctrl_overflow)
      2'd0:o_overflow = (answer_temp[32] ^ answer_temp[31])?1'b1:1'b0;
      2'd1:o_overflow = (answer_temp[32])?1'b1:1'b0;
      2'd2:o_overflow = (answer_temp>33'd255)?1'b1:1'b0;
      2'd3:o_overflow = 1'b0;
      default:o_overflow = 1'b0;
    endcase
  end
  
  /*
  always@(*)begin
    case(i_opcode)
      6'd1 :begin
        answer_temp = $signed(i_src1) + $signed(i_src2);
        o_overflow = (answer_temp[32] ^ answer_temp[31])?1'b1:1'b0;
      end
      6'd2 :begin
        answer_temp = $signed(i_src1) - $signed(i_src2);
        o_overflow = (answer_temp[32] ^ answer_temp[31])?1'b1:1'b0;
      end
      6'd3 :begin
        answer_temp = i_src1 + i_src2;
        o_overflow = (answer_temp[32])?1'b1:1'b0;
      end
      6'd4 :begin
        answer_temp = $signed({1'b0, i_src1}) - $signed({1'b0, i_src2});
        o_overflow = (answer_temp[32])?1'b1:1'b0;
      end
      6'd5 :begin
        answer_temp = $signed(i_src1) + $signed(i_src2);
        o_overflow = (answer_temp[32] ^ answer_temp[31])?1'b1:1'b0;
      end
      6'd6 :begin
        answer_temp = i_src1 + i_src2;
        o_overflow = (answer_temp>32'd255)?1'b1:1'b0;
      end
      6'd7 :begin
        answer_temp = i_src1 + i_src2;
        o_overflow = (answer_temp>32'd255)?1'b1:1'b0; 
      end
      6'd8 :begin
        answer_temp = i_src1 & i_src2;
        o_overflow = 1'b0;
      end
      6'd9 :begin
        answer_temp = i_src1 | i_src2;
        o_overflow = 1'b0;
      end
      6'd10:begin
        answer_temp = ~(i_src1 | i_src2);
        o_overflow = 1'b0;
      end
      6'd13:begin
        answer_temp = ($signed(i_src1)<$signed(i_src2))?33'd1:33'd0;
        o_overflow = 1'b0;
      end
      default:begin
        answer_temp = i_src1;
        o_overflow = 1'b0;
      end
    endcase
  end
  */
endmodule