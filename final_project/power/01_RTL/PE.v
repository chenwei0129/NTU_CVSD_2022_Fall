module PE(
  input clk_i,
  input signed [11:0] llr_1_i,
  input signed [11:0] llr_2_i,
  input sum_i,
  input select_i,
  output reg [11:0] result_o
);
  
  wire [11:0] f_result;
  
  wire signed [11:0] llr_1_2c = (llr_1_i[11])?~llr_1_i+$signed(12'd1):llr_1_i;
  wire        [10:0] llr_1_abs = llr_1_2c[10:0];
  
  wire signed [11:0] llr_2_2c = (llr_2_i[11])?~llr_2_i+$signed(12'd1):llr_2_i;
  wire        [10:0] llr_2_abs = llr_2_2c[10:0];
  
  wire [10:0] min = (llr_1_abs<llr_2_abs)?llr_1_abs:llr_2_abs;
  wire sign = llr_1_i[11] ^ llr_2_i[11];
  
  //assign result_o = {sign, min};
  assign f_result = (~sign)?{1'b0, min}:{1'b1, ~min}+12'd1;
  
  wire signed [12:0] g_result_temp;
  wire signed [11:0] g_result;
  //wire signed [11:0] llr_1_operated = ($signed(sum_i))?~llr_1_i+$signed(12'd1):llr_1_i;
  //assign g_result = llr_2_i + $signed(llr_1_operated);
  assign g_result_temp = (sum_i)?llr_2_i - llr_1_i:llr_2_i + llr_1_i;
  /*assign g_result = (g_result_temp[0]&&g_result_temp[12])?$signed(g_result_temp[12:1])+$signed(12'd1):
                    $signed(g_result_temp[12:1]);*/
  
  /*assign g_result = (g_result_temp[0]&&~g_result_temp[12])?$signed(g_result_temp[12:1])+$signed(12'd1):
                    $signed(g_result_temp[12:1]);*/
  
  assign g_result = ((g_result_temp[12]^g_result_temp[11])&&~g_result_temp[12])?12'b0_1111111_1111:// 2047
                    ((g_result_temp[12]^g_result_temp[11]) || g_result_temp[11:0]==12'b1_0000000_0000)?12'b1_0000000_0001://-2047
                    g_result_temp[11:0];
  
  wire [11:0] result_w = (select_i)?g_result:f_result;
  
  always@(posedge clk_i)begin
    result_o <= result_w;
  end
  //assign result_o = (select_i)?g_result:f_result;
  
endmodule