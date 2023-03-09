module PE_h(
  input signed [11:0] llr_1_i,
  input signed [11:0] llr_2_i,
  input frozen_1_i,
  input frozen_2_i,
  output u_1_o,
  output u_2_o
);
  
  wire sign = llr_1_i[11] ^ llr_2_i[11];
  assign u_1_o = sign & ~frozen_1_i;
  
  wire signed [11:0] llr_1_c = (llr_1_i[11])?~llr_1_i+$signed(12'd1):llr_1_i;
  wire signed [11:0] llr_2_c = (llr_2_i[11])?~llr_2_i+$signed(12'd1):llr_2_i;
  wire comp = (llr_1_c[10:0]>llr_2_c[10:0])?1'b1:1'b0;
  
  wire t1 = llr_2_i[11] & ~frozen_1_i;
  wire t2 =  comp & ~frozen_2_i;
  wire t3 = ~comp & ~frozen_2_i;
  wire t4 = t1 & t2;
  wire t5 = llr_1_i[11] & frozen_1_i;
  wire t6 = t2 & t5;
  wire t7 = llr_2_i[11] & t3;
  wire t8 = t4 | t6;
  assign u_2_o = t7 | t8;
  
endmodule
