/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : R-2020.09-SP5
// Date      : Sat Oct 29 17:48:49 2022
/////////////////////////////////////////////////////////////


module core ( i_clk, i_rst_n, i_op_valid, i_op_mode, o_op_ready, i_in_valid, 
        i_in_data, o_in_ready, o_out_valid, o_out_data );
  input [3:0] i_op_mode;
  input [7:0] i_in_data;
  output [12:0] o_out_data;
  input i_clk, i_rst_n, i_op_valid, i_in_valid;
  output o_op_ready, o_in_ready, o_out_valid;
  wire   outside, N121, N122, N123, N124, N125, N126, N127, N128, N129, N130,
         N131, N132, N133, N134, N135, N136, N137, N138, N139, N140, N164,
         N165, o_out_valid_pipeline_3, N171, N172, N173, N174, N175, N176,
         N177, N178, N179, N180, N181, N182, N183, N184, N185, N186, N187,
         N188, N189, N190, N191, N192, N193, N194, N195, N196, N197, N198,
         o_out_valid_pipeline_1, o_out_valid_pipeline_2, have_load, N222, N223,
         N224, N225, N226, N227, N228, N229, N233, N234, N235, N236, N237,
         N238, N239, N240, N241, N242, N243, N244, N245, N267, N268, N269,
         N270, N271, N272, N273, N274, N275, N276, N277, N278, N279, N280,
         N281, N282, N283, N284, N411, N412, N413, N486, N487, N488, N489,
         N490, N491, N492, N493, N551, N552, N553, N554, N555, N556, N557,
         N573, outside_pipeline_1, N579, N592, N593, N594, N595, N596, N597,
         N598, N599, n469, n479, n480, n481, n482, n484, n485, n494, n496,
         n497, n498, n499, n500, n501, n502, n503, n504, n505, n514, n515,
         n516, n524, n530, n531, n532, n533, n534, n535, n536, n537, n538,
         n539, n540, n541, n542, n543, n544, n545, n546, n547, n548, n549,
         n550, n5510, n5520, n5530, n5540, n5550, n5560, n5570, n558, n559,
         n560, n561, n562, n563, n564, n565, n566, n567, n568, n569, n570,
         n571, n572, n5730, n574, n575, n577, n578, n5790, n580, n581, n582,
         n583, n584, n585, n586, n587, n588, n589, n590, n591, n5920, n5930,
         n5940, n5950, n5960, n5970, n5980, n5990, n600, n601, n602, n603,
         n604, n605, n606, n607, n608, n609, n610, n611, n612, n613, n614,
         n615, n616, n617, n618, n619, n620, n621, n622, n623, n624, n625,
         n626, n627, n628, n629, n630, n631, n632, n633, n634, n635, n636,
         n637, n638, n639, n640, n641, n642, n643, n644, n645, n646, n647,
         n648, n649, n650, n651, n652, n653, n654, n655, n656, n657, n658,
         n659, n660, n661, n662, n663, n664, n665, n666, n667, n668, n669,
         n670, n671, n672, n673, n674, n675, n676, n677, n678, n679, n680,
         n681, n682, n683, n684, n685, n686, n687, n688, n689, n690, n691,
         n692, n693, n694, n695, n696, n697, n698, n699, n700, n701, n702,
         n703, n704, n705, n706, n711, n712, n713, n714, n715, n716, n717,
         n718, n719, n720, n721, n722, n723, n724, n725, n726, n727, n728,
         n729, n730, n731, n732, n733, n734, n735, n736, n737, n738, n739,
         n740, n741, n742, n743, n744, n745, n746, n747, n748, n749, n750,
         n751, n752, n753, n754, n755, n756, n757, n758, n759, n760, n761,
         n762, n763, n764, n765, n766, n767, n768, n769, n770, n771, n772,
         n773, n774, n775, n776, n777, n778, n779, n780, n781, n782, n783,
         n784, n785, n786, n787, n788, n789, n790, n791, n792, n793, n794,
         n795, n796, n797, n798, n799, n800, n801, n802, n803, n804, n805,
         n806, n807, n808, n809, n810, n811, n812, n813, n814, n815, n816,
         n817, n818, n819, n820, n821, n822, n823, n824, n825, n826, n827,
         n828, n829, n830, n831, n832, n833, n834, n835, n836, n837, n838,
         n839, n840, n841, n842, n843, n844, n845, n846, n847, n848, n849,
         n850, n851, n852, n853, n854, n855, n856, n857, n858, n859, n860,
         n861, n862, n863, n864, n865, n866, n867, n868, n869, n870, n871,
         n872, n873, n874, n875, n876, n877, n878, n879, n880, n881, n882,
         n883, n884, n885, n886, n887, n888, n889, n890, n891, n892, n893,
         n894, n895, n896, n897, n898, n899, n900, n901, n902, n903, n904,
         n905, n906, n907, n908, n909, n910, n911, n912, n913, n914, n915,
         n916, n917, n918, n919, n920, n921, n922, n923, n924, n925, n926,
         n927, n928, n929, n930, n931, n932, n933, n934, n935, n936, n937,
         n938, n939, n940, n941, n942, n943, n944, n945, n946, n947, n948,
         n949, n950, n951, n952, n953, n954, n955, n956, n957, n958, n959,
         n960, n961, n962, n963, n964, n965, n966, n967, n968, n969, n970,
         n971, n972, n973, n974, n975, n976, n977, n978, n979, n980, n981,
         n982, n983, n984, n985, n986, n987, n988, n989, n990, n991, n992,
         n993, n994, n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003,
         n1004, n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013,
         n1014, n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, n1023,
         n1024, n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033,
         n1034, n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043,
         n1044, n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053,
         n1054, n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063,
         n1064, n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073,
         n1074, n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083,
         n1084, n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093,
         n1094, n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103,
         n1104, n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113,
         n1114, n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123,
         n1124, n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133,
         n1134, n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143,
         n1144, n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152, n1153,
         n1154, n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162, n1163,
         n1164, n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172, n1173,
         n1174, n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182, n1183,
         n1184, n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192, n1193,
         n1194, n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202, n1203,
         n1204, n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212, n1213,
         n1214, n1215, n1216, n1217, n1219, n1220, n1221, n1222, n1223, n1224,
         n1225, n1226, n1227, n1229, n1230, n1231, n1232, n1233, n1234, n1235,
         n1236, n1237, n1243, n1244, n1245, n1246, n1247, n1248, n1249, n1250,
         n1251, n1253, n1254, n1255, n1256, n1257, n1258, n1259, n1260, n1261,
         SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4;
  wire   [7:0] sram_Q0;
  wire   [7:0] addr_SRAM;
  wire   [7:0] sram_Q1;
  wire   [7:0] sram_Q2;
  wire   [7:0] sram_Q3;
  wire   [7:0] sram_Q4;
  wire   [7:0] sram_Q5;
  wire   [7:0] sram_Q6;
  wire   [7:0] sram_Q7;
  wire   [8:0] counter;
  wire   [7:0] add_i_0;
  wire   [7:0] add_i_1;
  wire   [7:0] add_i_2;
  wire   [7:0] add_i_3;
  wire   [7:0] add_i_4;
  wire   [7:0] add_i_5;
  wire   [7:0] add_i_6;
  wire   [7:0] add_i_7;
  wire   [9:4] temp4;
  wire   [9:4] temp5;
  wire   [10:0] answer;
  wire   [1:0] extend;
  wire   [12:0] answer_ex;
  wire   [16:0] out_data_conv;
  wire   [7:0] out_data_dis_temp;
  wire   [2:0] state;
  wire   [2:0] row;
  wire   [2:0] row_t;
  wire   [2:0] col_t;
  wire   [2:0] addr_incre;

  sram_256x8 sram0 ( .Q(sram_Q0), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n5540) );
  sram_256x8 sram1 ( .Q(sram_Q1), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n5530) );
  sram_256x8 sram2 ( .Q(sram_Q2), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n5520) );
  sram_256x8 sram3 ( .Q(sram_Q3), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n5510) );
  sram_256x8 sram4 ( .Q(sram_Q4), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n550) );
  sram_256x8 sram5 ( .Q(sram_Q5), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n549) );
  sram_256x8 sram6 ( .Q(sram_Q6), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n548) );
  sram_256x8 sram7 ( .Q(sram_Q7), .A({n742, n588, n737, n736, n735, n739, n741, 
        n738}), .D(i_in_data), .CLK(i_clk), .CEN(1'b0), .WEN(n547) );
  DFFRX4 col_reg_0_ ( .D(n542), .CK(i_clk), .RN(n744), .Q(n1202), .QN(n698) );
  DFFRX4 col_reg_1_ ( .D(n541), .CK(i_clk), .RN(n744), .Q(n1205), .QN(n563) );
  DFFRX4 col_reg_2_ ( .D(n540), .CK(i_clk), .RN(n744), .Q(n1201), .QN(n569) );
  DFFRX4 row_reg_0_ ( .D(n539), .CK(i_clk), .RN(n744), .Q(row[0]), .QN(n564)
         );
  DFFRX4 state_reg_0_ ( .D(n648), .CK(i_clk), .RN(n744), .Q(state[0]), .QN(
        n671) );
  DFFRX4 state_reg_2_ ( .D(n1147), .CK(i_clk), .RN(n744), .Q(state[2]), .QN(
        n572) );
  DFFRX4 counter_reg_0_ ( .D(N276), .CK(i_clk), .RN(n744), .Q(counter[0]), 
        .QN(n516) );
  DFFRX4 counter_reg_1_ ( .D(N277), .CK(i_clk), .RN(n744), .Q(counter[1]), 
        .QN(n515) );
  DFFRX4 counter_reg_2_ ( .D(N278), .CK(i_clk), .RN(n744), .Q(counter[2]), 
        .QN(n514) );
  DFFTRX4 temp5_reg_8_ ( .D(N139), .RN(n560), .CK(i_clk), .Q(temp5[8]) );
  DFFTRX4 temp5_reg_6_ ( .D(N137), .RN(n560), .CK(i_clk), .QN(n577) );
  DFFTRX4 temp5_reg_5_ ( .D(N136), .RN(n560), .CK(i_clk), .QN(n714) );
  DFFTRX4 temp5_reg_4_ ( .D(N135), .RN(n561), .CK(i_clk), .Q(temp5[4]) );
  DFFTRX4 temp5_reg_3_ ( .D(N134), .RN(n561), .CK(i_clk), .QN(n724) );
  DFFTRX4 temp5_reg_1_ ( .D(N132), .RN(n561), .CK(i_clk), .QN(n729) );
  DFFTRX4 temp4_reg_8_ ( .D(N129), .RN(n560), .CK(i_clk), .Q(temp4[8]) );
  DFFTRX4 temp4_reg_6_ ( .D(N127), .RN(n560), .CK(i_clk), .QN(n582) );
  DFFTRX4 temp4_reg_3_ ( .D(N124), .RN(n560), .CK(i_clk), .QN(n719) );
  DFFTRX4 temp4_reg_2_ ( .D(N123), .RN(n561), .CK(i_clk), .QN(n716) );
  DFFTRX4 temp4_reg_1_ ( .D(N122), .RN(n560), .CK(i_clk), .QN(n722) );
  DFFTRX4 temp4_reg_0_ ( .D(N121), .RN(n561), .CK(i_clk), .QN(n5970) );
  DFFRX4 state_reg_1_ ( .D(n1146), .CK(i_clk), .RN(n744), .Q(state[1]), .QN(
        n711) );
  DFFRX4 addr_SRAM_reg_7_ ( .D(N557), .CK(i_clk), .RN(n744), .Q(addr_SRAM[7]), 
        .QN(n524) );
  DFFRX4 addr_SRAM_reg_1_ ( .D(N551), .CK(i_clk), .RN(n744), .Q(addr_SRAM[1]), 
        .QN(n481) );
  DFFTRX4 add_i_0_reg_0_ ( .D(n559), .RN(sram_Q0[0]), .CK(i_clk), .Q(
        add_i_0[0]) );
  DFFTRX4 add_i_4_reg_0_ ( .D(n559), .RN(sram_Q4[0]), .CK(i_clk), .Q(
        add_i_4[0]) );
  core_DW01_inc_0_DW01_inc_7 add_350 ( .A({counter[8:7], n604, n602, n657, 
        n607, counter[2:0]}), .SUM({N275, N274, N273, N272, N271, N270, N269, 
        N268, N267}) );
  core_DW01_inc_1_DW01_inc_8 add_322 ( .A({out_data_conv[16:10], n611, 
        out_data_conv[8:4]}), .SUM({N245, N244, N243, N242, N241, N240, N239, 
        N238, N237, N236, N235, N234, N233}) );
  core_DW01_inc_2_DW01_inc_9 r629 ( .A({n742, n588, n737, n736, n735, n739, 
        n741, n738}), .SUM({N493, N492, N491, N490, N489, N488, N487, N486})
         );
  core_DW01_add_6 add_2_root_add_0_root_add_234 ( .\A[7] (add_i_4[7]), 
        .\A[6] (add_i_4[6]), .\A[5] (add_i_4[5]), .\A[4] (add_i_4[4]), 
        .\A[3] (add_i_4[3]), .\A[2] (add_i_4[2]), .\A[1] (add_i_4[1]), 
        .\A[0] (add_i_4[0]), .\B[7] (add_i_6[7]), .\B[6] (add_i_6[6]), 
        .\B[5] (add_i_6[5]), .\B[4] (add_i_6[4]), .\B[3] (add_i_6[3]), 
        .\B[2] (add_i_6[2]), .\B[1] (add_i_6[1]), .\B[0] (add_i_6[0]), 
        .\SUM[8] (n1251), .\SUM[7] (n1250), .\SUM[6] (n1249), .\SUM[5] (n1248), 
        .\SUM[4] (n1247), .\SUM[3] (n1246), .\SUM[2] (n1245), .\SUM[1] (n1244), 
        .\SUM[0] (n1243) );
  core_DW01_add_5 add_1_root_add_0_root_add_234 ( .\A[7] (add_i_5[7]), 
        .\A[6] (add_i_5[6]), .\A[5] (add_i_5[5]), .\A[4] (add_i_5[4]), 
        .\A[3] (add_i_5[3]), .\A[2] (add_i_5[2]), .\A[1] (add_i_5[1]), 
        .\A[0] (add_i_5[0]), .\B[7] (add_i_7[7]), .\B[6] (add_i_7[6]), 
        .\B[5] (add_i_7[5]), .\B[4] (add_i_7[4]), .\B[3] (add_i_7[3]), 
        .\B[2] (add_i_7[2]), .\B[1] (add_i_7[1]), .\B[0] (add_i_7[0]), 
        .\SUM[8] (n1261), .\SUM[7] (n1260), .\SUM[6] (n1259), .\SUM[5] (n1258), 
        .\SUM[4] (n1257), .\SUM[3] (n1256), .\SUM[2] (n1255), .\SUM[1] (n1254), 
        .\SUM[0] (n1253) );
  core_DW01_add_4 add_0_root_add_0_root_add_234 ( .SUM({N140, N139, N138, N137, 
        N136, N135, N134, N133, N132, N131}), .\A[8] (n1251), .\A[7] (n1250), 
        .\A[6] (n1249), .\A[5] (n1248), .\A[4] (n1247), .\A[3] (n1246), 
        .\A[2] (n1245), .\A[1] (n1244), .\A[0] (n1243), .\B[8] (n1261), 
        .\B[7] (n1260), .\B[6] (n1259), .\B[5] (n1258), .\B[4] (n1257), 
        .\B[3] (n1256), .\B[2] (n1255), .\B[1] (n1254), .\B[0] (n1253) );
  core_DW01_add_9 add_2_root_add_0_root_add_233 ( .\A[7] (add_i_0[7]), 
        .\A[6] (add_i_0[6]), .\A[5] (add_i_0[5]), .\A[4] (add_i_0[4]), 
        .\A[3] (add_i_0[3]), .\A[2] (add_i_0[2]), .\A[1] (add_i_0[1]), 
        .\A[0] (add_i_0[0]), .\B[7] (add_i_2[7]), .\B[6] (add_i_2[6]), 
        .\B[5] (add_i_2[5]), .\B[4] (add_i_2[4]), .\B[3] (add_i_2[3]), 
        .\B[2] (add_i_2[2]), .\B[1] (add_i_2[1]), .\B[0] (add_i_2[0]), 
        .\SUM[8] (n1227), .\SUM[7] (n1226), .\SUM[6] (n1225), .\SUM[5] (n1224), 
        .\SUM[4] (n1223), .\SUM[3] (n1222), .\SUM[2] (n1221), .\SUM[1] (n1220), 
        .\SUM[0] (n1219) );
  core_DW01_add_8 add_1_root_add_0_root_add_233 ( .\A[7] (add_i_1[7]), 
        .\A[6] (add_i_1[6]), .\A[5] (add_i_1[5]), .\A[4] (add_i_1[4]), 
        .\A[3] (add_i_1[3]), .\A[2] (add_i_1[2]), .\A[1] (add_i_1[1]), 
        .\A[0] (add_i_1[0]), .\B[7] (add_i_3[7]), .\B[6] (add_i_3[6]), 
        .\B[5] (add_i_3[5]), .\B[4] (add_i_3[4]), .\B[3] (add_i_3[3]), 
        .\B[2] (add_i_3[2]), .\B[1] (add_i_3[1]), .\B[0] (add_i_3[0]), 
        .\SUM[8] (n1237), .\SUM[7] (n1236), .\SUM[6] (n1235), .\SUM[5] (n1234), 
        .\SUM[4] (n1233), .\SUM[3] (n1232), .\SUM[2] (n1231), .\SUM[1] (n1230), 
        .\SUM[0] (n1229) );
  core_DW01_add_7 add_0_root_add_0_root_add_233 ( .SUM({N130, N129, N128, N127, 
        N126, N125, N124, N123, N122, N121}), .\A[8] (n1227), .\A[7] (n1226), 
        .\A[6] (n1225), .\A[5] (n1224), .\A[4] (n1223), .\A[3] (n1222), 
        .\A[2] (n1221), .\A[1] (n1220), .\A[0] (n1219), .\B[8] (n1237), 
        .\B[7] (n1236), .\B[6] (n1235), .\B[5] (n1234), .\B[4] (n1233), 
        .\B[3] (n1232), .\B[2] (n1231), .\B[1] (n1230), .\B[0] (n1229) );
  core_DW01_add_10 add_238 ( .SUM(answer), .\A[9] (temp4[9]), .\A[8] (temp4[8]), .\A[7] (n581), .\A[6] (n583), .\A[5] (n654), .\A[4] (temp4[4]), .\A[3] (n720), .\A[2] (n717), .\A[1] (n723), .\A[0] (n5980), .\B[9] (temp5[9]), .\B[8] (
        temp5[8]), .\B[7] (n5960), .\B[6] (n578), .\B[5] (n715), .\B[4] (
        temp5[4]), .\B[3] (n725), .\B[2] (n721), .\B[1] (n730), .\B[0] (n622)
         );
  core_DW01_add_13 add_257 ( .A({out_data_conv[16:10], n611, 
        out_data_conv[8:0]}), .SUM({N187, N186, N185, N184, N183, N182, N181, 
        N180, N179, N178, N177, N176, N175, N174, N173, N172, N171}), 
        .\B[12] (answer_ex[12]), .\B[11] (answer_ex[11]), .\B[10] (
        answer_ex[10]), .\B[9] (answer_ex[9]), .\B[8] (answer_ex[8]), .\B[7] (
        answer_ex[7]), .\B[6] (answer_ex[6]), .\B[5] (answer_ex[5]), .\B[4] (
        answer_ex[4]), .\B[3] (answer_ex[3]), .\B[2] (answer_ex[2]), .\B[1] (
        answer_ex[1]), .\B[0] (answer_ex[0]) );
  DFFRX4 addr_SRAM_reg_5_ ( .D(N555), .CK(i_clk), .RN(n744), .Q(addr_SRAM[5]), 
        .QN(n485) );
  DFFRX4 addr_SRAM_reg_4_ ( .D(N554), .CK(i_clk), .RN(n744), .Q(addr_SRAM[4]), 
        .QN(n484) );
  DFFRX4 addr_SRAM_reg_0_ ( .D(n1148), .CK(i_clk), .RN(i_rst_n), .Q(
        addr_SRAM[0]), .QN(n480) );
  DFFRX4 counter_reg_7_ ( .D(N283), .CK(i_clk), .RN(i_rst_n), .Q(counter[7])
         );
  DFFTRX4 temp4_reg_4_ ( .D(N125), .RN(n561), .CK(i_clk), .Q(temp4[4]) );
  DFFTRX4 temp4_reg_7_ ( .D(N128), .RN(n560), .CK(i_clk), .QN(n580) );
  DFFTRX4 temp4_reg_5_ ( .D(N126), .RN(n561), .CK(i_clk), .QN(n653) );
  DFFTRX4 temp5_reg_0_ ( .D(N131), .RN(n561), .CK(i_clk), .QN(n621) );
  DFFRX2 counter_reg_8_ ( .D(N284), .CK(i_clk), .RN(n744), .Q(counter[8]), 
        .QN(n479) );
  DFFTRX1 out_data_dis_reg_0_ ( .D(out_data_dis_temp[0]), .RN(have_load), .CK(
        i_clk), .QN(n1200) );
  DFFTRX1 out_data_dis_reg_1_ ( .D(out_data_dis_temp[1]), .RN(have_load), .CK(
        i_clk), .QN(n1199) );
  DFFTRX1 out_data_dis_reg_2_ ( .D(out_data_dis_temp[2]), .RN(have_load), .CK(
        i_clk), .QN(n1198) );
  DFFTRX1 out_data_dis_reg_3_ ( .D(out_data_dis_temp[3]), .RN(have_load), .CK(
        i_clk), .QN(n1197) );
  DFFTRX1 out_data_dis_reg_4_ ( .D(out_data_dis_temp[4]), .RN(have_load), .CK(
        i_clk), .QN(n1196) );
  DFFTRX1 out_data_dis_reg_5_ ( .D(out_data_dis_temp[5]), .RN(have_load), .CK(
        i_clk), .QN(n1195) );
  DFFTRX1 out_data_dis_reg_6_ ( .D(out_data_dis_temp[6]), .RN(have_load), .CK(
        i_clk), .QN(n1194) );
  DFFTRX1 out_data_dis_reg_7_ ( .D(out_data_dis_temp[7]), .RN(have_load), .CK(
        i_clk), .QN(n469) );
  DFFQX1 outside_reg ( .D(outside_pipeline_1), .CK(i_clk), .Q(outside) );
  DFFSX1 sram_wen_reg_0_ ( .D(N592), .CK(i_clk), .SN(n744), .QN(n1193) );
  DFFSX1 sram_wen_reg_7_ ( .D(N599), .CK(i_clk), .SN(n744), .QN(n1186) );
  DFFSX1 sram_wen_reg_1_ ( .D(N593), .CK(i_clk), .SN(n744), .QN(n1192) );
  DFFSX1 sram_wen_reg_2_ ( .D(N594), .CK(i_clk), .SN(n744), .QN(n1191) );
  DFFSX1 sram_wen_reg_3_ ( .D(N595), .CK(i_clk), .SN(n744), .QN(n1190) );
  DFFSX1 sram_wen_reg_4_ ( .D(N596), .CK(i_clk), .SN(n744), .QN(n1189) );
  DFFSX1 sram_wen_reg_5_ ( .D(N597), .CK(i_clk), .SN(n744), .QN(n1188) );
  DFFSX1 sram_wen_reg_6_ ( .D(N598), .CK(i_clk), .SN(n744), .QN(n1187) );
  DFFTRX1 add_i_3_reg_7_ ( .D(n559), .RN(sram_Q3[7]), .CK(i_clk), .Q(
        add_i_3[7]) );
  DFFTRX1 add_i_7_reg_7_ ( .D(n558), .RN(sram_Q7[7]), .CK(i_clk), .Q(
        add_i_7[7]) );
  DFFTRX1 add_i_1_reg_7_ ( .D(n558), .RN(sram_Q1[7]), .CK(i_clk), .Q(
        add_i_1[7]) );
  DFFTRX1 add_i_2_reg_7_ ( .D(n558), .RN(sram_Q2[7]), .CK(i_clk), .Q(
        add_i_2[7]) );
  DFFTRX1 add_i_0_reg_7_ ( .D(n558), .RN(sram_Q0[7]), .CK(i_clk), .Q(
        add_i_0[7]) );
  DFFTRX1 add_i_4_reg_7_ ( .D(n559), .RN(sram_Q4[7]), .CK(i_clk), .Q(
        add_i_4[7]) );
  DFFTRX1 add_i_3_reg_6_ ( .D(n558), .RN(sram_Q3[6]), .CK(i_clk), .Q(
        add_i_3[6]) );
  DFFTRX1 add_i_7_reg_6_ ( .D(n558), .RN(sram_Q7[6]), .CK(i_clk), .Q(
        add_i_7[6]) );
  DFFTRX1 add_i_2_reg_6_ ( .D(n558), .RN(sram_Q2[6]), .CK(i_clk), .Q(
        add_i_2[6]) );
  DFFTRX1 add_i_6_reg_6_ ( .D(n559), .RN(sram_Q6[6]), .CK(i_clk), .Q(
        add_i_6[6]) );
  DFFTRX1 add_i_1_reg_6_ ( .D(n559), .RN(sram_Q1[6]), .CK(i_clk), .Q(
        add_i_1[6]) );
  DFFTRX1 add_i_5_reg_6_ ( .D(n558), .RN(sram_Q5[6]), .CK(i_clk), .Q(
        add_i_5[6]) );
  DFFTRX1 add_i_0_reg_6_ ( .D(n558), .RN(sram_Q0[6]), .CK(i_clk), .Q(
        add_i_0[6]) );
  DFFTRX1 add_i_4_reg_6_ ( .D(n558), .RN(sram_Q4[6]), .CK(i_clk), .Q(
        add_i_4[6]) );
  DFFRX1 depth_reg_0_ ( .D(n546), .CK(i_clk), .RN(n744), .Q(n1203), .QN(n574)
         );
  DFFQX1 out_data_conv_reg_3_ ( .D(N191), .CK(i_clk), .Q(out_data_conv[3]) );
  DFFTRX1 add_i_7_reg_5_ ( .D(n559), .RN(sram_Q7[5]), .CK(i_clk), .Q(
        add_i_7[5]) );
  DFFTRX1 add_i_2_reg_5_ ( .D(n559), .RN(sram_Q2[5]), .CK(i_clk), .Q(
        add_i_2[5]) );
  DFFTRX1 add_i_6_reg_5_ ( .D(n558), .RN(sram_Q6[5]), .CK(i_clk), .Q(
        add_i_6[5]) );
  DFFTRX1 add_i_5_reg_5_ ( .D(n559), .RN(sram_Q5[5]), .CK(i_clk), .Q(
        add_i_5[5]) );
  DFFTRX1 add_i_0_reg_5_ ( .D(n559), .RN(sram_Q0[5]), .CK(i_clk), .Q(
        add_i_0[5]) );
  DFFTRX1 add_i_4_reg_5_ ( .D(n558), .RN(sram_Q4[5]), .CK(i_clk), .Q(
        add_i_4[5]) );
  DFFTRX1 add_i_3_reg_4_ ( .D(n559), .RN(sram_Q3[4]), .CK(i_clk), .Q(
        add_i_3[4]) );
  DFFTRX1 add_i_7_reg_4_ ( .D(n559), .RN(sram_Q7[4]), .CK(i_clk), .Q(
        add_i_7[4]) );
  DFFTRX1 add_i_2_reg_4_ ( .D(n559), .RN(sram_Q2[4]), .CK(i_clk), .Q(
        add_i_2[4]) );
  DFFTRX1 add_i_6_reg_4_ ( .D(n559), .RN(sram_Q6[4]), .CK(i_clk), .Q(
        add_i_6[4]) );
  DFFTRX1 add_i_1_reg_4_ ( .D(n558), .RN(sram_Q1[4]), .CK(i_clk), .Q(
        add_i_1[4]) );
  DFFTRX1 add_i_5_reg_4_ ( .D(n558), .RN(sram_Q5[4]), .CK(i_clk), .Q(
        add_i_5[4]) );
  DFFTRX1 add_i_0_reg_4_ ( .D(n559), .RN(sram_Q0[4]), .CK(i_clk), .Q(
        add_i_0[4]) );
  DFFTRX1 add_i_4_reg_4_ ( .D(n559), .RN(sram_Q4[4]), .CK(i_clk), .Q(
        add_i_4[4]) );
  DFFTRX1 add_i_3_reg_3_ ( .D(n559), .RN(sram_Q3[3]), .CK(i_clk), .Q(
        add_i_3[3]) );
  DFFTRX1 add_i_7_reg_3_ ( .D(n558), .RN(sram_Q7[3]), .CK(i_clk), .Q(
        add_i_7[3]) );
  DFFTRX1 add_i_2_reg_3_ ( .D(n558), .RN(sram_Q2[3]), .CK(i_clk), .Q(
        add_i_2[3]) );
  DFFTRX1 add_i_6_reg_3_ ( .D(n558), .RN(sram_Q6[3]), .CK(i_clk), .Q(
        add_i_6[3]) );
  DFFTRX1 add_i_1_reg_3_ ( .D(n558), .RN(sram_Q1[3]), .CK(i_clk), .Q(
        add_i_1[3]) );
  DFFTRX1 add_i_5_reg_3_ ( .D(n558), .RN(sram_Q5[3]), .CK(i_clk), .Q(
        add_i_5[3]) );
  DFFTRX1 add_i_0_reg_3_ ( .D(n558), .RN(sram_Q0[3]), .CK(i_clk), .Q(
        add_i_0[3]) );
  DFFTRX1 add_i_4_reg_3_ ( .D(n558), .RN(sram_Q4[3]), .CK(i_clk), .Q(
        add_i_4[3]) );
  DFFQX2 addr_incre_reg_0_ ( .D(N411), .CK(i_clk), .Q(addr_incre[0]) );
  DFFTRX1 add_i_6_reg_2_ ( .D(n559), .RN(sram_Q6[2]), .CK(i_clk), .Q(
        add_i_6[2]) );
  DFFTRX1 add_i_1_reg_2_ ( .D(n559), .RN(sram_Q1[2]), .CK(i_clk), .Q(
        add_i_1[2]) );
  DFFTRX1 add_i_5_reg_2_ ( .D(n559), .RN(sram_Q5[2]), .CK(i_clk), .Q(
        add_i_5[2]) );
  DFFTRX1 add_i_0_reg_2_ ( .D(n559), .RN(sram_Q0[2]), .CK(i_clk), .Q(
        add_i_0[2]) );
  DFFTRX1 add_i_4_reg_2_ ( .D(n558), .RN(sram_Q4[2]), .CK(i_clk), .Q(
        add_i_4[2]) );
  DFFQX2 col_t_reg_0_ ( .D(n535), .CK(i_clk), .Q(col_t[0]) );
  DFFSX2 depth_reg_3_ ( .D(n543), .CK(i_clk), .SN(n744), .Q(n1206) );
  DFFSX2 depth_reg_2_ ( .D(n544), .CK(i_clk), .SN(n744), .Q(n1207), .QN(n571)
         );
  DFFRX1 o_out_valid_pipeline_1_reg ( .D(N579), .CK(i_clk), .RN(n744), .Q(
        o_out_valid_pipeline_1) );
  DFFRX1 o_out_valid_pipeline_2_reg ( .D(o_out_valid_pipeline_1), .CK(i_clk), 
        .RN(n744), .Q(o_out_valid_pipeline_2) );
  DFFRX1 in_ready_reg_reg ( .D(1'b1), .CK(i_clk), .RN(n744), .Q(o_in_ready) );
  DFFRX1 out_valid_reg_reg ( .D(o_out_valid_pipeline_3), .CK(i_clk), .RN(n744), 
        .Q(o_out_valid) );
  DFFRX1 out_data_reg_reg_11_ ( .D(n501), .CK(i_clk), .RN(n744), .Q(
        o_out_data[11]) );
  DFFRX1 out_data_reg_reg_10_ ( .D(n502), .CK(i_clk), .RN(n744), .Q(
        o_out_data[10]) );
  DFFRX1 out_data_reg_reg_9_ ( .D(n503), .CK(i_clk), .RN(n744), .Q(
        o_out_data[9]) );
  DFFRX1 out_data_reg_reg_8_ ( .D(n504), .CK(i_clk), .RN(n744), .Q(
        o_out_data[8]) );
  DFFRX1 out_data_reg_reg_7_ ( .D(n505), .CK(i_clk), .RN(n744), .Q(
        o_out_data[7]) );
  DFFRX1 out_data_reg_reg_6_ ( .D(n1217), .CK(i_clk), .RN(n744), .Q(
        o_out_data[6]) );
  DFFRX1 out_data_reg_reg_5_ ( .D(n1216), .CK(i_clk), .RN(n744), .Q(
        o_out_data[5]) );
  DFFRX1 out_data_reg_reg_4_ ( .D(n1215), .CK(i_clk), .RN(n744), .Q(
        o_out_data[4]) );
  DFFRX1 out_data_reg_reg_3_ ( .D(n1214), .CK(i_clk), .RN(n744), .Q(
        o_out_data[3]) );
  DFFRX1 out_data_reg_reg_2_ ( .D(n1213), .CK(i_clk), .RN(n744), .Q(
        o_out_data[2]) );
  DFFRX1 out_data_reg_reg_1_ ( .D(n1212), .CK(i_clk), .RN(n744), .Q(
        o_out_data[1]) );
  DFFRX1 out_data_reg_reg_0_ ( .D(n1211), .CK(i_clk), .RN(n744), .Q(
        o_out_data[0]) );
  DFFQXL out_data_conv_reg_1_ ( .D(N189), .CK(i_clk), .Q(out_data_conv[1]) );
  DFFQXL out_data_conv_reg_0_ ( .D(N188), .CK(i_clk), .Q(out_data_conv[0]) );
  DFFQXL out_data_dis_temp_reg_0_ ( .D(N222), .CK(i_clk), .Q(
        out_data_dis_temp[0]) );
  DFFQXL out_data_dis_temp_reg_1_ ( .D(N223), .CK(i_clk), .Q(
        out_data_dis_temp[1]) );
  DFFQXL out_data_dis_temp_reg_2_ ( .D(N224), .CK(i_clk), .Q(
        out_data_dis_temp[2]) );
  DFFQXL out_data_dis_temp_reg_3_ ( .D(N225), .CK(i_clk), .Q(
        out_data_dis_temp[3]) );
  DFFQXL out_data_dis_temp_reg_4_ ( .D(N226), .CK(i_clk), .Q(
        out_data_dis_temp[4]) );
  DFFQXL out_data_dis_temp_reg_5_ ( .D(N227), .CK(i_clk), .Q(
        out_data_dis_temp[5]) );
  DFFQXL out_data_dis_temp_reg_6_ ( .D(N228), .CK(i_clk), .Q(
        out_data_dis_temp[6]) );
  DFFQXL out_data_dis_temp_reg_7_ ( .D(N229), .CK(i_clk), .Q(
        out_data_dis_temp[7]) );
  DFFTRXL add_i_6_reg_7_ ( .D(n558), .RN(sram_Q6[7]), .CK(i_clk), .Q(
        add_i_6[7]) );
  DFFTRXL add_i_5_reg_7_ ( .D(n559), .RN(sram_Q5[7]), .CK(i_clk), .Q(
        add_i_5[7]) );
  DFFHQX4 extend_reg_0_ ( .D(N164), .CK(i_clk), .Q(extend[0]) );
  DFFTRX4 add_i_0_reg_1_ ( .D(n559), .RN(sram_Q0[1]), .CK(i_clk), .Q(
        add_i_0[1]) );
  DFFTRX4 add_i_2_reg_1_ ( .D(n558), .RN(sram_Q2[1]), .CK(i_clk), .Q(
        add_i_2[1]) );
  DFFTRX4 add_i_2_reg_0_ ( .D(n558), .RN(sram_Q2[0]), .CK(i_clk), .Q(
        add_i_2[0]) );
  DFFTRX4 add_i_6_reg_0_ ( .D(n558), .RN(sram_Q6[0]), .CK(i_clk), .Q(
        add_i_6[0]) );
  DFFTRX4 out_data_conv_reg_14_ ( .D(N185), .RN(n566), .CK(i_clk), .Q(
        out_data_conv[14]) );
  DFFTRX4 add_i_5_reg_0_ ( .D(n559), .RN(sram_Q5[0]), .CK(i_clk), .Q(
        add_i_5[0]) );
  DFFTRX4 add_i_1_reg_0_ ( .D(n559), .RN(sram_Q1[0]), .CK(i_clk), .Q(
        add_i_1[0]) );
  DFFTRX4 add_i_7_reg_0_ ( .D(n558), .RN(sram_Q7[0]), .CK(i_clk), .Q(
        add_i_7[0]) );
  DFFTRX4 add_i_7_reg_1_ ( .D(n558), .RN(sram_Q7[1]), .CK(i_clk), .Q(
        add_i_7[1]) );
  DFFTRX4 add_i_5_reg_1_ ( .D(n559), .RN(sram_Q5[1]), .CK(i_clk), .Q(
        add_i_5[1]) );
  DFFTRX4 add_i_3_reg_0_ ( .D(n558), .RN(sram_Q3[0]), .CK(i_clk), .Q(
        add_i_3[0]) );
  DFFTRX4 add_i_3_reg_1_ ( .D(n558), .RN(sram_Q3[1]), .CK(i_clk), .Q(
        add_i_3[1]) );
  DFFTRX2 add_i_1_reg_5_ ( .D(n559), .RN(sram_Q1[5]), .CK(i_clk), .Q(
        add_i_1[5]) );
  DFFTRX4 out_data_conv_reg_15_ ( .D(N186), .RN(n566), .CK(i_clk), .Q(
        out_data_conv[15]) );
  DFFTRX4 out_data_conv_reg_13_ ( .D(N184), .RN(n566), .CK(i_clk), .Q(
        out_data_conv[13]) );
  DFFRX2 out_data_conv_reg_9_ ( .D(N197), .CK(i_clk), .RN(1'b1), .Q(n611), 
        .QN(n610) );
  DFFTRX4 add_i_1_reg_1_ ( .D(n558), .RN(sram_Q1[1]), .CK(i_clk), .Q(
        add_i_1[1]) );
  DFFRHQX8 addr_SRAM_reg_3_ ( .D(N553), .CK(i_clk), .RN(n744), .Q(n600) );
  DFFRX4 row_reg_1_ ( .D(n538), .CK(i_clk), .RN(i_rst_n), .Q(row[1]), .QN(n883) );
  DFFRHQX4 counter_reg_5_ ( .D(N281), .CK(i_clk), .RN(n744), .Q(n602) );
  DFFRHQX8 addr_SRAM_reg_6_ ( .D(N556), .CK(i_clk), .RN(n744), .Q(n588) );
  DFFQX4 out_data_conv_reg_2_ ( .D(N190), .CK(i_clk), .Q(out_data_conv[2]) );
  DFFHQX4 temp5_reg_2_ ( .D(n5790), .CK(i_clk), .Q(n721) );
  DFFRX4 addr_SRAM_reg_2_ ( .D(N552), .CK(i_clk), .RN(n744), .Q(addr_SRAM[2]), 
        .QN(n482) );
  DFFSX1 change_output_reg_1_ ( .D(n497), .CK(i_clk), .SN(i_rst_n), .Q(n1208), 
        .QN(n1151) );
  DFFSX1 change_output_reg_0_ ( .D(n498), .CK(i_clk), .SN(i_rst_n), .Q(n1209), 
        .QN(n1150) );
  DFFSX1 change_output_reg_2_ ( .D(n496), .CK(i_clk), .SN(n744), .Q(n1210), 
        .QN(n1149) );
  DFFRX1 o_out_valid_pipeline_3_reg ( .D(o_out_valid_pipeline_2), .CK(i_clk), 
        .RN(i_rst_n), .Q(o_out_valid_pipeline_3), .QN(n1094) );
  DFFRX1 depth_reg_1_ ( .D(n545), .CK(i_clk), .RN(i_rst_n), .Q(n1204), .QN(
        n802) );
  DFFRHQX2 extend_reg_1_ ( .D(N165), .CK(i_clk), .RN(1'b1), .Q(extend[1]) );
  DFFRX2 have_load_reg ( .D(n499), .CK(i_clk), .RN(i_rst_n), .Q(have_load), 
        .QN(n494) );
  DFFTRX2 out_data_conv_reg_11_ ( .D(N182), .RN(n566), .CK(i_clk), .Q(
        out_data_conv[11]), .QN(n575) );
  DFFRHQX4 counter_reg_6_ ( .D(N282), .CK(i_clk), .RN(n744), .Q(n604) );
  DFFRHQX8 counter_reg_3_ ( .D(N279), .CK(i_clk), .RN(n744), .Q(n607) );
  DFFTRX2 temp5_reg_9_ ( .D(N140), .RN(n561), .CK(i_clk), .Q(temp5[9]) );
  DFFTRX2 temp4_reg_9_ ( .D(N130), .RN(n560), .CK(i_clk), .Q(temp4[9]) );
  DFFQX4 col_t_reg_1_ ( .D(n534), .CK(i_clk), .Q(col_t[1]) );
  DFFQX2 row_t_reg_2_ ( .D(n531), .CK(i_clk), .Q(row_t[2]) );
  DFFQX4 row_t_reg_1_ ( .D(n533), .CK(i_clk), .Q(row_t[1]) );
  DFFRHQX4 counter_reg_4_ ( .D(N280), .CK(i_clk), .RN(n744), .Q(n657) );
  DFFTRX2 add_i_6_reg_1_ ( .D(n559), .RN(sram_Q6[1]), .CK(i_clk), .Q(
        add_i_6[1]) );
  DFFTRX2 add_i_4_reg_1_ ( .D(n558), .RN(sram_Q4[1]), .CK(i_clk), .Q(
        add_i_4[1]) );
  DFFTRX1 add_i_3_reg_5_ ( .D(n559), .RN(sram_Q3[5]), .CK(i_clk), .Q(
        add_i_3[5]) );
  DFFHQX2 outside_pipeline_1_reg ( .D(N573), .CK(i_clk), .Q(outside_pipeline_1) );
  DFFRHQX4 out_data_conv_reg_7_ ( .D(N195), .CK(i_clk), .RN(1'b1), .Q(
        out_data_conv[7]) );
  DFFTRX1 add_i_7_reg_2_ ( .D(n559), .RN(sram_Q7[2]), .CK(i_clk), .Q(
        add_i_7[2]) );
  DFFHQX2 addr_incre_reg_1_ ( .D(N412), .CK(i_clk), .Q(addr_incre[1]) );
  DFFTRX2 out_data_conv_reg_12_ ( .D(N183), .RN(n566), .CK(i_clk), .Q(
        out_data_conv[12]) );
  DFFHQX4 out_data_conv_reg_5_ ( .D(N193), .CK(i_clk), .Q(out_data_conv[5]) );
  DFFHQX2 addr_incre_reg_2_ ( .D(N413), .CK(i_clk), .Q(addr_incre[2]) );
  DFFTRX1 add_i_3_reg_2_ ( .D(n559), .RN(sram_Q3[2]), .CK(i_clk), .Q(
        add_i_3[2]) );
  DFFTRX1 add_i_2_reg_2_ ( .D(n559), .RN(sram_Q2[2]), .CK(i_clk), .Q(
        add_i_2[2]) );
  DFFHQX4 out_data_conv_reg_4_ ( .D(N192), .CK(i_clk), .Q(out_data_conv[4]) );
  DFFRHQX8 out_data_conv_reg_6_ ( .D(N194), .CK(i_clk), .RN(1'b1), .Q(
        out_data_conv[6]) );
  DFFQX4 row_t_reg_0_ ( .D(n532), .CK(i_clk), .Q(row_t[0]) );
  DFFQX4 col_t_reg_2_ ( .D(n536), .CK(i_clk), .Q(col_t[2]) );
  DFFRX4 row_reg_2_ ( .D(n537), .CK(i_clk), .RN(n744), .Q(row[2]), .QN(n570)
         );
  DFFTRX4 temp5_reg_7_ ( .D(N138), .RN(n560), .CK(i_clk), .QN(n5950) );
  DFFRX2 out_data_reg_reg_12_ ( .D(n500), .CK(i_clk), .RN(n744), .Q(
        o_out_data[12]) );
  DFFTRX4 out_data_conv_reg_16_ ( .D(N187), .RN(n566), .CK(i_clk), .Q(
        out_data_conv[16]) );
  DFFRHQX8 out_data_conv_reg_10_ ( .D(N198), .CK(i_clk), .RN(1'b1), .Q(
        out_data_conv[10]) );
  DFFHQX4 out_data_conv_reg_8_ ( .D(N196), .CK(i_clk), .Q(out_data_conv[8]) );
  OR2X6 U453 ( .A(n1116), .B(n1104), .Y(n636) );
  INVX6 U454 ( .A(answer[9]), .Y(n1104) );
  NAND2X1 U455 ( .A(n608), .B(n718), .Y(n627) );
  NAND2X4 U456 ( .A(N179), .B(n566), .Y(n631) );
  NAND2X2 U457 ( .A(n630), .B(n631), .Y(N196) );
  CLKINVX4 U458 ( .A(n1012), .Y(n1023) );
  AND4X1 U459 ( .A(n1033), .B(n588), .C(n646), .D(n733), .Y(n590) );
  CLKMX2X2 U460 ( .A(n1022), .B(n562), .S0(n588), .Y(n1015) );
  OR4X4 U461 ( .A(n762), .B(n761), .C(n760), .D(n759), .Y(n891) );
  NAND4X2 U462 ( .A(n785), .B(n602), .C(n607), .D(counter[7]), .Y(n778) );
  INVX8 U463 ( .A(n665), .Y(n1111) );
  BUFX12 U464 ( .A(n1114), .Y(n5570) );
  NAND2X4 U465 ( .A(n641), .B(n1060), .Y(N555) );
  MXI2X2 U466 ( .A(n702), .B(n703), .S0(n743), .Y(n539) );
  AOI2BB1X2 U467 ( .A0N(n679), .A1N(n1088), .B0(row_t[1]), .Y(n993) );
  CLKMX2X4 U468 ( .A(n814), .B(n813), .S0(addr_incre[1]), .Y(N412) );
  CLKBUFX6 U469 ( .A(addr_SRAM[7]), .Y(n742) );
  NAND2X1 U470 ( .A(n1205), .B(n871), .Y(n872) );
  INVX3 U471 ( .A(n810), .Y(n1021) );
  INVX3 U472 ( .A(n972), .Y(n973) );
  OAI221X4 U473 ( .A0(n809), .A1(n810), .B0(n647), .B1(n1029), .C0(n808), .Y(
        N413) );
  NAND2X4 U474 ( .A(n906), .B(n726), .Y(n790) );
  INVX8 U475 ( .A(answer[4]), .Y(n1109) );
  NAND4X4 U476 ( .A(i_op_mode[0]), .B(i_op_mode[2]), .C(i_op_valid), .D(n726), 
        .Y(n776) );
  XOR2X4 U477 ( .A(n807), .B(addr_incre[1]), .Y(n827) );
  OAI2BB1X1 U478 ( .A0N(n878), .A1N(col_t[0]), .B0(n844), .Y(n535) );
  CLKMX2X2 U479 ( .A(n843), .B(n842), .S0(n1202), .Y(n844) );
  NAND3X8 U480 ( .A(n5990), .B(n655), .C(n656), .Y(answer_ex[4]) );
  OR2X4 U481 ( .A(n1116), .B(n1106), .Y(n651) );
  OR2X4 U482 ( .A(n1109), .B(n1116), .Y(n655) );
  OR2X6 U483 ( .A(n1116), .B(n1110), .Y(n662) );
  NAND3X8 U484 ( .A(i_op_valid), .B(n774), .C(n773), .Y(n1140) );
  NOR2X4 U485 ( .A(i_op_mode[0]), .B(n898), .Y(n773) );
  NAND4X2 U486 ( .A(n783), .B(n782), .C(n766), .D(n781), .Y(n767) );
  INVX8 U487 ( .A(n722), .Y(n723) );
  INVX4 U488 ( .A(n1146), .Y(n969) );
  OAI31X2 U489 ( .A0(n792), .A1(n791), .A2(n790), .B0(n894), .Y(n1146) );
  CLKAND2X2 U490 ( .A(N271), .B(n795), .Y(N280) );
  CLKAND2X2 U491 ( .A(N273), .B(n795), .Y(N282) );
  INVX6 U492 ( .A(counter[1]), .Y(n718) );
  NAND3X2 U493 ( .A(n642), .B(n616), .C(n567), .Y(n643) );
  INVX8 U494 ( .A(n719), .Y(n720) );
  AND2X8 U495 ( .A(N274), .B(n732), .Y(N283) );
  AND2X6 U496 ( .A(N275), .B(n732), .Y(N284) );
  AND2X4 U497 ( .A(N272), .B(n732), .Y(N281) );
  INVX4 U498 ( .A(answer[3]), .Y(n584) );
  INVX20 U499 ( .A(n1085), .Y(n1037) );
  CLKBUFX8 U500 ( .A(n530), .Y(n560) );
  INVXL U501 ( .A(n617), .Y(n609) );
  INVX12 U502 ( .A(n716), .Y(n717) );
  NAND3X4 U503 ( .A(n683), .B(n482), .C(n481), .Y(n764) );
  NAND2X6 U504 ( .A(n1027), .B(n671), .Y(n1051) );
  INVX4 U505 ( .A(n1096), .Y(n1119) );
  NAND2X8 U506 ( .A(n770), .B(n629), .Y(n886) );
  NAND4X4 U507 ( .A(n572), .B(n671), .C(n711), .D(i_rst_n), .Y(n770) );
  XOR2X1 U508 ( .A(n569), .B(col_t[2]), .Y(n837) );
  XOR2X4 U509 ( .A(col_t[2]), .B(n852), .Y(n860) );
  CLKAND2X12 U510 ( .A(n1073), .B(n1138), .Y(n788) );
  NAND2X2 U511 ( .A(n679), .B(n1088), .Y(n1038) );
  BUFX8 U512 ( .A(n1145), .Y(n648) );
  NAND2X2 U513 ( .A(out_data_conv[3]), .B(n670), .Y(n1120) );
  NAND3X4 U514 ( .A(n960), .B(n657), .C(n607), .Y(n684) );
  NAND4X2 U515 ( .A(n602), .B(n914), .C(n960), .D(addr_SRAM[4]), .Y(n762) );
  NAND4X4 U516 ( .A(n700), .B(n604), .C(counter[2]), .D(n960), .Y(n779) );
  OAI211X4 U517 ( .A0(counter[2]), .A1(n960), .B0(n608), .C0(n959), .Y(n1036)
         );
  INVX4 U518 ( .A(n515), .Y(n960) );
  NAND2X6 U519 ( .A(n736), .B(n980), .Y(n1045) );
  NAND3X8 U520 ( .A(n635), .B(n636), .C(n637), .Y(answer_ex[9]) );
  OR2X4 U521 ( .A(n1111), .B(n1106), .Y(n637) );
  NOR3X6 U522 ( .A(n791), .B(n625), .C(i_op_mode[3]), .Y(n585) );
  CLKINVX20 U523 ( .A(i_op_mode[2]), .Y(n625) );
  NAND2X2 U524 ( .A(n958), .B(n608), .Y(n967) );
  INVX4 U525 ( .A(n959), .Y(n958) );
  NAND2X8 U526 ( .A(n1067), .B(n624), .Y(n793) );
  INVX8 U527 ( .A(n886), .Y(n775) );
  AND2X2 U528 ( .A(answer[10]), .B(n1102), .Y(answer_ex[12]) );
  OAI211X2 U529 ( .A0(n953), .A1(n952), .B0(n951), .C0(n950), .Y(n1148) );
  OAI31X4 U530 ( .A0(n947), .A1(col_t[0]), .A2(n946), .B0(n945), .Y(n952) );
  AO22X4 U531 ( .A0(n727), .A1(n1119), .B0(N176), .B1(n566), .Y(N193) );
  NAND3X4 U532 ( .A(n736), .B(n1033), .C(n646), .Y(n990) );
  OAI221X1 U533 ( .A0(n1078), .A1(n1077), .B0(n1149), .B1(n1076), .C0(n1075), 
        .Y(n496) );
  NAND2X1 U534 ( .A(n1073), .B(n1080), .Y(n1078) );
  AND3X2 U535 ( .A(n658), .B(n603), .C(n605), .Y(n784) );
  CLKINVX1 U536 ( .A(n604), .Y(n605) );
  INVX3 U537 ( .A(n923), .Y(n1086) );
  NAND3BX1 U538 ( .AN(n938), .B(col_t[0]), .C(n946), .Y(n923) );
  AOI2BB1X2 U539 ( .A0N(row_t[0]), .A1N(n968), .B0(n646), .Y(n992) );
  NAND4X4 U540 ( .A(n686), .B(n853), .C(n763), .D(n855), .Y(n769) );
  CLKXOR2X8 U541 ( .A(n698), .B(col_t[0]), .Y(n853) );
  CLKINVX1 U542 ( .A(n657), .Y(n658) );
  NAND2X4 U543 ( .A(n904), .B(n903), .Y(n975) );
  CLKINVX12 U544 ( .A(i_op_mode[2]), .Y(n904) );
  AO22X4 U545 ( .A0(n619), .A1(n1119), .B0(N174), .B1(n566), .Y(N191) );
  NAND3BX2 U546 ( .AN(n698), .B(n1205), .C(n569), .Y(n846) );
  CLKBUFX8 U547 ( .A(row_t[2]), .Y(n5550) );
  NAND3X8 U548 ( .A(n650), .B(n651), .C(n652), .Y(answer_ex[7]) );
  OR2X4 U549 ( .A(n1111), .B(n713), .Y(n652) );
  BUFX4 U550 ( .A(n869), .Y(n5560) );
  OR2X4 U551 ( .A(n664), .B(extend[1]), .Y(n1114) );
  OAI222X4 U552 ( .A0(n883), .A1(n882), .B0(n881), .B1(n880), .C0(n1089), .C1(
        n879), .Y(n533) );
  INVX6 U553 ( .A(n5950), .Y(n5960) );
  INVX12 U554 ( .A(n5970), .Y(n5980) );
  BUFX3 U555 ( .A(answer[9]), .Y(n728) );
  OR2X2 U556 ( .A(n1115), .B(n1111), .Y(n663) );
  OR2X2 U557 ( .A(n1113), .B(n1111), .Y(n656) );
  NAND4X4 U558 ( .A(n1005), .B(n1065), .C(n5930), .D(n1066), .Y(n794) );
  OAI222X1 U559 ( .A0(n757), .A1(n570), .B0(n756), .B1(n755), .C0(n867), .C1(
        n754), .Y(n537) );
  INVX4 U560 ( .A(n1152), .Y(n1076) );
  NAND3X8 U561 ( .A(n632), .B(n633), .C(n634), .Y(answer_ex[8]) );
  OR2X2 U562 ( .A(n1111), .B(n1107), .Y(n634) );
  INVX1 U563 ( .A(n947), .Y(n897) );
  NAND2X6 U564 ( .A(n934), .B(n620), .Y(n947) );
  OAI31X2 U565 ( .A0(n739), .A1(n741), .A2(n738), .B0(n735), .Y(n979) );
  XOR2XL U566 ( .A(n735), .B(n676), .Y(n957) );
  AND4X4 U567 ( .A(n915), .B(addr_SRAM[2]), .C(n914), .D(n735), .Y(n699) );
  CLKBUFX8 U568 ( .A(n600), .Y(n735) );
  NAND2X4 U569 ( .A(n934), .B(n945), .Y(n935) );
  NAND2X2 U570 ( .A(n946), .B(col_t[0]), .Y(n945) );
  INVX6 U571 ( .A(answer[10]), .Y(n1103) );
  INVX16 U572 ( .A(i_op_mode[0]), .Y(n903) );
  BUFX12 U573 ( .A(n666), .Y(n558) );
  BUFX12 U574 ( .A(n666), .Y(n559) );
  AND2X4 U575 ( .A(n667), .B(n560), .Y(n666) );
  XOR2X1 U576 ( .A(n564), .B(row_t[0]), .Y(n856) );
  XNOR2X1 U577 ( .A(n564), .B(row_t[0]), .Y(n617) );
  AOI32XL U578 ( .A0(n1035), .A1(n620), .A2(n1088), .B0(row_t[0]), .B1(n968), 
        .Y(n997) );
  NAND2X6 U579 ( .A(n680), .B(n1044), .Y(n1004) );
  INVX1 U580 ( .A(n737), .Y(n1044) );
  AO22X4 U581 ( .A0(n614), .A1(n1119), .B0(n566), .B1(N177), .Y(N194) );
  OAI222X2 U582 ( .A0(n1115), .A1(n5570), .B0(n1116), .B1(n1113), .C0(n1112), 
        .C1(n1111), .Y(answer_ex[2]) );
  INVXL U583 ( .A(n1111), .Y(n1102) );
  NAND3BX1 U584 ( .AN(n671), .B(state[2]), .C(n888), .Y(n890) );
  NAND3BX4 U585 ( .AN(n1079), .B(n1081), .C(n678), .Y(n888) );
  OR2X4 U586 ( .A(n612), .B(state[0]), .Y(n765) );
  INVX3 U587 ( .A(n711), .Y(n612) );
  NAND3X4 U588 ( .A(n822), .B(n848), .C(n846), .Y(n845) );
  NOR2BX4 U589 ( .AN(n979), .B(n736), .Y(n680) );
  CLKBUFX6 U590 ( .A(addr_SRAM[4]), .Y(n736) );
  NOR2X8 U591 ( .A(n794), .B(n793), .Y(n732) );
  NOR2X8 U592 ( .A(n794), .B(n793), .Y(n795) );
  INVX12 U593 ( .A(n1116), .Y(n1118) );
  NAND2X8 U594 ( .A(n5570), .B(n1111), .Y(n1116) );
  CLKBUFX3 U595 ( .A(n734), .Y(n561) );
  NAND2X1 U596 ( .A(n1082), .B(n1081), .Y(n530) );
  NAND2XL U597 ( .A(n1082), .B(n1081), .Y(n734) );
  XOR2X4 U598 ( .A(n969), .B(n612), .Y(n624) );
  INVX4 U599 ( .A(answer[3]), .Y(n1110) );
  INVX8 U600 ( .A(n936), .Y(n946) );
  AO21X4 U601 ( .A0(n909), .A1(n1099), .B0(n607), .Y(n936) );
  CLKAND2X2 U602 ( .A(n1035), .B(n1085), .Y(n679) );
  INVX4 U603 ( .A(n967), .Y(n1035) );
  AND3X4 U604 ( .A(n933), .B(col_t[1]), .C(n1085), .Y(n911) );
  CLKINVX3 U605 ( .A(n935), .Y(n933) );
  AO22X4 U606 ( .A0(answer[1]), .A1(n1118), .B0(n1117), .B1(answer[0]), .Y(
        answer_ex[1]) );
  OAI2BB2X4 U607 ( .B0(n1106), .B1(n1096), .A0N(N178), .A1N(n566), .Y(N195) );
  NAND2X4 U608 ( .A(n643), .B(n789), .Y(n908) );
  AOI221X2 U609 ( .A0(n788), .A1(n787), .B0(state[0]), .B1(n572), .C0(n786), 
        .Y(n789) );
  NAND3BX4 U610 ( .AN(counter[7]), .B(n479), .C(n784), .Y(n1100) );
  INVX6 U611 ( .A(n884), .Y(n934) );
  NAND2X6 U612 ( .A(n917), .B(n1142), .Y(n1053) );
  INVX2 U613 ( .A(n909), .Y(n829) );
  INVX3 U614 ( .A(n5550), .Y(n1087) );
  INVX4 U615 ( .A(n653), .Y(n654) );
  INVX1 U616 ( .A(answer[0]), .Y(n1112) );
  AND2XL U617 ( .A(n926), .B(n482), .Y(n676) );
  NAND3X6 U618 ( .A(n661), .B(n662), .C(n663), .Y(answer_ex[3]) );
  OR2X4 U619 ( .A(n5570), .B(n1113), .Y(n661) );
  NAND2X2 U620 ( .A(row_t[1]), .B(n648), .Y(n974) );
  NAND2X2 U621 ( .A(n1036), .B(n967), .Y(n1034) );
  OAI211XL U622 ( .A0(n1044), .A1(n1045), .B0(n1073), .C0(n1028), .Y(n1009) );
  NAND2X2 U623 ( .A(n660), .B(n1000), .Y(n1022) );
  NAND2X1 U624 ( .A(n934), .B(n1085), .Y(n924) );
  NAND2X2 U625 ( .A(n626), .B(n939), .Y(n941) );
  NAND2X1 U626 ( .A(n5730), .B(n827), .Y(n811) );
  INVX3 U627 ( .A(n800), .Y(n803) );
  INVX1 U628 ( .A(n618), .Y(n801) );
  INVX1 U629 ( .A(n615), .Y(n804) );
  BUFX4 U630 ( .A(n1019), .Y(n647) );
  NAND4X2 U631 ( .A(n1041), .B(n1040), .C(n1039), .D(n1038), .Y(n1058) );
  AOI2BB1XL U632 ( .A0N(n682), .A1N(n1034), .B0(n1087), .Y(n1041) );
  NAND3BX1 U633 ( .AN(row_t[1]), .B(n1035), .C(n620), .Y(n1040) );
  OA22X2 U634 ( .A0(n682), .A1(n620), .B0(n1037), .B1(n1036), .Y(n1039) );
  NAND2X4 U635 ( .A(n831), .B(n861), .Y(n879) );
  AND3X2 U636 ( .A(n617), .B(n838), .C(n837), .Y(n839) );
  INVX4 U637 ( .A(n908), .Y(n894) );
  CLKINVX6 U638 ( .A(n1100), .Y(n1081) );
  CLKINVX1 U639 ( .A(n970), .Y(n1063) );
  INVX4 U640 ( .A(n898), .Y(n906) );
  INVX4 U641 ( .A(n821), .Y(n819) );
  XOR2X1 U642 ( .A(n1205), .B(n698), .Y(n869) );
  INVX3 U643 ( .A(n623), .Y(n818) );
  XOR2X1 U644 ( .A(n570), .B(n5550), .Y(n763) );
  INVX3 U645 ( .A(answer[8]), .Y(n1105) );
  NAND2X1 U646 ( .A(n718), .B(n516), .Y(n1072) );
  AO21X1 U647 ( .A0(n524), .A1(n1207), .B0(n1206), .Y(n783) );
  CLKINVX8 U648 ( .A(n1004), .Y(n1043) );
  XOR2X1 U649 ( .A(n5560), .B(col_t[1]), .Y(n854) );
  AND2X6 U650 ( .A(n758), .B(n657), .Y(n700) );
  NAND2X4 U651 ( .A(i_op_mode[1]), .B(i_op_mode[2]), .Y(n901) );
  NAND2BX1 U652 ( .AN(n1036), .B(n1085), .Y(n972) );
  NAND2X1 U653 ( .A(n608), .B(n514), .Y(n1079) );
  NAND2X4 U654 ( .A(state[2]), .B(n711), .Y(n889) );
  INVX3 U655 ( .A(n602), .Y(n603) );
  NAND3X2 U656 ( .A(n781), .B(n783), .C(n782), .Y(n787) );
  NAND2X1 U657 ( .A(n480), .B(n481), .Y(n925) );
  NAND2X2 U658 ( .A(n678), .B(n1002), .Y(n1011) );
  AND2X2 U659 ( .A(i_op_mode[3]), .B(n906), .Y(n705) );
  CLKINVX1 U660 ( .A(n899), .Y(n893) );
  NAND3X1 U661 ( .A(n976), .B(i_op_valid), .C(n906), .Y(n892) );
  XOR2X1 U662 ( .A(n571), .B(addr_incre[0]), .Y(n828) );
  XOR2X1 U663 ( .A(n563), .B(col_t[1]), .Y(n838) );
  AND2X2 U664 ( .A(state[0]), .B(n711), .Y(n696) );
  CLKMX2X2 U665 ( .A(n1024), .B(n1023), .S0(n588), .Y(n586) );
  INVX3 U666 ( .A(n600), .Y(n601) );
  CLKINVX1 U667 ( .A(n1047), .Y(n1028) );
  INVX3 U668 ( .A(n1206), .Y(n807) );
  CLKINVX1 U669 ( .A(n845), .Y(n852) );
  OAI222X1 U670 ( .A0(n799), .A1(n798), .B0(n797), .B1(n796), .C0(n615), .C1(
        n618), .Y(n731) );
  NAND2X2 U671 ( .A(n906), .B(n780), .Y(n1066) );
  OR4X2 U672 ( .A(i_op_mode[1]), .B(i_op_mode[0]), .C(i_op_mode[2]), .D(
        i_op_mode[3]), .Y(n780) );
  OR2X4 U673 ( .A(n1066), .B(n669), .Y(n1064) );
  AOI22X1 U674 ( .A0(n704), .A1(n977), .B0(i_op_valid), .B1(n726), .Y(n669) );
  CLKINVX1 U675 ( .A(n975), .Y(n977) );
  INVX3 U676 ( .A(n613), .Y(n755) );
  AND2X2 U677 ( .A(n696), .B(n572), .Y(o_op_ready) );
  NAND3X1 U678 ( .A(n638), .B(n639), .C(n640), .Y(n545) );
  AO22X1 U679 ( .A0(n712), .A1(n1119), .B0(N175), .B1(n566), .Y(N192) );
  NAND4X2 U680 ( .A(n944), .B(n943), .C(n942), .D(n941), .Y(N552) );
  AO21X2 U681 ( .A0(n751), .A1(n750), .B0(n749), .Y(n538) );
  OAI211X1 U682 ( .A0(n1093), .A1(n1092), .B0(n1090), .C0(n1091), .Y(N573) );
  AOI32X1 U683 ( .A0(col_t[2]), .A1(n1086), .A2(n620), .B0(n5550), .B1(n701), 
        .Y(n1091) );
  AOI2BB1X1 U684 ( .A0N(n1101), .A1N(n1100), .B0(N165), .Y(N164) );
  OAI221XL U685 ( .A0(n1135), .A1(n610), .B0(n1195), .B1(n670), .C0(n1131), 
        .Y(n1216) );
  OAI221XL U686 ( .A0(n1135), .A1(n1133), .B0(n1194), .B1(n670), .C0(n1132), 
        .Y(n1217) );
  OAI221XL U687 ( .A0(n1135), .A1(n575), .B0(n469), .B1(n670), .C0(n1134), .Y(
        n505) );
  AO22X1 U688 ( .A0(out_data_conv[15]), .A1(n1137), .B0(N244), .B1(n1136), .Y(
        n501) );
  OAI222X1 U689 ( .A0(n807), .A1(n804), .B0(n803), .B1(n571), .C0(n802), .C1(
        n801), .Y(n544) );
  AO22X2 U690 ( .A0(n1203), .A1(n731), .B0(n615), .B1(n1204), .Y(n546) );
  AOI2BB2X2 U691 ( .B0(n993), .B1(n992), .A0N(n990), .A1N(n991), .Y(n994) );
  MXI2X1 U692 ( .A(n877), .B(n876), .S0(n743), .Y(n695) );
  CLKINVX1 U693 ( .A(n880), .Y(n877) );
  NAND3BX1 U694 ( .AN(n897), .B(n896), .C(n1056), .Y(n922) );
  OAI211X1 U695 ( .A0(n1063), .A1(n908), .B0(n907), .C0(n733), .Y(n921) );
  OAI222XL U696 ( .A0(n570), .A1(n882), .B0(n880), .B1(n867), .C0(n1087), .C1(
        n879), .Y(n531) );
  OAI2BB1X1 U697 ( .A0N(n875), .A1N(n874), .B0(n873), .Y(n534) );
  AND2X2 U698 ( .A(N269), .B(n795), .Y(N278) );
  AND2X2 U699 ( .A(n795), .B(N268), .Y(N277) );
  NAND2X1 U700 ( .A(i_op_mode[1]), .B(n906), .Y(n777) );
  MXI2X1 U701 ( .A(n824), .B(n823), .S0(n1205), .Y(n826) );
  BUFX12 U702 ( .A(addr_SRAM[1]), .Y(n741) );
  BUFX12 U703 ( .A(addr_SRAM[2]), .Y(n739) );
  CLKAND2X3 U704 ( .A(n1073), .B(n1001), .Y(n562) );
  OAI32X1 U705 ( .A0(n1045), .A1(n1047), .A2(n1044), .B0(n1043), .B1(n1002), 
        .Y(n1001) );
  NAND3BX2 U706 ( .AN(n898), .B(i_op_valid), .C(n726), .Y(n902) );
  INVX16 U707 ( .A(i_op_mode[3]), .Y(n726) );
  INVX3 U708 ( .A(n620), .Y(n5940) );
  INVX4 U709 ( .A(n889), .Y(n1027) );
  XOR2X1 U710 ( .A(n1042), .B(n737), .Y(n1054) );
  INVX8 U711 ( .A(n729), .Y(n730) );
  NAND3BX2 U712 ( .AN(state[2]), .B(n644), .C(n671), .Y(n898) );
  INVX12 U713 ( .A(n591), .Y(n1085) );
  INVX8 U714 ( .A(n621), .Y(n622) );
  NAND2XL U715 ( .A(n1073), .B(n1138), .Y(n1005) );
  INVX3 U716 ( .A(n1002), .Y(n1138) );
  AOI221X4 U717 ( .A0(n991), .A1(n1202), .B0(N486), .B1(n1049), .C0(n949), .Y(
        n951) );
  AOI221X1 U718 ( .A0(n1205), .A1(n991), .B0(N487), .B1(n1049), .C0(n918), .Y(
        n919) );
  NAND2X1 U719 ( .A(N491), .B(n1049), .Y(n1050) );
  CLKMX2X2 U720 ( .A(n872), .B(n938), .S0(n878), .Y(n873) );
  NAND3BX1 U721 ( .AN(n878), .B(n871), .C(n1201), .Y(n850) );
  OAI2BB1X1 U722 ( .A0N(n878), .A1N(row_t[0]), .B0(n695), .Y(n532) );
  NAND2X2 U723 ( .A(n678), .B(counter[2]), .Y(n909) );
  NAND2X2 U724 ( .A(n1072), .B(counter[2]), .Y(n959) );
  OR3X1 U725 ( .A(counter[2]), .B(counter[0]), .C(n706), .Y(n1098) );
  NAND2BX1 U726 ( .AN(n915), .B(n1142), .Y(n1065) );
  CLKBUFX3 U727 ( .A(state[1]), .Y(n644) );
  BUFX8 U728 ( .A(row[0]), .Y(n743) );
  AND3XL U729 ( .A(addr_SRAM[5]), .B(addr_SRAM[4]), .C(addr_SRAM[0]), .Y(n565)
         );
  CLKAND2X3 U730 ( .A(n1095), .B(n1094), .Y(n566) );
  AND4X1 U731 ( .A(n858), .B(n855), .C(o_out_valid_pipeline_3), .D(n696), .Y(
        n567) );
  INVX3 U732 ( .A(answer[1]), .Y(n1115) );
  AND2X2 U733 ( .A(n965), .B(n966), .Y(n568) );
  AND4X2 U734 ( .A(row_t[1]), .B(row_t[0]), .C(n1035), .D(n1085), .Y(n701) );
  INVX16 U735 ( .A(i_op_mode[3]), .Y(n976) );
  INVX3 U736 ( .A(n607), .Y(n608) );
  AND2X2 U737 ( .A(n1029), .B(n828), .Y(n5730) );
  INVX12 U738 ( .A(n649), .Y(n1073) );
  AO21X2 U739 ( .A0(n1138), .A1(n602), .B0(n1139), .Y(n1143) );
  NAND2X1 U740 ( .A(n938), .B(n910), .Y(n1093) );
  INVX8 U742 ( .A(n724), .Y(n725) );
  INVX3 U743 ( .A(n577), .Y(n578) );
  AND4X1 U744 ( .A(n1087), .B(n1089), .C(n1088), .D(n968), .Y(n1057) );
  NAND4X1 U745 ( .A(n968), .B(n1089), .C(n1088), .D(n1087), .Y(n1090) );
  CLKINVX1 U746 ( .A(n968), .Y(n961) );
  NAND2X4 U747 ( .A(n1034), .B(n1085), .Y(n968) );
  NOR2X2 U748 ( .A(n885), .B(n898), .Y(n887) );
  AND2X1 U749 ( .A(N133), .B(n561), .Y(n5790) );
  INVX3 U750 ( .A(n580), .Y(n581) );
  INVX3 U751 ( .A(n582), .Y(n583) );
  NAND4BX4 U752 ( .AN(n590), .B(n586), .C(n1025), .D(n1026), .Y(N556) );
  NAND3BX2 U753 ( .AN(n5940), .B(addr_incre[0]), .C(n1056), .Y(n1025) );
  AO21X4 U754 ( .A0(row[1]), .A1(n743), .B0(row[2]), .Y(n834) );
  NAND2X1 U755 ( .A(n5550), .B(n834), .Y(n835) );
  OA22X2 U756 ( .A0(n681), .A1(n1048), .B0(n1046), .B1(n1047), .Y(n1052) );
  XOR2X1 U757 ( .A(n1045), .B(n737), .Y(n1046) );
  AND4X2 U758 ( .A(o_out_valid_pipeline_3), .B(n711), .C(state[0]), .D(n856), 
        .Y(n686) );
  INVX12 U759 ( .A(answer[2]), .Y(n1113) );
  OAI2BB2X4 U760 ( .B0(n1103), .B1(n5570), .A0N(n728), .A1N(n1102), .Y(
        answer_ex[11]) );
  AND3X4 U761 ( .A(i_op_mode[1]), .B(i_op_mode[2]), .C(i_op_mode[0]), .Y(n792)
         );
  BUFX12 U762 ( .A(i_rst_n), .Y(n744) );
  INVXL U763 ( .A(n1113), .Y(n587) );
  INVX3 U764 ( .A(n588), .Y(n589) );
  AO22X4 U765 ( .A0(n728), .A1(n1119), .B0(N180), .B1(n566), .Y(N197) );
  INVX12 U766 ( .A(answer[7]), .Y(n1106) );
  NOR2X8 U767 ( .A(n806), .B(n901), .Y(n591) );
  NAND4BBX1 U768 ( .AN(n932), .BN(n1044), .C(n646), .D(n733), .Y(n1061) );
  NAND2X1 U769 ( .A(n649), .B(n1139), .Y(n932) );
  CLKAND2X4 U770 ( .A(n970), .B(n969), .Y(n677) );
  OA21X4 U771 ( .A0(n940), .A1(n947), .B0(n1056), .Y(n626) );
  INVX16 U772 ( .A(n646), .Y(n1056) );
  NOR3BX2 U773 ( .AN(n1142), .B(n1002), .C(n603), .Y(n5920) );
  CLKINVX20 U774 ( .A(n5920), .Y(n1144) );
  INVX8 U775 ( .A(n1139), .Y(n1142) );
  OR3X8 U776 ( .A(n516), .B(n514), .C(n684), .Y(n1002) );
  CLKMX2X2 U777 ( .A(n1021), .B(n1020), .S0(addr_incre[0]), .Y(N411) );
  AOI2BB1X1 U778 ( .A0N(n680), .A1N(n981), .B0(n681), .Y(n982) );
  INVX1 U779 ( .A(n1045), .Y(n981) );
  INVX3 U780 ( .A(n931), .Y(n606) );
  CLKBUFX3 U781 ( .A(n1068), .Y(n5930) );
  XOR2X2 U782 ( .A(n969), .B(n711), .Y(n1070) );
  INVX6 U783 ( .A(n516), .Y(n785) );
  INVX4 U784 ( .A(n1108), .Y(n727) );
  INVX8 U785 ( .A(answer[5]), .Y(n1108) );
  INVX16 U786 ( .A(n1037), .Y(n620) );
  OR2X4 U787 ( .A(n5570), .B(n1105), .Y(n635) );
  CLKXOR2X2 U788 ( .A(n883), .B(n743), .Y(n881) );
  OR2X2 U789 ( .A(n5570), .B(n584), .Y(n5990) );
  NAND3X8 U790 ( .A(n685), .B(n895), .C(n894), .Y(n668) );
  AND3X4 U791 ( .A(i_op_mode[0]), .B(n816), .C(n815), .Y(n623) );
  AOI2BB1X1 U792 ( .A0N(n563), .A1N(n822), .B0(i_op_mode[1]), .Y(n815) );
  NAND2X1 U793 ( .A(answer[8]), .B(n1119), .Y(n630) );
  NAND3BX4 U794 ( .AN(n974), .B(n973), .C(n677), .Y(n989) );
  AND4X2 U795 ( .A(n485), .B(n480), .C(n484), .D(n601), .Y(n683) );
  NAND2X1 U796 ( .A(n1067), .B(n1066), .Y(n1069) );
  AND3X8 U797 ( .A(i_op_mode[1]), .B(n585), .C(n903), .Y(n618) );
  OR3X6 U798 ( .A(n905), .B(n746), .C(i_op_mode[0]), .Y(n821) );
  CLKINVX8 U799 ( .A(n746), .Y(n816) );
  NAND3BX4 U800 ( .AN(i_op_mode[3]), .B(i_op_valid), .C(n904), .Y(n746) );
  AOI21X4 U801 ( .A0(n606), .A1(n1056), .B0(n930), .Y(n944) );
  AOI22X2 U802 ( .A0(n962), .A1(n1056), .B0(n743), .B1(n991), .Y(n964) );
  OR2X2 U803 ( .A(n978), .B(n601), .Y(n998) );
  AND2X6 U804 ( .A(answer[0]), .B(n1118), .Y(answer_ex[0]) );
  AOI32X2 U805 ( .A0(n934), .A1(col_t[1]), .A2(n620), .B0(n5940), .B1(n938), 
        .Y(n913) );
  NAND4BBX2 U806 ( .AN(n589), .BN(n524), .C(n1207), .D(n764), .Y(n781) );
  AO22X4 U807 ( .A0(out_data_conv[16]), .A1(n1137), .B0(N245), .B1(n1136), .Y(
        n500) );
  NAND4X1 U808 ( .A(n1033), .B(n739), .C(n646), .D(n733), .Y(n943) );
  NAND2BX2 U809 ( .AN(n803), .B(n1204), .Y(n639) );
  AOI33X4 U810 ( .A0(n1086), .A1(n1083), .A2(n620), .B0(col_t[2]), .B1(
        col_t[0]), .B2(n924), .Y(n931) );
  AND3X8 U811 ( .A(i_op_mode[1]), .B(i_op_mode[0]), .C(n816), .Y(n613) );
  INVX16 U812 ( .A(i_op_mode[1]), .Y(n905) );
  NAND2X1 U813 ( .A(n909), .B(n1085), .Y(n1019) );
  INVXL U814 ( .A(n1107), .Y(n614) );
  AOI2BB1X1 U815 ( .A0N(row[2]), .A1N(row[1]), .B0(n755), .Y(n747) );
  AND3X8 U816 ( .A(i_op_mode[0]), .B(n585), .C(n905), .Y(n615) );
  INVX3 U817 ( .A(n752), .Y(n757) );
  NOR2BX4 U818 ( .AN(n853), .B(n617), .Y(n616) );
  CLKMX2X2 U819 ( .A(n748), .B(n752), .S0(row[1]), .Y(n749) );
  NAND2XL U820 ( .A(addr_incre[1]), .B(n620), .Y(n1018) );
  AOI2BB1X1 U821 ( .A0N(n743), .A1N(n756), .B0(i_op_mode[0]), .Y(n745) );
  NAND2X1 U822 ( .A(n905), .B(n807), .Y(n798) );
  INVXL U823 ( .A(n584), .Y(n619) );
  NOR2X1 U824 ( .A(n1022), .B(n562), .Y(n1024) );
  CLKINVX1 U825 ( .A(n765), .Y(n766) );
  AO21X4 U826 ( .A0(col_t[0]), .A1(n1084), .B0(n646), .Y(n953) );
  AND3X6 U827 ( .A(n905), .B(n625), .C(n976), .Y(n774) );
  INVX8 U828 ( .A(answer[6]), .Y(n1107) );
  NAND2X1 U829 ( .A(n1201), .B(n563), .Y(n848) );
  AND2X4 U830 ( .A(n1011), .B(n1002), .Y(n681) );
  NAND3BX1 U831 ( .AN(n810), .B(addr_incre[2]), .C(n1030), .Y(n808) );
  NAND3BX4 U832 ( .AN(n1037), .B(n829), .C(n811), .Y(n810) );
  OAI211X2 U833 ( .A0(n646), .A1(n1018), .B0(n1017), .C0(n1016), .Y(N557) );
  CLKINVX1 U834 ( .A(n754), .Y(n751) );
  NAND3BX4 U835 ( .AN(i_op_mode[1]), .B(n585), .C(n745), .Y(n754) );
  NAND3X2 U836 ( .A(n964), .B(n963), .C(n568), .Y(N553) );
  NAND2XL U837 ( .A(N489), .B(n1049), .Y(n965) );
  NAND2X1 U838 ( .A(n607), .B(n960), .Y(n628) );
  NAND2X2 U839 ( .A(n627), .B(n628), .Y(n706) );
  OA21X4 U840 ( .A0(n772), .A1(n830), .B0(n771), .Y(n629) );
  INVX1 U841 ( .A(n891), .Y(n772) );
  NAND2X4 U842 ( .A(state[0]), .B(n644), .Y(n830) );
  OR2X6 U843 ( .A(n5570), .B(n1106), .Y(n632) );
  OR2X4 U844 ( .A(n1116), .B(n1105), .Y(n633) );
  INVX1 U845 ( .A(addr_incre[2]), .Y(n1029) );
  OR2X1 U846 ( .A(n571), .B(n804), .Y(n638) );
  OR2X1 U847 ( .A(n574), .B(n801), .Y(n640) );
  OA21X4 U848 ( .A0(n733), .A1(n570), .B0(n1061), .Y(n641) );
  INVX1 U849 ( .A(n832), .Y(n642) );
  NAND2X6 U850 ( .A(n837), .B(n838), .Y(n832) );
  CLKMX2X2 U851 ( .A(n754), .B(n743), .S0(n613), .Y(n752) );
  NAND2X6 U852 ( .A(n648), .B(n671), .Y(n1067) );
  INVX12 U853 ( .A(n668), .Y(n645) );
  CLKINVX20 U854 ( .A(n645), .Y(n646) );
  OAI222X2 U855 ( .A0(n1108), .A1(n5570), .B0(n1116), .B1(n1107), .C0(n1109), 
        .C1(n1111), .Y(answer_ex[6]) );
  NAND2X4 U856 ( .A(n718), .B(n785), .Y(n1047) );
  NOR3BX2 U857 ( .AN(row[1]), .B(n697), .C(n1064), .Y(n988) );
  INVXL U858 ( .A(n756), .Y(n753) );
  INVX20 U859 ( .A(i_op_valid), .Y(n791) );
  AND3X1 U860 ( .A(n613), .B(row[2]), .C(n564), .Y(n748) );
  NAND2X4 U861 ( .A(n864), .B(n879), .Y(n882) );
  AOI32X2 U862 ( .A0(n961), .A1(n1088), .A2(n967), .B0(row_t[0]), .B1(n972), 
        .Y(n962) );
  INVX1 U863 ( .A(n882), .Y(n876) );
  AND2X8 U864 ( .A(n785), .B(n960), .Y(n678) );
  AO21X2 U865 ( .A0(n866), .A1(n870), .B0(n865), .Y(n880) );
  NAND2X2 U866 ( .A(n741), .B(n738), .Y(n954) );
  OAI222X2 U867 ( .A0(n5570), .A1(n1104), .B0(n1116), .B1(n1103), .C0(n1111), 
        .C1(n1105), .Y(answer_ex[10]) );
  INVX2 U868 ( .A(n979), .Y(n980) );
  NAND2X1 U869 ( .A(o_out_valid_pipeline_3), .B(n1095), .Y(n1096) );
  OAI31X4 U870 ( .A0(n514), .A1(n607), .A2(n1047), .B0(n1098), .Y(n884) );
  NAND2X2 U871 ( .A(n670), .B(n1120), .Y(n1135) );
  NOR2BX4 U872 ( .AN(n1027), .B(n671), .Y(n670) );
  NAND4X4 U873 ( .A(n860), .B(n859), .C(n858), .D(n857), .Y(n866) );
  XOR2X4 U874 ( .A(n570), .B(n5550), .Y(n858) );
  NAND2X2 U875 ( .A(n830), .B(n572), .Y(n861) );
  NOR3BX4 U876 ( .AN(n989), .B(n988), .C(n987), .Y(n995) );
  OAI221X2 U877 ( .A0(n1053), .A1(n986), .B0(n985), .B1(n649), .C0(n984), .Y(
        n987) );
  OA22X4 U878 ( .A0(n1037), .A1(n936), .B0(n1037), .B1(n935), .Y(n937) );
  NAND2X1 U879 ( .A(N490), .B(n1049), .Y(n984) );
  OAI221X1 U880 ( .A0(n1053), .A1(n929), .B0(n928), .B1(n956), .C0(n927), .Y(
        n930) );
  CLKINVX1 U881 ( .A(n853), .Y(n859) );
  NAND4X4 U882 ( .A(n853), .B(n841), .C(n840), .D(n839), .Y(n870) );
  OAI222X2 U883 ( .A0(n1109), .A1(n5570), .B0(n1108), .B1(n1116), .C0(n1111), 
        .C1(n584), .Y(answer_ex[5]) );
  INVX8 U884 ( .A(n733), .Y(n991) );
  NAND4X6 U885 ( .A(n976), .B(i_op_valid), .C(n906), .D(i_op_mode[0]), .Y(n806) );
  OAI221X2 U886 ( .A0(n836), .A1(n835), .B0(n5550), .B1(n834), .C0(n833), .Y(
        n841) );
  NAND2X2 U887 ( .A(n677), .B(n971), .Y(n996) );
  CLKINVX1 U888 ( .A(n974), .Y(n971) );
  OAI2BB2X4 U889 ( .B0(n1103), .B1(n1096), .A0N(N181), .A1N(n566), .Y(N198) );
  BUFX16 U890 ( .A(n1051), .Y(n649) );
  NOR2BX2 U891 ( .AN(n1154), .B(n1150), .Y(n1163) );
  NOR2X1 U892 ( .A(n1149), .B(n1208), .Y(n1154) );
  AOI22X1 U893 ( .A0(sram_Q1[5]), .A1(n1159), .B0(sram_Q0[5]), .B1(n1160), .Y(
        n1169) );
  AOI22X1 U894 ( .A0(sram_Q1[4]), .A1(n1159), .B0(sram_Q0[4]), .B1(n1160), .Y(
        n1172) );
  AOI22X1 U895 ( .A0(sram_Q1[3]), .A1(n1159), .B0(sram_Q0[3]), .B1(n1160), .Y(
        n1175) );
  AOI22X1 U896 ( .A0(sram_Q1[2]), .A1(n1159), .B0(sram_Q0[2]), .B1(n1160), .Y(
        n1178) );
  AOI22X1 U897 ( .A0(sram_Q1[1]), .A1(n1159), .B0(sram_Q0[1]), .B1(n1160), .Y(
        n1181) );
  AOI22X1 U898 ( .A0(sram_Q1[0]), .A1(n1159), .B0(sram_Q0[0]), .B1(n1160), .Y(
        n1184) );
  NOR3X2 U899 ( .A(n1209), .B(n1208), .C(n1210), .Y(n1160) );
  AOI22X1 U900 ( .A0(sram_Q7[5]), .A1(n1161), .B0(sram_Q6[5]), .B1(n1162), .Y(
        n1168) );
  AOI22X1 U901 ( .A0(sram_Q7[4]), .A1(n1161), .B0(sram_Q6[4]), .B1(n1162), .Y(
        n1171) );
  AOI22X1 U902 ( .A0(sram_Q7[3]), .A1(n1161), .B0(sram_Q6[3]), .B1(n1162), .Y(
        n1174) );
  AOI22X1 U903 ( .A0(sram_Q7[2]), .A1(n1161), .B0(sram_Q6[2]), .B1(n1162), .Y(
        n1177) );
  AOI22X1 U904 ( .A0(sram_Q7[1]), .A1(n1161), .B0(sram_Q6[1]), .B1(n1162), .Y(
        n1180) );
  AOI22X1 U905 ( .A0(sram_Q7[0]), .A1(n1161), .B0(sram_Q6[0]), .B1(n1162), .Y(
        n1183) );
  NOR3X2 U906 ( .A(n1151), .B(n1150), .C(n1149), .Y(n1161) );
  NOR3X2 U907 ( .A(n1151), .B(n1209), .C(n1149), .Y(n1162) );
  NOR3X2 U908 ( .A(n1210), .B(n1208), .C(n1150), .Y(n1159) );
  OR2X2 U909 ( .A(n5570), .B(n1107), .Y(n650) );
  INVX3 U910 ( .A(n727), .Y(n713) );
  INVX1 U911 ( .A(n647), .Y(n1020) );
  NAND2X6 U912 ( .A(n565), .B(n699), .Y(n916) );
  AOI2BB1X2 U913 ( .A0N(n933), .A1N(n938), .B0(n1083), .Y(n940) );
  INVX4 U914 ( .A(extend[0]), .Y(n664) );
  AO22X4 U915 ( .A0(n587), .A1(n1119), .B0(N173), .B1(n566), .Y(N190) );
  CLKINVX1 U916 ( .A(n916), .Y(n917) );
  INVX3 U917 ( .A(n998), .Y(n999) );
  CLKINVX2 U918 ( .A(n866), .Y(n863) );
  AO21X1 U919 ( .A0(n1006), .A1(n737), .B0(n1053), .Y(n1000) );
  NAND2X8 U920 ( .A(i_op_mode[1]), .B(i_op_mode[2]), .Y(n885) );
  INVX1 U921 ( .A(n899), .Y(n900) );
  AO22X2 U922 ( .A0(n1073), .A1(n516), .B0(n1142), .B1(n916), .Y(n1049) );
  NAND3X1 U923 ( .A(n1043), .B(n659), .C(n1073), .Y(n660) );
  INVXL U924 ( .A(n1011), .Y(n659) );
  AO21X2 U925 ( .A0(n681), .A1(n1047), .B0(n649), .Y(n956) );
  OAI211X2 U926 ( .A0(n863), .A1(n862), .B0(n868), .C0(n861), .Y(n864) );
  NAND2X6 U927 ( .A(n862), .B(n861), .Y(n847) );
  NAND2X6 U928 ( .A(n879), .B(n861), .Y(n865) );
  NAND2X1 U929 ( .A(n947), .B(n1083), .Y(n1092) );
  AO22X1 U930 ( .A0(n1206), .A1(n731), .B0(n618), .B1(n1207), .Y(n543) );
  CLKINVX1 U931 ( .A(outside), .Y(n667) );
  NAND2X1 U932 ( .A(n826), .B(n825), .Y(n541) );
  NOR2X1 U933 ( .A(n623), .B(n817), .Y(n673) );
  NAND2XL U934 ( .A(n821), .B(n818), .Y(n672) );
  AOI2BB1XL U935 ( .A0N(n680), .A1N(n1044), .B0(n1043), .Y(n1048) );
  NAND2XL U936 ( .A(n925), .B(n954), .Y(n675) );
  INVX3 U937 ( .A(n1135), .Y(n1137) );
  NAND2X6 U938 ( .A(n868), .B(n870), .Y(n862) );
  NAND2XL U939 ( .A(N492), .B(n1049), .Y(n1026) );
  NAND4BX4 U940 ( .AN(n832), .B(n858), .C(n616), .D(n855), .Y(n868) );
  NAND2BX4 U941 ( .AN(n1079), .B(n1080), .Y(n1095) );
  BUFX20 U942 ( .A(n1062), .Y(n733) );
  MX2XL U943 ( .A(n1003), .B(n1011), .S0(n588), .Y(n1013) );
  AOI2BB1X1 U944 ( .A0N(n1047), .A1N(n983), .B0(n982), .Y(n985) );
  NAND2XL U945 ( .A(n934), .B(n1085), .Y(n1084) );
  OAI2BB1XL U946 ( .A0N(n753), .A1N(n743), .B0(n834), .Y(n867) );
  NOR2BX4 U947 ( .AN(extend[1]), .B(extend[0]), .Y(n665) );
  OR2X4 U948 ( .A(n847), .B(n698), .Y(n871) );
  AOI32X2 U949 ( .A0(col_t[2]), .A1(n938), .A2(n937), .B0(n1093), .B1(n1083), 
        .Y(n939) );
  BUFX12 U950 ( .A(addr_SRAM[5]), .Y(n737) );
  MX2XL U951 ( .A(n1029), .B(n805), .S0(addr_incre[1]), .Y(n809) );
  NAND2XL U952 ( .A(addr_incre[0]), .B(n1029), .Y(n805) );
  NOR2X1 U953 ( .A(n751), .B(n747), .Y(n702) );
  INVXL U954 ( .A(n705), .Y(n697) );
  NAND3BX2 U955 ( .AN(n589), .B(n807), .C(n764), .Y(n782) );
  INVXL U956 ( .A(n881), .Y(n750) );
  NAND2XL U957 ( .A(row[1]), .B(row[2]), .Y(n756) );
  NAND2X2 U958 ( .A(n1074), .B(n1209), .Y(n1152) );
  MXI2X1 U959 ( .A(n672), .B(n673), .S0(n698), .Y(n542) );
  INVXL U960 ( .A(out_data_conv[4]), .Y(n1122) );
  INVXL U961 ( .A(out_data_conv[6]), .Y(n1126) );
  INVXL U962 ( .A(out_data_conv[7]), .Y(n1128) );
  INVXL U963 ( .A(out_data_conv[8]), .Y(n1130) );
  INVXL U964 ( .A(out_data_conv[10]), .Y(n1133) );
  NAND2BXL U965 ( .AN(n5560), .B(n623), .Y(n825) );
  NAND2XL U966 ( .A(n1030), .B(n1029), .Y(n1031) );
  INVX1 U967 ( .A(col_t[1]), .Y(n938) );
  INVXL U968 ( .A(n1140), .Y(n1141) );
  NAND3BXL U969 ( .AN(n1203), .B(n1207), .C(n1206), .Y(n797) );
  INVX1 U970 ( .A(col_t[2]), .Y(n1083) );
  NAND3BXL U971 ( .AN(n1207), .B(n1203), .C(n1204), .Y(n799) );
  INVXL U972 ( .A(col_t[0]), .Y(n910) );
  INVX1 U973 ( .A(row_t[1]), .Y(n1089) );
  CLKINVX2 U974 ( .A(row_t[0]), .Y(n1088) );
  INVXL U975 ( .A(addr_incre[0]), .Y(n1030) );
  CLKINVX1 U976 ( .A(n956), .Y(n948) );
  CLKINVX1 U977 ( .A(n865), .Y(n875) );
  CLKINVX1 U978 ( .A(n1078), .Y(n1074) );
  INVX4 U979 ( .A(n1042), .Y(n1006) );
  AND2X2 U980 ( .A(n1033), .B(n733), .Y(n674) );
  MX2XL U981 ( .A(n1007), .B(n948), .S0(n675), .Y(n918) );
  CLKINVX1 U982 ( .A(n1095), .Y(n1082) );
  INVX1 U983 ( .A(n879), .Y(n878) );
  CLKINVX1 U984 ( .A(n932), .Y(n1033) );
  CLKINVX1 U985 ( .A(n925), .Y(n926) );
  CLKINVX1 U986 ( .A(n1093), .Y(n896) );
  AND2XL U987 ( .A(n1047), .B(n1002), .Y(n1003) );
  OR2X6 U988 ( .A(n482), .B(n954), .Y(n978) );
  NAND2BX4 U989 ( .AN(n830), .B(n572), .Y(n1139) );
  XOR2XL U990 ( .A(n998), .B(n736), .Y(n986) );
  AOI2BB1XL U991 ( .A0N(n1007), .A1N(n948), .B0(n738), .Y(n949) );
  XOR2XL U992 ( .A(n954), .B(n739), .Y(n929) );
  AOI2BB1X1 U993 ( .A0N(n926), .A1N(n482), .B0(n676), .Y(n928) );
  NAND2X1 U994 ( .A(N488), .B(n1049), .Y(n927) );
  CLKINVX1 U995 ( .A(n1072), .Y(n1080) );
  CLKINVX1 U996 ( .A(n5570), .Y(n1117) );
  NAND2XL U997 ( .A(n1064), .B(n1063), .Y(n1147) );
  XOR2XL U998 ( .A(n979), .B(n736), .Y(n983) );
  AND3XL U999 ( .A(n1139), .B(n914), .C(n649), .Y(n907) );
  AO22XL U1000 ( .A0(answer[1]), .A1(n1119), .B0(N172), .B1(n566), .Y(N189) );
  INVXL U1001 ( .A(n1154), .Y(n1075) );
  CLKINVX1 U1002 ( .A(n740), .Y(n1077) );
  INVX3 U1003 ( .A(n1120), .Y(n1136) );
  XOR2XL U1004 ( .A(n978), .B(n735), .Y(n955) );
  OA21XL U1005 ( .A0(n607), .A1(n1099), .B0(n1098), .Y(n1101) );
  AO22XL U1006 ( .A0(answer[0]), .A1(n1119), .B0(N171), .B1(n566), .Y(N188) );
  AND2X2 U1007 ( .A(n1088), .B(n1089), .Y(n682) );
  AO21X4 U1008 ( .A0(n887), .A1(i_op_mode[0]), .B0(n886), .Y(n685) );
  AOI2BB1XL U1009 ( .A0N(col_t[1]), .A1N(n946), .B0(n910), .Y(n912) );
  NAND4BX2 U1010 ( .AN(n687), .B(n1155), .C(n1156), .D(n1157), .Y(N229) );
  AO22X1 U1011 ( .A0(sram_Q5[7]), .A1(n1163), .B0(sram_Q4[7]), .B1(n1164), .Y(
        n687) );
  NAND4BX2 U1012 ( .AN(n688), .B(n1165), .C(n1166), .D(n1167), .Y(N228) );
  AO22X1 U1013 ( .A0(sram_Q5[6]), .A1(n1163), .B0(sram_Q4[6]), .B1(n1164), .Y(
        n688) );
  NAND4BX2 U1014 ( .AN(n689), .B(n1168), .C(n1169), .D(n1170), .Y(N227) );
  AO22X1 U1015 ( .A0(sram_Q5[5]), .A1(n1163), .B0(sram_Q4[5]), .B1(n1164), .Y(
        n689) );
  NAND4BX2 U1016 ( .AN(n690), .B(n1171), .C(n1172), .D(n1173), .Y(N226) );
  AO22X1 U1017 ( .A0(sram_Q5[4]), .A1(n1163), .B0(sram_Q4[4]), .B1(n1164), .Y(
        n690) );
  NAND4BX2 U1018 ( .AN(n691), .B(n1174), .C(n1175), .D(n1176), .Y(N225) );
  AO22X1 U1019 ( .A0(sram_Q5[3]), .A1(n1163), .B0(sram_Q4[3]), .B1(n1164), .Y(
        n691) );
  NAND4BX2 U1020 ( .AN(n692), .B(n1177), .C(n1178), .D(n1179), .Y(N224) );
  AO22X1 U1021 ( .A0(sram_Q5[2]), .A1(n1163), .B0(sram_Q4[2]), .B1(n1164), .Y(
        n692) );
  NAND4BX2 U1022 ( .AN(n693), .B(n1180), .C(n1181), .D(n1182), .Y(N223) );
  AO22X1 U1023 ( .A0(sram_Q5[1]), .A1(n1163), .B0(sram_Q4[1]), .B1(n1164), .Y(
        n693) );
  NAND4BX2 U1024 ( .AN(n694), .B(n1183), .C(n1184), .D(n1185), .Y(N222) );
  AO22X1 U1025 ( .A0(sram_Q5[0]), .A1(n1163), .B0(sram_Q4[0]), .B1(n1164), .Y(
        n694) );
  NAND3BXL U1026 ( .AN(n788), .B(N267), .C(n1065), .Y(n1071) );
  NAND2XL U1027 ( .A(n1201), .B(n991), .Y(n942) );
  NAND4X1 U1028 ( .A(n1033), .B(n742), .C(n646), .D(n733), .Y(n1016) );
  BUFX20 U1029 ( .A(addr_SRAM[0]), .Y(n738) );
  OA22XL U1030 ( .A0(n957), .A1(n956), .B0(n1053), .B1(n955), .Y(n966) );
  NAND3BX1 U1031 ( .AN(n601), .B(n646), .C(n674), .Y(n963) );
  NOR2X1 U1032 ( .A(n822), .B(n821), .Y(n824) );
  OAI32XL U1033 ( .A0(n1205), .A1(n698), .A2(n870), .B0(n5560), .B1(n868), .Y(
        n874) );
  AOI2BB1X1 U1034 ( .A0N(n1201), .A1N(n1205), .B0(n821), .Y(n817) );
  NAND2XL U1035 ( .A(n754), .B(n755), .Y(n703) );
  OAI211XL U1036 ( .A0(n851), .A1(n865), .B0(n850), .C0(n849), .Y(n536) );
  AO21XL U1037 ( .A0(n848), .A1(n879), .B0(n1083), .Y(n849) );
  OA22XL U1038 ( .A0(n870), .A1(n846), .B0(n852), .B1(n868), .Y(n851) );
  AND2X2 U1039 ( .A(i_op_valid), .B(n905), .Y(n704) );
  OAI31XL U1040 ( .A0(n1037), .A1(addr_incre[0]), .A2(n812), .B0(n647), .Y(
        n813) );
  AND2X2 U1041 ( .A(n1021), .B(addr_incre[0]), .Y(n814) );
  CLKINVX1 U1042 ( .A(n811), .Y(n812) );
  NAND2XL U1043 ( .A(n875), .B(n862), .Y(n843) );
  NAND2XL U1044 ( .A(n847), .B(n879), .Y(n842) );
  NAND4XL U1045 ( .A(n785), .B(n600), .C(counter[7]), .D(n604), .Y(n759) );
  NAND4XL U1046 ( .A(counter[2]), .B(addr_SRAM[2]), .C(n588), .D(addr_SRAM[5]), 
        .Y(n760) );
  NAND4XL U1047 ( .A(n700), .B(addr_SRAM[7]), .C(n607), .D(addr_SRAM[0]), .Y(
        n761) );
  AND3XL U1048 ( .A(row[1]), .B(n743), .C(row[2]), .Y(n836) );
  OAI222XL U1049 ( .A0(n1193), .A1(n1143), .B0(n1186), .B1(n1144), .C0(n1141), 
        .C1(n1142), .Y(N592) );
  NAND2X1 U1050 ( .A(i_op_mode[1]), .B(n802), .Y(n796) );
  OAI221XL U1051 ( .A0(n1187), .A1(n1144), .B0(n1186), .B1(n1143), .C0(n1142), 
        .Y(N599) );
  OAI221XL U1052 ( .A0(n1188), .A1(n1144), .B0(n1187), .B1(n1143), .C0(n1142), 
        .Y(N598) );
  OAI221XL U1053 ( .A0(n1189), .A1(n1144), .B0(n1188), .B1(n1143), .C0(n1142), 
        .Y(N597) );
  OAI221XL U1054 ( .A0(n1190), .A1(n1144), .B0(n1189), .B1(n1143), .C0(n1142), 
        .Y(N596) );
  OAI221XL U1055 ( .A0(n1191), .A1(n1144), .B0(n1190), .B1(n1143), .C0(n1142), 
        .Y(N595) );
  OAI221XL U1056 ( .A0(n1192), .A1(n1144), .B0(n1191), .B1(n1143), .C0(n1142), 
        .Y(N594) );
  OAI221XL U1057 ( .A0(n1193), .A1(n1144), .B0(n1192), .B1(n1143), .C0(n1142), 
        .Y(N593) );
  INVX1 U1058 ( .A(n481), .Y(n914) );
  NAND4XL U1059 ( .A(row[1]), .B(n1087), .C(row[2]), .D(n743), .Y(n833) );
  NAND4XL U1060 ( .A(n514), .B(n670), .C(n1028), .D(n607), .Y(n1068) );
  AO22X1 U1061 ( .A0(out_data_conv[14]), .A1(n1137), .B0(N243), .B1(n1136), 
        .Y(n502) );
  AO22X1 U1062 ( .A0(out_data_conv[12]), .A1(n1137), .B0(N241), .B1(n1136), 
        .Y(n504) );
  AO22X1 U1063 ( .A0(out_data_conv[13]), .A1(n1137), .B0(N242), .B1(n1136), 
        .Y(n503) );
  NAND2X1 U1064 ( .A(i_in_valid), .B(n1187), .Y(n548) );
  NAND2X1 U1065 ( .A(i_in_valid), .B(n1188), .Y(n549) );
  NAND2X1 U1066 ( .A(i_in_valid), .B(n1189), .Y(n550) );
  NAND2X1 U1067 ( .A(i_in_valid), .B(n1190), .Y(n5510) );
  NAND2X1 U1068 ( .A(i_in_valid), .B(n1191), .Y(n5520) );
  NAND2X1 U1069 ( .A(i_in_valid), .B(n1192), .Y(n5530) );
  NAND2X1 U1070 ( .A(i_in_valid), .B(n1186), .Y(n547) );
  NAND2X1 U1071 ( .A(i_in_valid), .B(n1193), .Y(n5540) );
  OAI221XL U1072 ( .A0(n1135), .A1(n1122), .B0(n1200), .B1(n670), .C0(n1121), 
        .Y(n1211) );
  NAND2X1 U1073 ( .A(N233), .B(n1136), .Y(n1121) );
  OAI221XL U1074 ( .A0(n1135), .A1(n1124), .B0(n1199), .B1(n670), .C0(n1123), 
        .Y(n1212) );
  CLKINVX1 U1075 ( .A(out_data_conv[5]), .Y(n1124) );
  NAND2X1 U1076 ( .A(N234), .B(n1136), .Y(n1123) );
  OAI221XL U1077 ( .A0(n1135), .A1(n1126), .B0(n1198), .B1(n670), .C0(n1125), 
        .Y(n1213) );
  NAND2X1 U1078 ( .A(N235), .B(n1136), .Y(n1125) );
  OAI221XL U1079 ( .A0(n1135), .A1(n1128), .B0(n1197), .B1(n670), .C0(n1127), 
        .Y(n1214) );
  NAND2X1 U1080 ( .A(N236), .B(n1136), .Y(n1127) );
  OAI221XL U1081 ( .A0(n1135), .A1(n1130), .B0(n1196), .B1(n670), .C0(n1129), 
        .Y(n1215) );
  NAND2X1 U1082 ( .A(N237), .B(n1136), .Y(n1129) );
  NAND2X1 U1083 ( .A(N238), .B(n1136), .Y(n1131) );
  NAND2X1 U1084 ( .A(N239), .B(n1136), .Y(n1132) );
  NAND2X1 U1085 ( .A(N240), .B(n1136), .Y(n1134) );
  XOR2XL U1086 ( .A(n1209), .B(n1074), .Y(n498) );
  CLKBUFX3 U1087 ( .A(n1153), .Y(n740) );
  NOR3XL U1088 ( .A(n1150), .B(n1210), .C(n1151), .Y(n1153) );
  OAI31XL U1089 ( .A0(n1032), .A1(addr_incre[1]), .A2(n1031), .B0(n649), .Y(
        N579) );
  NAND4XL U1090 ( .A(n1028), .B(n514), .C(n1027), .D(n607), .Y(n1032) );
  CLKINVX1 U1091 ( .A(n1097), .Y(N165) );
  NAND3BXL U1092 ( .AN(n718), .B(n516), .C(counter[2]), .Y(n1097) );
  OAI31XL U1093 ( .A0(state[0]), .A1(n711), .A2(n572), .B0(n494), .Y(n499) );
  NOR2BX2 U1098 ( .AN(n1154), .B(n1209), .Y(n1164) );
  INVXL U1099 ( .A(n1109), .Y(n712) );
  INVX6 U1100 ( .A(n714), .Y(n715) );
  INVX12 U1101 ( .A(n1053), .Y(n1007) );
  AND3X2 U1102 ( .A(n1149), .B(n1150), .C(n1208), .Y(n1158) );
  NAND3BX4 U1103 ( .AN(n975), .B(n704), .C(n705), .Y(n1062) );
  INVX4 U1104 ( .A(n479), .Y(n758) );
  XOR2X2 U1105 ( .A(n883), .B(row_t[1]), .Y(n855) );
  AOI2BB1X2 U1106 ( .A0N(n1138), .A1N(n765), .B0(n572), .Y(n768) );
  OAI211X2 U1107 ( .A0(n832), .A1(n769), .B0(n768), .C0(n767), .Y(n771) );
  OAI211X2 U1108 ( .A0(n777), .A1(n776), .B0(n775), .C0(n1140), .Y(n1145) );
  OR2X4 U1109 ( .A(n779), .B(n778), .Y(n915) );
  AND3X4 U1110 ( .A(state[0]), .B(n888), .C(n644), .Y(n786) );
  AND2X4 U1111 ( .A(N270), .B(n732), .Y(N279) );
  OAI222X2 U1112 ( .A0(n799), .A1(n798), .B0(n797), .B1(n796), .C0(n615), .C1(
        n618), .Y(n800) );
  NAND2X2 U1113 ( .A(n1201), .B(n698), .Y(n822) );
  CLKMX2X3 U1114 ( .A(n818), .B(n1202), .S0(n819), .Y(n823) );
  AO21X4 U1115 ( .A0(n819), .A1(n1205), .B0(n823), .Y(n820) );
  AO22X4 U1116 ( .A0(n1201), .A1(n820), .B0(n623), .B1(n845), .Y(n540) );
  NAND4X2 U1117 ( .A(n829), .B(n828), .C(n827), .D(n1029), .Y(n831) );
  XOR2X2 U1118 ( .A(n881), .B(row_t[1]), .Y(n840) );
  AND3X4 U1119 ( .A(n609), .B(n855), .C(n854), .Y(n857) );
  OAI211X2 U1120 ( .A0(n1139), .A1(n891), .B0(n890), .C0(n889), .Y(n899) );
  NAND2X4 U1121 ( .A(n893), .B(n892), .Y(n895) );
  OAI31X2 U1122 ( .A0(n902), .A1(n903), .A2(n901), .B0(n900), .Y(n970) );
  AO21X4 U1123 ( .A0(n514), .A1(n1047), .B0(n958), .Y(n1099) );
  AOI32X2 U1124 ( .A0(n913), .A1(n912), .A2(n1056), .B0(n911), .B1(n1056), .Y(
        n920) );
  NAND4X2 U1125 ( .A(n922), .B(n921), .C(n920), .D(n919), .Y(N551) );
  NAND3BX2 U1126 ( .AN(n480), .B(n646), .C(n674), .Y(n950) );
  OAI211X2 U1127 ( .A0(n997), .A1(n996), .B0(n994), .C0(n995), .Y(N554) );
  NAND2X2 U1128 ( .A(n999), .B(n736), .Y(n1042) );
  NAND2X2 U1129 ( .A(n1073), .B(n1004), .Y(n1010) );
  AOI32X2 U1130 ( .A0(n1007), .A1(n737), .A2(n1006), .B0(n788), .B1(n1043), 
        .Y(n1008) );
  OAI211X2 U1131 ( .A0(n1011), .A1(n1010), .B0(n1008), .C0(n1009), .Y(n1012)
         );
  OAI221X2 U1132 ( .A0(n1013), .A1(n649), .B0(n1053), .B1(n589), .C0(n1023), 
        .Y(n1014) );
  AOI222X2 U1133 ( .A0(n1015), .A1(n524), .B0(n742), .B1(n1014), .C0(N493), 
        .C1(n1049), .Y(n1017) );
  AOI2BB1X2 U1134 ( .A0N(n5550), .A1N(n701), .B0(n646), .Y(n1059) );
  OAI221X2 U1135 ( .A0(n1054), .A1(n1053), .B0(n1052), .B1(n649), .C0(n1050), 
        .Y(n1055) );
  AOI221X2 U1136 ( .A0(n1059), .A1(n1058), .B0(n1057), .B1(n1056), .C0(n1055), 
        .Y(n1060) );
  OAI32X2 U1137 ( .A0(n1071), .A1(n1070), .A2(n1069), .B0(n5930), .B1(n1070), 
        .Y(N276) );
  XOR2X1 U1138 ( .A(n1151), .B(n1152), .Y(n497) );
  AOI22X1 U1139 ( .A0(sram_Q3[7]), .A1(n740), .B0(sram_Q2[7]), .B1(n1158), .Y(
        n1157) );
  AOI22X1 U1140 ( .A0(sram_Q1[7]), .A1(n1159), .B0(sram_Q0[7]), .B1(n1160), 
        .Y(n1156) );
  AOI22X1 U1141 ( .A0(sram_Q7[7]), .A1(n1161), .B0(sram_Q6[7]), .B1(n1162), 
        .Y(n1155) );
  AOI22X1 U1142 ( .A0(sram_Q3[6]), .A1(n740), .B0(sram_Q2[6]), .B1(n1158), .Y(
        n1167) );
  AOI22X1 U1143 ( .A0(sram_Q1[6]), .A1(n1159), .B0(sram_Q0[6]), .B1(n1160), 
        .Y(n1166) );
  AOI22X1 U1144 ( .A0(sram_Q7[6]), .A1(n1161), .B0(sram_Q6[6]), .B1(n1162), 
        .Y(n1165) );
  AOI22X1 U1145 ( .A0(sram_Q3[5]), .A1(n740), .B0(sram_Q2[5]), .B1(n1158), .Y(
        n1170) );
  AOI22X1 U1146 ( .A0(sram_Q3[4]), .A1(n740), .B0(sram_Q2[4]), .B1(n1158), .Y(
        n1173) );
  AOI22X1 U1147 ( .A0(sram_Q3[3]), .A1(n740), .B0(sram_Q2[3]), .B1(n1158), .Y(
        n1176) );
  AOI22X1 U1148 ( .A0(sram_Q3[2]), .A1(n740), .B0(sram_Q2[2]), .B1(n1158), .Y(
        n1179) );
  AOI22X1 U1149 ( .A0(sram_Q3[1]), .A1(n740), .B0(sram_Q2[1]), .B1(n1158), .Y(
        n1182) );
  AOI22X1 U1150 ( .A0(sram_Q3[0]), .A1(n740), .B0(sram_Q2[0]), .B1(n1158), .Y(
        n1185) );
endmodule


module core_DW01_add_13 ( A, SUM, \B[12] , \B[11] , \B[10] , \B[9] , \B[8] , 
        \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0]  );
  input [16:0] A;
  output [16:0] SUM;
  input \B[12] , \B[11] , \B[10] , \B[9] , \B[8] , \B[7] , \B[6] , \B[5] ,
         \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  wire   n1, n3, n4, n7, n8, n10, n11, n12, n13, n14, n21, n23, n25, n26, n27,
         n30, n31, n32, n34, n35, n38, n40, n42, n43, n47, n49, n51, n52, n53,
         n57, n58, n61, n62, n63, n65, n67, n69, n70, n72, n73, n74, n77, n79,
         n80, n85, n86, n87, n89, n90, n91, n92, n93, n94, n95, n96, n97, n99,
         n100, n101, n103, n104, n106, n108, n109, n114, n115, n117, n119,
         n120, n121, n122, n127, n131, n194, n195, n196, n197, n198, n199,
         n200, n201, n202, n203, n204, n205, n206, n207, n208, n209, n210,
         n211, n212, n213, n214, n215, n216, n217, n218, n219, n220, n221,
         n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232,
         n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245, n246, n247, n248, n249, n250;
  wire   [12:0] B;
  assign B[12] = \B[12] ;
  assign B[11] = \B[11] ;
  assign B[10] = \B[10] ;
  assign B[9] = \B[9] ;
  assign B[8] = \B[8] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;

  OAI21X4 U51 ( .A0(n57), .A1(n63), .B0(n58), .Y(n52) );
  AOI21X4 U106 ( .A0(n238), .A1(n94), .B0(n95), .Y(n93) );
  NAND2X8 U156 ( .A(n231), .B(A[13]), .Y(n233) );
  NAND2X4 U157 ( .A(B[1]), .B(A[1]), .Y(n119) );
  CLKINVX3 U158 ( .A(n238), .Y(n101) );
  AND2X6 U159 ( .A(n1), .B(n34), .Y(n226) );
  AND2X6 U160 ( .A(n1), .B(n25), .Y(n221) );
  OR2XL U161 ( .A(B[9]), .B(A[9]), .Y(n225) );
  INVX20 U162 ( .A(A[14]), .Y(n194) );
  INVXL U163 ( .A(A[14]), .Y(n32) );
  XOR2X4 U164 ( .A(n218), .B(n194), .Y(SUM[14]) );
  INVX8 U165 ( .A(n52), .Y(n247) );
  NOR2X8 U166 ( .A(n222), .B(A[6]), .Y(n90) );
  NAND2X8 U167 ( .A(n223), .B(A[10]), .Y(n63) );
  XNOR2X2 U168 ( .A(n12), .B(n114), .Y(SUM[2]) );
  XNOR2X1 U169 ( .A(n92), .B(n8), .Y(SUM[6]) );
  NAND2X2 U170 ( .A(n205), .B(n250), .Y(n8) );
  NAND2BX1 U171 ( .AN(n85), .B(n86), .Y(n7) );
  AOI21X4 U172 ( .A0(n92), .A1(n205), .B0(n89), .Y(n87) );
  INVX4 U173 ( .A(n93), .Y(n92) );
  INVX4 U174 ( .A(n245), .Y(n227) );
  CLKINVX8 U175 ( .A(n74), .Y(n127) );
  NOR2X8 U176 ( .A(B[8]), .B(A[8]), .Y(n74) );
  OAI21X4 U177 ( .A0(n85), .A1(n91), .B0(n86), .Y(n80) );
  NAND2X8 U178 ( .A(n222), .B(A[6]), .Y(n91) );
  BUFX8 U179 ( .A(B[2]), .Y(n224) );
  NAND2X1 U180 ( .A(n131), .B(n100), .Y(n10) );
  NOR2X6 U181 ( .A(n228), .B(n117), .Y(n115) );
  XOR2X4 U182 ( .A(n87), .B(n7), .Y(SUM[7]) );
  NAND2X6 U183 ( .A(n67), .B(n79), .Y(n65) );
  NOR2X8 U184 ( .A(n69), .B(n74), .Y(n67) );
  NOR2X8 U185 ( .A(B[9]), .B(A[9]), .Y(n69) );
  NAND2X8 U186 ( .A(n236), .B(n38), .Y(n232) );
  NAND2X8 U187 ( .A(n201), .B(n202), .Y(n236) );
  NOR2X6 U188 ( .A(B[11]), .B(A[11]), .Y(n57) );
  NAND2X2 U189 ( .A(A[11]), .B(B[11]), .Y(n58) );
  BUFX8 U190 ( .A(B[5]), .Y(n249) );
  NAND2X2 U191 ( .A(n220), .B(n63), .Y(n4) );
  INVX12 U192 ( .A(n247), .Y(n248) );
  INVX12 U193 ( .A(n234), .Y(n1) );
  NOR2X4 U194 ( .A(n96), .B(n99), .Y(n94) );
  NAND2X6 U195 ( .A(n229), .B(n30), .Y(n26) );
  OR2X6 U196 ( .A(n30), .B(n23), .Y(n242) );
  NAND2X6 U197 ( .A(n47), .B(n31), .Y(n30) );
  XOR2X4 U198 ( .A(n239), .B(n240), .Y(SUM[12]) );
  AO21X4 U199 ( .A0(n1), .A1(n51), .B0(n248), .Y(n239) );
  OAI21X4 U200 ( .A0(n96), .A1(n100), .B0(n97), .Y(n95) );
  NOR2X8 U201 ( .A(n249), .B(A[5]), .Y(n96) );
  OR2X6 U202 ( .A(n222), .B(A[6]), .Y(n205) );
  XOR2X4 U203 ( .A(n216), .B(n217), .Y(SUM[8]) );
  OAI21X4 U204 ( .A0(n101), .A1(n215), .B0(n100), .Y(n210) );
  NAND2X4 U205 ( .A(B[8]), .B(A[8]), .Y(n77) );
  NOR2X4 U206 ( .A(A[4]), .B(B[4]), .Y(n99) );
  NAND2X6 U207 ( .A(B[4]), .B(A[4]), .Y(n100) );
  AND2X2 U208 ( .A(n127), .B(n77), .Y(n217) );
  CLKINVX1 U209 ( .A(n119), .Y(n117) );
  NOR2X2 U210 ( .A(n227), .B(n122), .Y(n228) );
  INVX3 U211 ( .A(n115), .Y(n114) );
  CLKINVX1 U212 ( .A(n127), .Y(n196) );
  AND2X2 U213 ( .A(n51), .B(n21), .Y(n219) );
  CLKINVX1 U214 ( .A(n246), .Y(n197) );
  INVX1 U215 ( .A(n51), .Y(n53) );
  NOR2X2 U216 ( .A(n42), .B(n38), .Y(n34) );
  OR2X6 U217 ( .A(B[1]), .B(A[1]), .Y(n245) );
  XOR2X1 U218 ( .A(n210), .B(n211), .Y(SUM[5]) );
  CLKINVX1 U219 ( .A(n14), .Y(SUM[0]) );
  NAND2BX1 U220 ( .AN(n121), .B(n122), .Y(n14) );
  NAND2X4 U221 ( .A(n1), .B(n219), .Y(n198) );
  NOR2X6 U222 ( .A(n226), .B(n35), .Y(n218) );
  CLKINVX1 U223 ( .A(n122), .Y(n120) );
  NAND2X2 U224 ( .A(B[0]), .B(A[0]), .Y(n122) );
  CLKINVX1 U225 ( .A(A[13]), .Y(n38) );
  NOR2X1 U226 ( .A(n38), .B(n32), .Y(n31) );
  BUFX4 U227 ( .A(n244), .Y(n195) );
  INVX3 U228 ( .A(n99), .Y(n131) );
  NAND2X6 U229 ( .A(n243), .B(n244), .Y(n103) );
  OR2X2 U230 ( .A(n223), .B(A[10]), .Y(n220) );
  NOR2BX2 U231 ( .AN(n79), .B(n196), .Y(n72) );
  NOR2X6 U232 ( .A(n221), .B(n26), .Y(n212) );
  CLKINVX8 U233 ( .A(n203), .Y(n208) );
  XNOR2X4 U234 ( .A(n1), .B(n4), .Y(SUM[10]) );
  NAND2X4 U235 ( .A(n1), .B(n40), .Y(n201) );
  NAND2X4 U236 ( .A(n246), .B(n31), .Y(n27) );
  NAND2X4 U237 ( .A(B[12]), .B(A[12]), .Y(n49) );
  AO21X4 U238 ( .A0(n1), .A1(n220), .B0(n61), .Y(n237) );
  OA21X4 U239 ( .A0(n247), .A1(n197), .B0(n49), .Y(n202) );
  NOR2BX4 U240 ( .AN(n198), .B(n241), .Y(n214) );
  NOR2X6 U241 ( .A(n43), .B(n38), .Y(n35) );
  OR2X1 U242 ( .A(n249), .B(A[5]), .Y(n206) );
  NAND2X4 U243 ( .A(B[7]), .B(A[7]), .Y(n86) );
  XOR2X4 U244 ( .A(n199), .B(n200), .Y(SUM[9]) );
  AOI21X4 U245 ( .A0(n72), .A1(n92), .B0(n73), .Y(n199) );
  NAND2X2 U246 ( .A(n225), .B(n70), .Y(n200) );
  AND2X1 U247 ( .A(n206), .B(n97), .Y(n211) );
  CLKINVX2 U248 ( .A(n42), .Y(n40) );
  OA21X4 U249 ( .A0(n85), .A1(n91), .B0(n86), .Y(n203) );
  NOR2X8 U250 ( .A(B[7]), .B(A[7]), .Y(n85) );
  AO21X4 U251 ( .A0(n79), .A1(n92), .B0(n208), .Y(n216) );
  NOR2X8 U252 ( .A(n90), .B(n85), .Y(n79) );
  INVX8 U253 ( .A(A[16]), .Y(n213) );
  NOR2X2 U254 ( .A(n53), .B(n27), .Y(n25) );
  OAI2BB1X4 U255 ( .A0N(n208), .A1N(n127), .B0(n77), .Y(n73) );
  CLKINVX8 U256 ( .A(n236), .Y(n231) );
  CLKAND2X12 U257 ( .A(n224), .B(A[2]), .Y(n204) );
  OR2X6 U258 ( .A(B[12]), .B(A[12]), .Y(n246) );
  NAND2XL U259 ( .A(n224), .B(A[2]), .Y(n207) );
  OR2XL U260 ( .A(B[11]), .B(A[11]), .Y(n209) );
  XOR2X4 U261 ( .A(n212), .B(n23), .Y(SUM[15]) );
  XOR2X4 U262 ( .A(n214), .B(n213), .Y(SUM[16]) );
  INVX1 U263 ( .A(n131), .Y(n215) );
  NAND2X4 U264 ( .A(B[9]), .B(A[9]), .Y(n70) );
  XNOR2X4 U265 ( .A(n237), .B(n3), .Y(SUM[11]) );
  OAI2BB1X2 U266 ( .A0N(n248), .A1N(n21), .B0(n242), .Y(n241) );
  BUFX8 U267 ( .A(B[6]), .Y(n222) );
  OR2X8 U268 ( .A(B[3]), .B(A[3]), .Y(n243) );
  NAND2XL U269 ( .A(n195), .B(n207), .Y(n12) );
  NAND2X4 U270 ( .A(B[3]), .B(A[3]), .Y(n108) );
  BUFX8 U271 ( .A(B[10]), .Y(n223) );
  NOR2X6 U272 ( .A(n223), .B(A[10]), .Y(n62) );
  AOI21X1 U273 ( .A0(n114), .A1(n195), .B0(n204), .Y(n109) );
  AOI2BB1X4 U274 ( .A0N(n93), .A1N(n65), .B0(n235), .Y(n234) );
  OAI2BB1X4 U275 ( .A0N(n80), .A1N(n67), .B0(n230), .Y(n235) );
  NAND2X4 U276 ( .A(n51), .B(n246), .Y(n42) );
  NOR2X8 U277 ( .A(n62), .B(n57), .Y(n51) );
  NAND2X4 U278 ( .A(A[5]), .B(n249), .Y(n97) );
  AOI21X4 U279 ( .A0(n248), .A1(n246), .B0(n47), .Y(n43) );
  OR2X4 U280 ( .A(n247), .B(n27), .Y(n229) );
  OA21X4 U281 ( .A0(n69), .A1(n77), .B0(n70), .Y(n230) );
  NAND2X6 U282 ( .A(n232), .B(n233), .Y(SUM[13]) );
  OR2X6 U283 ( .A(n224), .B(A[2]), .Y(n244) );
  INVX4 U284 ( .A(n108), .Y(n106) );
  NOR2X4 U285 ( .A(n27), .B(n23), .Y(n21) );
  INVX3 U286 ( .A(n250), .Y(n89) );
  AOI21X4 U287 ( .A0(n243), .A1(n204), .B0(n106), .Y(n104) );
  OAI21X4 U288 ( .A0(n103), .A1(n115), .B0(n104), .Y(n238) );
  AND2X2 U289 ( .A(n246), .B(n49), .Y(n240) );
  NAND2X1 U290 ( .A(n209), .B(n58), .Y(n3) );
  CLKBUFX3 U291 ( .A(n91), .Y(n250) );
  XOR2X1 U292 ( .A(n101), .B(n10), .Y(SUM[4]) );
  CLKINVX1 U293 ( .A(n49), .Y(n47) );
  XOR2X1 U294 ( .A(n109), .B(n11), .Y(SUM[3]) );
  INVXL U295 ( .A(n63), .Y(n61) );
  XNOR2XL U296 ( .A(n13), .B(n120), .Y(SUM[1]) );
  NAND2X1 U297 ( .A(n245), .B(n119), .Y(n13) );
  NOR2XL U298 ( .A(B[0]), .B(A[0]), .Y(n121) );
  CLKINVX1 U299 ( .A(A[15]), .Y(n23) );
  NAND2XL U300 ( .A(n243), .B(n108), .Y(n11) );
endmodule


module core_DW01_add_10 ( SUM, \A[9] , \A[8] , \A[7] , \A[6] , \A[5] , \A[4] , 
        \A[3] , \A[2] , \A[1] , \A[0] , \B[9] , \B[8] , \B[7] , \B[6] , \B[5] , 
        \B[4] , \B[3] , \B[2] , \B[1] , \B[0]  );
  output [10:0] SUM;
  input \A[9] , \A[8] , \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] ,
         \A[0] , \B[9] , \B[8] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] ,
         \B[2] , \B[1] , \B[0] ;
  wire   n1, n3, n8, n9, n15, n17, n19, n20, n22, n24, n25, n26, n27, n28, n29,
         n30, n31, n33, n34, n35, n38, n39, n40, n41, n46, n47, n51, n52, n53,
         n54, n55, n57, n58, n59, n60, n61, n63, n64, n65, n67, n71, n74, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n151, n152,
         n154, n155, n156, n157, n158;
  wire   [9:0] B;
  wire   [9:0] A;
  assign B[9] = \B[9] ;
  assign B[8] = \B[8] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;
  assign A[9] = \A[9] ;
  assign A[8] = \A[8] ;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;

  AOI21X4 U15 ( .A0(n25), .A1(n156), .B0(n22), .Y(n20) );
  AOI21X4 U43 ( .A0(n53), .A1(n124), .B0(n41), .Y(n39) );
  OAI21X4 U49 ( .A0(n46), .A1(n52), .B0(n47), .Y(n41) );
  OAI21X4 U72 ( .A0(n121), .A1(n132), .B0(n123), .Y(n59) );
  NOR2X8 U75 ( .A(A[2]), .B(B[2]), .Y(n60) );
  OAI21X4 U79 ( .A0(n126), .A1(n122), .B0(n65), .Y(n63) );
  NAND2X8 U92 ( .A(n136), .B(n27), .Y(n25) );
  INVX4 U93 ( .A(n53), .Y(n157) );
  NAND2X6 U94 ( .A(n63), .B(n55), .Y(n137) );
  NOR2X6 U95 ( .A(A[3]), .B(B[3]), .Y(n125) );
  NAND2X4 U96 ( .A(B[3]), .B(A[3]), .Y(n58) );
  NOR2X4 U97 ( .A(A[3]), .B(B[3]), .Y(n57) );
  INVX4 U98 ( .A(n132), .Y(n144) );
  NAND2X6 U99 ( .A(n140), .B(n31), .Y(n29) );
  OAI2BB1X4 U100 ( .A0N(n25), .A1N(n118), .B0(n15), .Y(SUM[10]) );
  NOR2X8 U101 ( .A(n149), .B(n34), .Y(n127) );
  NOR2X4 U102 ( .A(A[7]), .B(B[7]), .Y(n30) );
  NOR2X8 U103 ( .A(A[7]), .B(B[7]), .Y(n130) );
  OR2X2 U104 ( .A(A[0]), .B(B[0]), .Y(n154) );
  NAND2X6 U105 ( .A(n139), .B(n52), .Y(n133) );
  OR2X6 U106 ( .A(n157), .B(n120), .Y(n135) );
  INVX4 U107 ( .A(n24), .Y(n22) );
  NAND2X4 U108 ( .A(A[9]), .B(B[9]), .Y(n19) );
  NAND2X4 U109 ( .A(A[0]), .B(B[0]), .Y(n122) );
  OR2X4 U110 ( .A(n130), .B(n38), .Y(n140) );
  NOR2X6 U111 ( .A(n51), .B(n46), .Y(n40) );
  INVX12 U112 ( .A(n54), .Y(n53) );
  NOR2X6 U113 ( .A(n51), .B(n46), .Y(n124) );
  NAND2X1 U114 ( .A(n155), .B(n19), .Y(n1) );
  OR2X4 U115 ( .A(n138), .B(n35), .Y(n143) );
  NAND2X2 U116 ( .A(A[8]), .B(B[8]), .Y(n24) );
  OR2X2 U117 ( .A(A[8]), .B(B[8]), .Y(n156) );
  NAND2X2 U118 ( .A(n74), .B(n58), .Y(n151) );
  INVX3 U119 ( .A(n158), .Y(n74) );
  NAND2X6 U120 ( .A(n147), .B(n146), .Y(SUM[2]) );
  OR2X8 U121 ( .A(n54), .B(n26), .Y(n136) );
  NAND2X8 U122 ( .A(A[0]), .B(B[0]), .Y(n67) );
  AND2X2 U123 ( .A(n156), .B(n155), .Y(n118) );
  NAND2BX1 U124 ( .AN(n130), .B(n31), .Y(n3) );
  OA21X4 U125 ( .A0(n125), .A1(n61), .B0(n58), .Y(n119) );
  NOR2X4 U126 ( .A(n35), .B(n30), .Y(n28) );
  AND2X2 U127 ( .A(n142), .B(n52), .Y(n120) );
  NOR2X1 U128 ( .A(B[2]), .B(A[2]), .Y(n121) );
  CLKINVX1 U129 ( .A(n35), .Y(n71) );
  NOR2X4 U130 ( .A(n60), .B(n57), .Y(n55) );
  CLKBUFX2 U131 ( .A(n61), .Y(n123) );
  NAND2X6 U132 ( .A(A[4]), .B(B[4]), .Y(n52) );
  CLKINVX12 U133 ( .A(n142), .Y(n51) );
  NAND2X6 U134 ( .A(n134), .B(n135), .Y(SUM[4]) );
  NOR2X4 U135 ( .A(A[1]), .B(B[1]), .Y(n64) );
  INVX2 U136 ( .A(n51), .Y(n141) );
  NOR2X8 U137 ( .A(A[1]), .B(B[1]), .Y(n126) );
  NAND2X8 U138 ( .A(n53), .B(n141), .Y(n139) );
  NAND2BX2 U139 ( .AN(n126), .B(n65), .Y(n9) );
  CLKINVX3 U140 ( .A(n145), .Y(n148) );
  CLKBUFX3 U141 ( .A(n125), .Y(n158) );
  XOR2X4 U142 ( .A(n127), .B(n3), .Y(SUM[7]) );
  XOR2X4 U143 ( .A(n39), .B(n128), .Y(SUM[6]) );
  NAND2X2 U144 ( .A(n71), .B(n38), .Y(n128) );
  XOR2X4 U145 ( .A(n133), .B(n129), .Y(SUM[5]) );
  CLKAND2X8 U146 ( .A(n131), .B(n47), .Y(n129) );
  NAND2X6 U147 ( .A(n40), .B(n28), .Y(n26) );
  NAND2X6 U148 ( .A(n144), .B(n148), .Y(n147) );
  NAND2X2 U149 ( .A(n143), .B(n38), .Y(n34) );
  INVX1 U150 ( .A(n46), .Y(n131) );
  NOR2X8 U151 ( .A(A[5]), .B(B[5]), .Y(n46) );
  OA21X4 U152 ( .A0(n64), .A1(n67), .B0(n65), .Y(n132) );
  NAND2X8 U153 ( .A(A[1]), .B(B[1]), .Y(n65) );
  AND2X4 U154 ( .A(n154), .B(n67), .Y(SUM[0]) );
  NAND2X2 U155 ( .A(n157), .B(n120), .Y(n134) );
  NOR2X8 U156 ( .A(B[6]), .B(A[6]), .Y(n35) );
  NAND2X2 U157 ( .A(A[7]), .B(B[7]), .Y(n31) );
  XOR2X4 U158 ( .A(n25), .B(n152), .Y(SUM[8]) );
  NAND2X6 U159 ( .A(B[6]), .B(A[6]), .Y(n38) );
  OR2X8 U160 ( .A(A[4]), .B(B[4]), .Y(n142) );
  NAND2X2 U161 ( .A(n132), .B(n145), .Y(n146) );
  NAND2X8 U162 ( .A(A[2]), .B(B[2]), .Y(n61) );
  NOR2BX4 U163 ( .AN(n124), .B(n35), .Y(n33) );
  AOI21X4 U164 ( .A0(n41), .A1(n28), .B0(n29), .Y(n27) );
  AND2X8 U165 ( .A(n137), .B(n119), .Y(n54) );
  OA21X4 U166 ( .A0(n46), .A1(n52), .B0(n47), .Y(n138) );
  CLKAND2X8 U167 ( .A(n53), .B(n33), .Y(n149) );
  INVX4 U168 ( .A(n8), .Y(n145) );
  NAND2BX4 U169 ( .AN(n60), .B(n61), .Y(n8) );
  CLKAND2X12 U170 ( .A(n156), .B(n24), .Y(n152) );
  XNOR2X4 U171 ( .A(n59), .B(n151), .Y(SUM[3]) );
  AOI21X1 U172 ( .A0(n155), .A1(n22), .B0(n17), .Y(n15) );
  CLKINVX1 U173 ( .A(n19), .Y(n17) );
  OR2X8 U174 ( .A(A[9]), .B(B[9]), .Y(n155) );
  XOR2X4 U175 ( .A(n9), .B(n67), .Y(SUM[1]) );
  NAND2X4 U176 ( .A(B[5]), .B(A[5]), .Y(n47) );
  XOR2X4 U177 ( .A(n20), .B(n1), .Y(SUM[9]) );
endmodule


module core_DW01_add_7 ( SUM, \A[8] , \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , 
        \A[2] , \A[1] , \A[0] , \B[8] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , 
        \B[2] , \B[1] , \B[0]  );
  output [9:0] SUM;
  input \A[8] , \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] ,
         \B[8] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] ,
         \B[0] ;
  wire   carry_8_, carry_7_, carry_6_, carry_5_, carry_4_, carry_3_, carry_2_,
         n1, n2, n3, n4;
  wire   [8:0] A;
  wire   [8:0] B;
  assign A[8] = \A[8] ;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[8] = \B[8] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;

  ADDFHX2 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry_3_), .CO(carry_4_), .S(SUM[3])
         );
  ADDFHX2 U1_8 ( .A(A[8]), .B(B[8]), .CI(carry_8_), .CO(SUM[9]), .S(SUM[8]) );
  ADDFHX4 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry_2_), .CO(carry_3_), .S(SUM[2])
         );
  ADDFHX4 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry_4_), .CO(carry_5_), .S(SUM[4])
         );
  ADDFHX4 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry_5_), .CO(carry_6_), .S(SUM[5])
         );
  ADDFHX4 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry_6_), .CO(carry_7_), .S(SUM[6])
         );
  ADDFHX4 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry_7_), .CO(carry_8_), .S(SUM[7])
         );
  NAND2X4 U1 ( .A(A[1]), .B(n1), .Y(n3) );
  AND2X4 U2 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR3XL U3 ( .A(n1), .B(A[1]), .C(B[1]), .Y(SUM[1]) );
  NAND2X6 U4 ( .A(B[1]), .B(n1), .Y(n2) );
  NAND2X6 U5 ( .A(A[1]), .B(B[1]), .Y(n4) );
  NAND3X8 U6 ( .A(n2), .B(n3), .C(n4), .Y(carry_2_) );
  XOR2XL U7 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_add_8 ( \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , 
        \A[1] , \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , 
        \B[0] , \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , 
        \SUM[2] , \SUM[1] , \SUM[0]  );
  input \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] ,
         \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  output \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] ;
  wire   n1, n2, n3, n4, n5;
  wire   [7:0] A;
  wire   [7:0] B;
  wire   [8:0] SUM;
  wire   [7:2] carry;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;
  assign \SUM[8]  = SUM[8];
  assign \SUM[7]  = SUM[7];
  assign \SUM[6]  = SUM[6];
  assign \SUM[5]  = SUM[5];
  assign \SUM[4]  = SUM[4];
  assign \SUM[3]  = SUM[3];
  assign \SUM[2]  = SUM[2];
  assign \SUM[1]  = SUM[1];
  assign \SUM[0]  = SUM[0];

  ADDFHX4 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFHX4 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFHX4 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFHX4 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFHX4 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFHX4 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  XOR2X1 U1 ( .A(B[5]), .B(A[5]), .Y(n2) );
  XOR2X2 U2 ( .A(carry[5]), .B(n2), .Y(SUM[5]) );
  AND2X4 U3 ( .A(B[0]), .B(A[0]), .Y(n1) );
  NAND2X4 U4 ( .A(B[5]), .B(carry[5]), .Y(n3) );
  NAND2X4 U5 ( .A(A[5]), .B(carry[5]), .Y(n4) );
  NAND2X4 U6 ( .A(A[5]), .B(B[5]), .Y(n5) );
  NAND3X8 U7 ( .A(n3), .B(n4), .C(n5), .Y(carry[6]) );
  XOR2X1 U8 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_add_9 ( \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , 
        \A[1] , \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , 
        \B[0] , \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , 
        \SUM[2] , \SUM[1] , \SUM[0]  );
  input \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] ,
         \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  output \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] ;
  wire   n1, n2;
  wire   [7:0] A;
  wire   [7:0] B;
  wire   [8:0] SUM;
  wire   [7:2] carry;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;
  assign \SUM[8]  = SUM[8];
  assign \SUM[7]  = SUM[7];
  assign \SUM[6]  = SUM[6];
  assign \SUM[5]  = SUM[5];
  assign \SUM[4]  = SUM[4];
  assign \SUM[3]  = SUM[3];
  assign \SUM[2]  = SUM[2];
  assign \SUM[1]  = SUM[1];
  assign \SUM[0]  = SUM[0];

  ADDFHX4 U1_1 ( .A(A[1]), .B(B[1]), .CI(n2), .CO(carry[2]), .S(SUM[1]) );
  ADDFHX4 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFHX4 U1_2 ( .A(A[2]), .B(n1), .CI(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDFHX4 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFHX2 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFHX4 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFHX2 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  BUFX8 U1 ( .A(B[2]), .Y(n1) );
  AND2X4 U2 ( .A(B[0]), .B(A[0]), .Y(n2) );
  XOR2X1 U3 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_add_4 ( SUM, \A[8] , \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , 
        \A[2] , \A[1] , \A[0] , \B[8] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , 
        \B[2] , \B[1] , \B[0]  );
  output [9:0] SUM;
  input \A[8] , \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] ,
         \B[8] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] ,
         \B[0] ;
  wire   carry_8_, carry_7_, carry_6_, carry_5_, carry_4_, carry_3_, carry_2_,
         n1;
  wire   [8:0] A;
  wire   [8:0] B;
  assign A[8] = \A[8] ;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[8] = \B[8] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;

  ADDFHX4 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry_5_), .CO(carry_6_), .S(SUM[5])
         );
  ADDFHX4 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry_2_), .CO(carry_3_), .S(SUM[2])
         );
  ADDFHX4 U1_7 ( .A(B[7]), .B(A[7]), .CI(carry_7_), .CO(carry_8_), .S(SUM[7])
         );
  ADDFHX4 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry_6_), .CO(carry_7_), .S(SUM[6])
         );
  ADDFHX4 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry_3_), .CO(carry_4_), .S(SUM[3])
         );
  ADDFHX4 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry_4_), .CO(carry_5_), .S(SUM[4])
         );
  ADDFHX4 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry_2_), .S(SUM[1]) );
  ADDFHX4 U1_8 ( .A(A[8]), .B(B[8]), .CI(carry_8_), .CO(SUM[9]), .S(SUM[8]) );
  AND2X2 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2XL U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_add_5 ( \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , 
        \A[1] , \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , 
        \B[0] , \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , 
        \SUM[2] , \SUM[1] , \SUM[0]  );
  input \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] ,
         \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  output \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] ;
  wire   n1;
  wire   [7:0] A;
  wire   [7:0] B;
  wire   [8:0] SUM;
  wire   [7:2] carry;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;
  assign \SUM[8]  = SUM[8];
  assign \SUM[7]  = SUM[7];
  assign \SUM[6]  = SUM[6];
  assign \SUM[5]  = SUM[5];
  assign \SUM[4]  = SUM[4];
  assign \SUM[3]  = SUM[3];
  assign \SUM[2]  = SUM[2];
  assign \SUM[1]  = SUM[1];
  assign \SUM[0]  = SUM[0];

  ADDFHX2 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFHX4 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFHX4 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFHX4 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  ADDFHX4 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFHX4 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFHX2 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  AND2X4 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_add_6 ( \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , 
        \A[1] , \A[0] , \B[7] , \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , 
        \B[0] , \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , 
        \SUM[2] , \SUM[1] , \SUM[0]  );
  input \A[7] , \A[6] , \A[5] , \A[4] , \A[3] , \A[2] , \A[1] , \A[0] , \B[7] ,
         \B[6] , \B[5] , \B[4] , \B[3] , \B[2] , \B[1] , \B[0] ;
  output \SUM[8] , \SUM[7] , \SUM[6] , \SUM[5] , \SUM[4] , \SUM[3] , \SUM[2] ,
         \SUM[1] , \SUM[0] ;
  wire   n1;
  wire   [7:0] A;
  wire   [7:0] B;
  wire   [8:0] SUM;
  wire   [7:2] carry;
  assign A[7] = \A[7] ;
  assign A[6] = \A[6] ;
  assign A[5] = \A[5] ;
  assign A[4] = \A[4] ;
  assign A[3] = \A[3] ;
  assign A[2] = \A[2] ;
  assign A[1] = \A[1] ;
  assign A[0] = \A[0] ;
  assign B[7] = \B[7] ;
  assign B[6] = \B[6] ;
  assign B[5] = \B[5] ;
  assign B[4] = \B[4] ;
  assign B[3] = \B[3] ;
  assign B[2] = \B[2] ;
  assign B[1] = \B[1] ;
  assign B[0] = \B[0] ;
  assign \SUM[8]  = SUM[8];
  assign \SUM[7]  = SUM[7];
  assign \SUM[6]  = SUM[6];
  assign \SUM[5]  = SUM[5];
  assign \SUM[4]  = SUM[4];
  assign \SUM[3]  = SUM[3];
  assign \SUM[2]  = SUM[2];
  assign \SUM[1]  = SUM[1];
  assign \SUM[0]  = SUM[0];

  ADDFHX2 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6])
         );
  ADDFHX4 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  ADDFHX4 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4])
         );
  ADDFHX4 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5])
         );
  ADDFHX4 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2])
         );
  ADDFHX4 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3])
         );
  ADDFHX4 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(SUM[8]), .S(SUM[7]) );
  CLKAND2X3 U1 ( .A(B[0]), .B(A[0]), .Y(n1) );
  XOR2X1 U2 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_inc_2_DW01_inc_9 ( A, SUM );
  input [7:0] A;
  output [7:0] SUM;

  wire   [7:2] carry;

  ADDHXL U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX2 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX2 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX1 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX2 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  XOR2X4 U1 ( .A(carry[7]), .B(A[7]), .Y(SUM[7]) );
  CLKINVX1 U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_inc_1_DW01_inc_8 ( A, SUM );
  input [12:0] A;
  output [12:0] SUM;
  wire   n1;
  wire   [12:2] carry;

  ADDHX4 U1_1_11 ( .A(A[11]), .B(carry[11]), .CO(carry[12]), .S(SUM[11]) );
  ADDHX4 U1_1_10 ( .A(A[10]), .B(carry[10]), .CO(carry[11]), .S(SUM[10]) );
  CMPR22X2 U1_1_9 ( .A(A[9]), .B(carry[9]), .CO(carry[10]), .S(SUM[9]) );
  CMPR22X2 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  ADDHX2 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  CMPR22X4 U1_1_5 ( .A(A[5]), .B(n1), .CO(carry[6]), .S(SUM[5]) );
  ADDHX2 U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX4 U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHX4 U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHX4 U1_1_8 ( .A(A[8]), .B(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  AND2X8 U1 ( .A(A[4]), .B(carry[4]), .Y(n1) );
  XOR2X2 U2 ( .A(carry[12]), .B(A[12]), .Y(SUM[12]) );
  XOR2XL U3 ( .A(A[4]), .B(carry[4]), .Y(SUM[4]) );
  CLKINVX1 U4 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module core_DW01_inc_0_DW01_inc_7 ( A, SUM );
  input [8:0] A;
  output [8:0] SUM;

  wire   [8:2] carry;

  ADDHXL U1_1_2 ( .A(A[2]), .B(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  ADDHXL U1_1_1 ( .A(A[1]), .B(A[0]), .CO(carry[2]), .S(SUM[1]) );
  ADDHX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  ADDHX2 U1_1_7 ( .A(A[7]), .B(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  ADDHX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  ADDHX2 U1_1_5 ( .A(A[5]), .B(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  ADDHX2 U1_1_3 ( .A(A[3]), .B(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  XOR2X1 U1 ( .A(carry[8]), .B(A[8]), .Y(SUM[8]) );
  INVXL U2 ( .A(A[0]), .Y(SUM[0]) );
endmodule

