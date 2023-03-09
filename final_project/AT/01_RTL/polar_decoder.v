module polar_decoder (
    clk,
    rst_n,
    module_en,
    proc_done,
    raddr,
    rdata,
    waddr,
    wdata
);
    // IO description
    input  wire         clk;
    input  wire         rst_n;
    input  wire         module_en;
    input  wire [191:0] rdata;
    output reg  [ 10:0] raddr;
    output reg  [  5:0] waddr;
    output reg  [139:0] wdata;
    output reg          proc_done;
    
    parameter RST     = 2'b00,
              READ    = 2'b01,
              EX_READ = 2'b10,
              DONE    = 2'b11;
    
    reg [1:0] state;
    reg [1:0] n_state;
    reg [5:0] counter;
    reg [5:0] EX_counter;
    
    reg [5:0] NUM_PACKET;
    reg [5:0] num_of_packet;
    reg [7:0] K;
    reg [2:0] N;//128->001, 256->010, 512->100
    reg [191:0] LLR0 [0:31];
    reg [8:0] num_of_u_done;
    wire [7:0] select = num_of_u_done;
    wire [2:0] select_initial;
    wire [2:0] select_index;
    wire select_i;
    wire signed [11:0] PE0_o, PE1_o, PE2_o, PE3_o, PE4_o, PE5_o, PE6_o, PE7_o, PE8_o, PE9_o, PE10_o, PE11_o, PE12_o, PE13_o, PE14_o, PE15_o,
                       PE16_o, PE17_o, PE18_o, PE19_o, PE20_o, PE21_o, PE22_o, PE23_o, PE24_o, PE25_o, PE26_o, PE27_o, PE28_o, PE29_o, PE30_o, PE31_o,
                       PE32_o, PE33_o, PE34_o, PE35_o, PE36_o, PE37_o, PE38_o, PE39_o, PE40_o, PE41_o, PE42_o, PE43_o, PE44_o, PE45_o, PE46_o, PE47_o,
                       PE48_o, PE49_o, PE50_o, PE51_o, PE52_o, PE53_o, PE54_o, PE55_o, PE56_o, PE57_o, PE58_o, PE59_o, PE60_o, PE61_o, PE62_o, PE63_o,
                       PE64_o, PE65_o, PE66_o, PE67_o, PE68_o, PE69_o, PE70_o, PE71_o, PE72_o, PE73_o, PE74_o, PE75_o, PE76_o, PE77_o, PE78_o, PE79_o,
                       PE80_o, PE81_o, PE82_o, PE83_o, PE84_o, PE85_o, PE86_o, PE87_o, PE88_o, PE89_o, PE90_o, PE91_o, PE92_o, PE93_o, PE94_o, PE95_o,
                       PE96_o, PE97_o, PE98_o, PE99_o, PE100_o, PE101_o, PE102_o, PE103_o, PE104_o, PE105_o, PE106_o, PE107_o, PE108_o, PE109_o, PE110_o, PE111_o,
                       PE112_o, PE113_o, PE114_o, PE115_o, PE116_o, PE117_o, PE118_o, PE119_o, PE120_o, PE121_o, PE122_o, PE123_o, PE124_o, PE125_o, PE126_o, PE127_o;
                   
    reg signed [11:0] PE128_o, PE129_o, PE130_o, PE131_o, PE132_o, PE133_o, PE134_o, PE135_o, PE136_o, PE137_o, PE138_o, PE139_o, PE140_o, PE141_o, PE142_o, PE143_o,
                      PE144_o, PE145_o, PE146_o, PE147_o, PE148_o, PE149_o, PE150_o, PE151_o, PE152_o, PE153_o, PE154_o, PE155_o, PE156_o, PE157_o, PE158_o, PE159_o,
                      PE160_o, PE161_o, PE162_o, PE163_o, PE164_o, PE165_o, PE166_o, PE167_o, PE168_o, PE169_o, PE170_o, PE171_o, PE172_o, PE173_o, PE174_o, PE175_o,
                      PE176_o, PE177_o, PE178_o, PE179_o, PE180_o, PE181_o, PE182_o, PE183_o, PE184_o, PE185_o, PE186_o, PE187_o, PE188_o, PE189_o, PE190_o, PE191_o,
                      PE192_o, PE193_o, PE194_o, PE195_o, PE196_o, PE197_o, PE198_o, PE199_o, PE200_o, PE201_o, PE202_o, PE203_o, PE204_o, PE205_o, PE206_o, PE207_o,
                      PE208_o, PE209_o, PE210_o, PE211_o, PE212_o, PE213_o, PE214_o, PE215_o, PE216_o, PE217_o, PE218_o, PE219_o, PE220_o, PE221_o, PE222_o, PE223_o,
                      PE224_o, PE225_o, PE226_o, PE227_o, PE228_o, PE229_o, PE230_o, PE231_o, PE232_o, PE233_o, PE234_o, PE235_o, PE236_o, PE237_o, PE238_o, PE239_o,
                      PE240_o, PE241_o, PE242_o, PE243_o, PE244_o, PE245_o, PE246_o, PE247_o, PE248_o, PE249_o, PE250_o, PE251_o, PE252_o, PE253_o, PE254_o, PE255_o;
    
    wire [191:0] LLR00  = LLR0[0];
    wire [191:0] LLR01  = LLR0[1];
    wire [191:0] LLR02  = LLR0[2];
    wire [191:0] LLR03  = LLR0[3];
    wire [191:0] LLR04  = LLR0[4];
    wire [191:0] LLR05  = LLR0[5];
    wire [191:0] LLR06  = LLR0[6];
    wire [191:0] LLR07  = LLR0[7];
    wire [191:0] LLR08  = LLR0[8];
    wire [191:0] LLR09  = LLR0[9];
    wire [191:0] LLR010 = LLR0[10];
    wire [191:0] LLR011 = LLR0[11];
    wire [191:0] LLR012 = LLR0[12];
    wire [191:0] LLR013 = LLR0[13];
    wire [191:0] LLR014 = LLR0[14];
    wire [191:0] LLR015 = LLR0[15];
    wire [191:0] LLR016 = LLR0[16];
    wire [191:0] LLR017 = LLR0[17];
    wire [191:0] LLR018 = LLR0[18];
    wire [191:0] LLR019 = LLR0[19];
    wire [191:0] LLR020 = LLR0[20];
    wire [191:0] LLR021 = LLR0[21];
    wire [191:0] LLR022 = LLR0[22];
    wire [191:0] LLR023 = LLR0[23];
    wire [191:0] LLR024 = LLR0[24];
    wire [191:0] LLR025 = LLR0[25];
    wire [191:0] LLR026 = LLR0[26];
    wire [191:0] LLR027 = LLR0[27];
    wire [191:0] LLR028 = LLR0[28];
    wire [191:0] LLR029 = LLR0[29];
    wire [191:0] LLR030 = LLR0[30];
    wire [191:0] LLR031 = LLR0[31];
    
    wire signed [11:0] llr_1_128 = LLR08[11:0];                                  
    wire signed [11:0] llr_2_128 = LLR024[11:0];
    wire signed [11:0] llr_1_129 = LLR08[23:12];                                         
    wire signed [11:0] llr_2_129 = LLR024[23:12];
    wire signed [11:0] llr_1_130 = LLR08[35:24];
    wire signed [11:0] llr_2_130 = LLR024[35:24];
    wire signed [11:0] llr_1_131 = LLR08[47:36];
    wire signed [11:0] llr_2_131 = LLR024[47:36];
    wire signed [11:0] llr_1_132 = LLR08[59:48];
    wire signed [11:0] llr_2_132 = LLR024[59:48];
    wire signed [11:0] llr_1_133 = LLR08[71:60];
    wire signed [11:0] llr_2_133 = LLR024[71:60];
    wire signed [11:0] llr_1_134 = LLR08[83:72];
    wire signed [11:0] llr_2_134 = LLR024[83:72];
    wire signed [11:0] llr_1_135 = LLR08[95:84];
    wire signed [11:0] llr_2_135 = LLR024[95:84];
    wire signed [11:0] llr_1_136 = LLR08[107:96];
    wire signed [11:0] llr_2_136 = LLR024[107:96];
    wire signed [11:0] llr_1_137 = LLR08[119:108];
    wire signed [11:0] llr_2_137 = LLR024[119:108];
    wire signed [11:0] llr_1_138 = LLR08[131:120];
    wire signed [11:0] llr_2_138 = LLR024[131:120];
    wire signed [11:0] llr_1_139 = LLR08[143:132];
    wire signed [11:0] llr_2_139 = LLR024[143:132];
    wire signed [11:0] llr_1_140 = LLR08[155:144];
    wire signed [11:0] llr_2_140 = LLR024[155:144];
    wire signed [11:0] llr_1_141 = LLR08[167:156];
    wire signed [11:0] llr_2_141 = LLR024[167:156];
    wire signed [11:0] llr_1_142 = LLR08[179:168];
    wire signed [11:0] llr_2_142 = LLR024[179:168];
    wire signed [11:0] llr_1_143 = LLR08[191:180];
    wire signed [11:0] llr_2_143 = LLR024[191:180];
    wire signed [11:0] llr_1_144 = LLR09[11:0];
    wire signed [11:0] llr_2_144 = LLR025[11:0];
    wire signed [11:0] llr_1_145 = LLR09[23:12];
    wire signed [11:0] llr_2_145 = LLR025[23:12];
    wire signed [11:0] llr_1_146 = LLR09[35:24];
    wire signed [11:0] llr_2_146 = LLR025[35:24];
    wire signed [11:0] llr_1_147 = LLR09[47:36];
    wire signed [11:0] llr_2_147 = LLR025[47:36];
    wire signed [11:0] llr_1_148 = LLR09[59:48];
    wire signed [11:0] llr_2_148 = LLR025[59:48];
    wire signed [11:0] llr_1_149 = LLR09[71:60];
    wire signed [11:0] llr_2_149 = LLR025[71:60];
    wire signed [11:0] llr_1_150 = LLR09[83:72];
    wire signed [11:0] llr_2_150 = LLR025[83:72];
    wire signed [11:0] llr_1_151 = LLR09[95:84];
    wire signed [11:0] llr_2_151 = LLR025[95:84];
    wire signed [11:0] llr_1_152 = LLR09[107:96];
    wire signed [11:0] llr_2_152 = LLR025[107:96];
    wire signed [11:0] llr_1_153 = LLR09[119:108];
    wire signed [11:0] llr_2_153 = LLR025[119:108];
    wire signed [11:0] llr_1_154 = LLR09[131:120];
    wire signed [11:0] llr_2_154 = LLR025[131:120];
    wire signed [11:0] llr_1_155 = LLR09[143:132];
    wire signed [11:0] llr_2_155 = LLR025[143:132];
    wire signed [11:0] llr_1_156 = LLR09[155:144];
    wire signed [11:0] llr_2_156 = LLR025[155:144];
    wire signed [11:0] llr_1_157 = LLR09[167:156];
    wire signed [11:0] llr_2_157 = LLR025[167:156];
    wire signed [11:0] llr_1_158 = LLR09[179:168];
    wire signed [11:0] llr_2_158 = LLR025[179:168];
    wire signed [11:0] llr_1_159 = LLR09[191:180];
    wire signed [11:0] llr_2_159 = LLR025[191:180];
    wire signed [11:0] llr_1_160 = LLR010[11:0];
    wire signed [11:0] llr_2_160 = LLR026[11:0];
    wire signed [11:0] llr_1_161 = LLR010[23:12];
    wire signed [11:0] llr_2_161 = LLR026[23:12];
    wire signed [11:0] llr_1_162 = LLR010[35:24];
    wire signed [11:0] llr_2_162 = LLR026[35:24];
    wire signed [11:0] llr_1_163 = LLR010[47:36];
    wire signed [11:0] llr_2_163 = LLR026[47:36];
    wire signed [11:0] llr_1_164 = LLR010[59:48];
    wire signed [11:0] llr_2_164 = LLR026[59:48];
    wire signed [11:0] llr_1_165 = LLR010[71:60];
    wire signed [11:0] llr_2_165 = LLR026[71:60];
    wire signed [11:0] llr_1_166 = LLR010[83:72];
    wire signed [11:0] llr_2_166 = LLR026[83:72];
    wire signed [11:0] llr_1_167 = LLR010[95:84];
    wire signed [11:0] llr_2_167 = LLR026[95:84];
    wire signed [11:0] llr_1_168 = LLR010[107:96];
    wire signed [11:0] llr_2_168 = LLR026[107:96];
    wire signed [11:0] llr_1_169 = LLR010[119:108];
    wire signed [11:0] llr_2_169 = LLR026[119:108];
    wire signed [11:0] llr_1_170 = LLR010[131:120];
    wire signed [11:0] llr_2_170 = LLR026[131:120];
    wire signed [11:0] llr_1_171 = LLR010[143:132];
    wire signed [11:0] llr_2_171 = LLR026[143:132];
    wire signed [11:0] llr_1_172 = LLR010[155:144];
    wire signed [11:0] llr_2_172 = LLR026[155:144];
    wire signed [11:0] llr_1_173 = LLR010[167:156];
    wire signed [11:0] llr_2_173 = LLR026[167:156];
    wire signed [11:0] llr_1_174 = LLR010[179:168];
    wire signed [11:0] llr_2_174 = LLR026[179:168];
    wire signed [11:0] llr_1_175 = LLR010[191:180];
    wire signed [11:0] llr_2_175 = LLR026[191:180];
    wire signed [11:0] llr_1_176 = LLR011[11:0];
    wire signed [11:0] llr_2_176 = LLR027[11:0];
    wire signed [11:0] llr_1_177 = LLR011[23:12];
    wire signed [11:0] llr_2_177 = LLR027[23:12];
    wire signed [11:0] llr_1_178 = LLR011[35:24];
    wire signed [11:0] llr_2_178 = LLR027[35:24];
    wire signed [11:0] llr_1_179 = LLR011[47:36];
    wire signed [11:0] llr_2_179 = LLR027[47:36];
    wire signed [11:0] llr_1_180 = LLR011[59:48];
    wire signed [11:0] llr_2_180 = LLR027[59:48];
    wire signed [11:0] llr_1_181 = LLR011[71:60];
    wire signed [11:0] llr_2_181 = LLR027[71:60];
    wire signed [11:0] llr_1_182 = LLR011[83:72];
    wire signed [11:0] llr_2_182 = LLR027[83:72];
    wire signed [11:0] llr_1_183 = LLR011[95:84];
    wire signed [11:0] llr_2_183 = LLR027[95:84];
    wire signed [11:0] llr_1_184 = LLR011[107:96];
    wire signed [11:0] llr_2_184 = LLR027[107:96];
    wire signed [11:0] llr_1_185 = LLR011[119:108];
    wire signed [11:0] llr_2_185 = LLR027[119:108];
    wire signed [11:0] llr_1_186 = LLR011[131:120];
    wire signed [11:0] llr_2_186 = LLR027[131:120];
    wire signed [11:0] llr_1_187 = LLR011[143:132];
    wire signed [11:0] llr_2_187 = LLR027[143:132];
    wire signed [11:0] llr_1_188 = LLR011[155:144];
    wire signed [11:0] llr_2_188 = LLR027[155:144];
    wire signed [11:0] llr_1_189 = LLR011[167:156];
    wire signed [11:0] llr_2_189 = LLR027[167:156];
    wire signed [11:0] llr_1_190 = LLR011[179:168];
    wire signed [11:0] llr_2_190 = LLR027[179:168];
    wire signed [11:0] llr_1_191 = LLR011[191:180];
    wire signed [11:0] llr_2_191 = LLR027[191:180];
    wire signed [11:0] llr_1_192 = LLR012[11:0];
    wire signed [11:0] llr_2_192 = LLR028[11:0];
    wire signed [11:0] llr_1_193 = LLR012[23:12];
    wire signed [11:0] llr_2_193 = LLR028[23:12];
    wire signed [11:0] llr_1_194 = LLR012[35:24];
    wire signed [11:0] llr_2_194 = LLR028[35:24];
    wire signed [11:0] llr_1_195 = LLR012[47:36];
    wire signed [11:0] llr_2_195 = LLR028[47:36];
    wire signed [11:0] llr_1_196 = LLR012[59:48];
    wire signed [11:0] llr_2_196 = LLR028[59:48];
    wire signed [11:0] llr_1_197 = LLR012[71:60];
    wire signed [11:0] llr_2_197 = LLR028[71:60];
    wire signed [11:0] llr_1_198 = LLR012[83:72];
    wire signed [11:0] llr_2_198 = LLR028[83:72];
    wire signed [11:0] llr_1_199 = LLR012[95:84];
    wire signed [11:0] llr_2_199 = LLR028[95:84];
    wire signed [11:0] llr_1_200 = LLR012[107:96];
    wire signed [11:0] llr_2_200 = LLR028[107:96];
    wire signed [11:0] llr_1_201 = LLR012[119:108];
    wire signed [11:0] llr_2_201 = LLR028[119:108];
    wire signed [11:0] llr_1_202 = LLR012[131:120];
    wire signed [11:0] llr_2_202 = LLR028[131:120];
    wire signed [11:0] llr_1_203 = LLR012[143:132];
    wire signed [11:0] llr_2_203 = LLR028[143:132];
    wire signed [11:0] llr_1_204 = LLR012[155:144];
    wire signed [11:0] llr_2_204 = LLR028[155:144];
    wire signed [11:0] llr_1_205 = LLR012[167:156];
    wire signed [11:0] llr_2_205 = LLR028[167:156];
    wire signed [11:0] llr_1_206 = LLR012[179:168];
    wire signed [11:0] llr_2_206 = LLR028[179:168];
    wire signed [11:0] llr_1_207 = LLR012[191:180];
    wire signed [11:0] llr_2_207 = LLR028[191:180];
    wire signed [11:0] llr_1_208 = LLR013[11:0];
    wire signed [11:0] llr_2_208 = LLR029[11:0];
    wire signed [11:0] llr_1_209 = LLR013[23:12];
    wire signed [11:0] llr_2_209 = LLR029[23:12];
    wire signed [11:0] llr_1_210 = LLR013[35:24];
    wire signed [11:0] llr_2_210 = LLR029[35:24];
    wire signed [11:0] llr_1_211 = LLR013[47:36];
    wire signed [11:0] llr_2_211 = LLR029[47:36];
    wire signed [11:0] llr_1_212 = LLR013[59:48];
    wire signed [11:0] llr_2_212 = LLR029[59:48];
    wire signed [11:0] llr_1_213 = LLR013[71:60];
    wire signed [11:0] llr_2_213 = LLR029[71:60];
    wire signed [11:0] llr_1_214 = LLR013[83:72];
    wire signed [11:0] llr_2_214 = LLR029[83:72];
    wire signed [11:0] llr_1_215 = LLR013[95:84];
    wire signed [11:0] llr_2_215 = LLR029[95:84];
    wire signed [11:0] llr_1_216 = LLR013[107:96];
    wire signed [11:0] llr_2_216 = LLR029[107:96];
    wire signed [11:0] llr_1_217 = LLR013[119:108];
    wire signed [11:0] llr_2_217 = LLR029[119:108];
    wire signed [11:0] llr_1_218 = LLR013[131:120];
    wire signed [11:0] llr_2_218 = LLR029[131:120];
    wire signed [11:0] llr_1_219 = LLR013[143:132];
    wire signed [11:0] llr_2_219 = LLR029[143:132];
    wire signed [11:0] llr_1_220 = LLR013[155:144];
    wire signed [11:0] llr_2_220 = LLR029[155:144];
    wire signed [11:0] llr_1_221 = LLR013[167:156];
    wire signed [11:0] llr_2_221 = LLR029[167:156];
    wire signed [11:0] llr_1_222 = LLR013[179:168];
    wire signed [11:0] llr_2_222 = LLR029[179:168];
    wire signed [11:0] llr_1_223 = LLR013[191:180];
    wire signed [11:0] llr_2_223 = LLR029[191:180];
    wire signed [11:0] llr_1_224 = LLR014[11:0];
    wire signed [11:0] llr_2_224 = LLR030[11:0];
    wire signed [11:0] llr_1_225 = LLR014[23:12];
    wire signed [11:0] llr_2_225 = LLR030[23:12];
    wire signed [11:0] llr_1_226 = LLR014[35:24];
    wire signed [11:0] llr_2_226 = LLR030[35:24];
    wire signed [11:0] llr_1_227 = LLR014[47:36];
    wire signed [11:0] llr_2_227 = LLR030[47:36];
    wire signed [11:0] llr_1_228 = LLR014[59:48];
    wire signed [11:0] llr_2_228 = LLR030[59:48];
    wire signed [11:0] llr_1_229 = LLR014[71:60];
    wire signed [11:0] llr_2_229 = LLR030[71:60];
    wire signed [11:0] llr_1_230 = LLR014[83:72];
    wire signed [11:0] llr_2_230 = LLR030[83:72];
    wire signed [11:0] llr_1_231 = LLR014[95:84];
    wire signed [11:0] llr_2_231 = LLR030[95:84];
    wire signed [11:0] llr_1_232 = LLR014[107:96];
    wire signed [11:0] llr_2_232 = LLR030[107:96];
    wire signed [11:0] llr_1_233 = LLR014[119:108];
    wire signed [11:0] llr_2_233 = LLR030[119:108];
    wire signed [11:0] llr_1_234 = LLR014[131:120];
    wire signed [11:0] llr_2_234 = LLR030[131:120];
    wire signed [11:0] llr_1_235 = LLR014[143:132];
    wire signed [11:0] llr_2_235 = LLR030[143:132];
    wire signed [11:0] llr_1_236 = LLR014[155:144];
    wire signed [11:0] llr_2_236 = LLR030[155:144];
    wire signed [11:0] llr_1_237 = LLR014[167:156];
    wire signed [11:0] llr_2_237 = LLR030[167:156];
    wire signed [11:0] llr_1_238 = LLR014[179:168];
    wire signed [11:0] llr_2_238 = LLR030[179:168];
    wire signed [11:0] llr_1_239 = LLR014[191:180];
    wire signed [11:0] llr_2_239 = LLR030[191:180];
    wire signed [11:0] llr_1_240 = LLR015[11:0];
    wire signed [11:0] llr_2_240 = LLR031[11:0];
    wire signed [11:0] llr_1_241 = LLR015[23:12];
    wire signed [11:0] llr_2_241 = LLR031[23:12];
    wire signed [11:0] llr_1_242 = LLR015[35:24];
    wire signed [11:0] llr_2_242 = LLR031[35:24];
    wire signed [11:0] llr_1_243 = LLR015[47:36];
    wire signed [11:0] llr_2_243 = LLR031[47:36];
    wire signed [11:0] llr_1_244 = LLR015[59:48];
    wire signed [11:0] llr_2_244 = LLR031[59:48];
    wire signed [11:0] llr_1_245 = LLR015[71:60];
    wire signed [11:0] llr_2_245 = LLR031[71:60];
    wire signed [11:0] llr_1_246 = LLR015[83:72];
    wire signed [11:0] llr_2_246 = LLR031[83:72];
    wire signed [11:0] llr_1_247 = LLR015[95:84];
    wire signed [11:0] llr_2_247 = LLR031[95:84];
    wire signed [11:0] llr_1_248 = LLR015[107:96];
    wire signed [11:0] llr_2_248 = LLR031[107:96];
    wire signed [11:0] llr_1_249 = LLR015[119:108];
    wire signed [11:0] llr_2_249 = LLR031[119:108];
    wire signed [11:0] llr_1_250 = LLR015[131:120];
    wire signed [11:0] llr_2_250 = LLR031[131:120];
    wire signed [11:0] llr_1_251 = LLR015[143:132];
    wire signed [11:0] llr_2_251 = LLR031[143:132];
    wire signed [11:0] llr_1_252 = LLR015[155:144];
    wire signed [11:0] llr_2_252 = LLR031[155:144];
    wire signed [11:0] llr_1_253 = LLR015[167:156];
    wire signed [11:0] llr_2_253 = LLR031[167:156];
    wire signed [11:0] llr_1_254 = LLR015[179:168];
    wire signed [11:0] llr_2_254 = LLR031[179:168];
    wire signed [11:0] llr_1_255 = LLR015[191:180];
    wire signed [11:0] llr_2_255 = LLR031[191:180];
    
    reg [9:0] current_N;
    reg [7:0] current_K;
    reg reuse;
    
    wire [6:0] RELIABILITY_128 [0:127];
    wire [7:0] RELIABILITY_256 [0:255];
    wire [8:0] RELIABILITY_512 [0:511];
    
    wire [9:0] reliability_index_0 = num_of_u_done<<1;
    wire [9:0] reliability_index_1 = reliability_index_0 + 10'd1;
    
    wire not_exist = (current_N[0] && reliability_index_0>10'd127 || current_N[1] && reliability_index_0>10'd255 || current_N[2] && reliability_index_0>10'd511);
    
    wire [6:0] current_reliability_128_0 = RELIABILITY_128[reliability_index_0];
    wire [7:0] current_reliability_256_0 = RELIABILITY_256[reliability_index_0];
    wire [8:0] current_reliability_512_0 = RELIABILITY_512[reliability_index_0];
    wire [6:0] current_reliability_128_1 = RELIABILITY_128[reliability_index_1];
    wire [7:0] current_reliability_256_1 = RELIABILITY_256[reliability_index_1];
    wire [8:0] current_reliability_512_1 = RELIABILITY_512[reliability_index_1];
    
    wire [6:0] threshold_128 = 7'd127-current_K;
    wire [7:0] threshold_256 = 8'd255-current_K;
    wire [8:0] threshold_512 = 9'd511-current_K;
    
    wire frozen_1_i = (not_exist)?1'b0:
                      (current_N[0] && current_reliability_128_0>threshold_128)?1'b0:
                      (current_N[1] && current_reliability_256_0>threshold_256)?1'b0:
                      (current_N[2] && current_reliability_512_0>threshold_512)?1'b0:
                      1'b1;
    wire frozen_2_i = (not_exist)?1'b0:
                      (current_N[0] && current_reliability_128_1>threshold_128)?1'b0:
                      (current_N[1] && current_reliability_256_1>threshold_256)?1'b0:
                      (current_N[2] && current_reliability_512_1>threshold_512)?1'b0:
                      1'b1;
    
    always@(posedge clk)begin
      if(!module_en)begin
        state <= RST;
      end else begin
        state <= n_state;
      end
    end
    
    always@(posedge clk)begin
      if(!module_en || state!=n_state&&(state==RST||state==EX_READ))begin
        counter <= 6'd0;
      end else if(counter==6'd33)begin
        counter <= 6'd33;
      end else begin
        counter <= counter + 6'd1;
      end
    end
    
    always@(posedge clk)begin
      if(!module_en || state!=n_state&&n_state!=DONE || EX_counter==6'd7&&current_N[0] || EX_counter==6'd8&&current_N[1] || EX_counter==6'd9&&current_N[2] || (frozen_1_i&&frozen_2_i || not_exist))begin
        if(reuse && ~(frozen_1_i&&frozen_2_i || not_exist))begin
          case(1'b1)
            current_N[0]:EX_counter <= 6'd5;
            current_N[1]:EX_counter <= 6'd6;
            current_N[2]:EX_counter <= 6'd7;
            default:     EX_counter <= 6'd0;
          endcase
        end else if(current_N[2])begin
          EX_counter <= 6'b111_111;
        end else begin
          EX_counter <= 6'd0;
        end
      end else begin
        EX_counter <= EX_counter + 6'd1;
      end
    end
    
    always@(posedge clk)begin
      if(!module_en)begin
        raddr <= 11'd0;
      //end else if(n_state==RST || n_state==READ || n_state==EX_READ)begin
      end else if(n_state==DONE || counter<=6'd31)begin
          raddr <= raddr + 11'd1;
        //end
      end
    end
    
    always@(posedge clk)begin
      if(!module_en)begin
        NUM_PACKET <= 6'd0;
      end else if(state==RST)begin
        NUM_PACKET <= rdata[5:0];
      end
    end
    
    always@(posedge clk)begin
      if(~module_en || state==RST)begin
        K <= 8'd0;
        N <= 10'd0;
      end else if(counter==6'd0)begin
        K <= rdata[17:10];
        N <= rdata[9:7];
      end
    end

    always@(posedge clk)begin
      if(!module_en)begin
        current_N <= 10'd0;
        current_K <= 8'd0;
      end else if(EX_counter==6'd0 || EX_counter==6'b111_111)begin
        current_N <= N;
        current_K <= K;
      end
    end
    
    always@(posedge clk)begin
      if(counter<=6'd32 && counter>=6'd1)begin
          LLR0[counter-6'd1] <= rdata;
      end
    end
    
    always@(posedge clk)begin
      if(!module_en)begin
        num_of_packet <= 6'd0;
      end else if(state==DONE)begin
        num_of_packet <= num_of_packet + 6'd1;
      end
    end
    
    always@(posedge clk)begin
      if(num_of_packet==NUM_PACKET-6'd1 && state==DONE)begin
        proc_done <= 1'b1;
      end else begin
        proc_done <= 1'b0;
      end
      //proc_done = (num_of_packet==NUM_PACKET-6'd1 && state==DONE);
    end
    
    assign select_initial = (current_N[0])?3'd5:
                            (current_N[1])?3'd6:
                            //(current_N[2])?3'd7:
                            3'd7;
    
    assign select_index = (EX_counter==6'b111_111)?select_initial:select_initial - EX_counter;
    //assign select_index = select_initial - EX_counter;
    assign select_i = select[select_index];
    /*
    always@(posedge clk)begin
      if(state==READ || state==DONE)begin
        select <= 8'd0;
      //end else if(state==EX_READ && (EX_counter==10'd6&&current_N[0] || EX_counter==10'd7&&current_N[1] || EX_counter==10'd8&&current_N[2]))begin
      end else if(state==EX_READ && (EX_counter==6'd6&&current_N[0] || EX_counter==6'd7&&current_N[1] || EX_counter==6'd8&&current_N[2] || frozen_1_i&&frozen_2_i))begin
        select <= select + 8'd1;
      end
    end
    */
    always@(posedge clk)begin
      if(~module_en || state==READ || state==DONE)begin
        num_of_u_done <= 9'd0;
      end else if(state==EX_READ && (EX_counter==6'd6&&current_N[0] || EX_counter==6'd7&&current_N[1] || EX_counter==6'd8&&current_N[2] || frozen_1_i&&frozen_2_i))begin
      //end else if(state==EX_READ && (EX_counter==6'd7&&current_N[0] || EX_counter==6'd8&&current_N[1] || EX_counter==6'd9&&current_N[2]))begin
        num_of_u_done <= num_of_u_done + 9'd1;
      end
    end
    
    always@(*)begin
      case(state)
        RST:begin
          n_state = (module_en && counter!=6'd0)?READ:RST;
        end
        READ:begin
          n_state = (counter==6'd8&&current_N[0] || counter==6'd16&&current_N[1] || counter==6'd32&&current_N[2])?EX_READ:
                    READ;
        end
        EX_READ:begin
          n_state = (num_of_u_done=={current_N-3'd1, 6'b111111} && (EX_counter==6'd6&&current_N[0] || EX_counter==6'd7&&current_N[1] || EX_counter==6'd8&&current_N[2]))?DONE:EX_READ;
        end
        DONE:begin
          n_state = (num_of_packet==NUM_PACKET-6'd1)?RST:READ;
        end
      endcase
    end
    
    wire PE_h0;
    wire PE_h1;
    wire [255:0] u_for_g;
    
    reg u0_write;
    reg u1_write;
    always@(posedge clk)begin
      if(!module_en)begin
        u0_write <= 1'b0;
        u1_write <= 1'b0;
      end else if(EX_counter==6'd5&&current_N[0] || EX_counter==6'd6&&current_N[1] || EX_counter==6'd7&&current_N[2])begin
        u0_write <= ~frozen_1_i;
        u1_write <= ~frozen_2_i;
      end
    end
    
    reg [7:0] write_index;
    always@(posedge clk)begin
      if(!module_en || state==DONE)begin
        wdata <= 192'd0;
        write_index <= 8'd0;
      end else if(EX_counter==6'd6&&current_N[0] || EX_counter==6'd7&&current_N[1] || EX_counter==6'd8&&current_N[2])begin
        if(u0_write && u1_write)begin
          {wdata[write_index+8'd1], wdata[write_index]} <= {PE_h1, PE_h0};
          write_index <= write_index + 8'd2;
        end else if(u0_write)begin
          wdata[write_index] <= PE_h0;
          write_index <= write_index + 8'd1;
        end else if(u1_write)begin
          wdata[write_index] <= PE_h1;
          write_index <= write_index + 8'd1;
        end
      end
    end
    
    always@(posedge clk)begin
      if(!module_en)begin
        waddr <= 6'd0;
      end else if(state==DONE)begin
        waddr <= waddr + 6'd1;
      end
    end
    
    wire en = (EX_counter==6'd6&&current_N[0] || EX_counter==6'd7&&current_N[1] || EX_counter==6'd8&&current_N[2]);
    /*
    reg en;
    always@(posedge clk)begin
      if(state==EX_READ && (EX_counter==6'd5&&current_N[0] || EX_counter==6'd6&&current_N[1] || EX_counter==6'd7&&current_N[2]))begin
        en <= 1'b1;
      end else begin
        en <= 1'b0;
      end
    end
    */
    reg [6:0] which_u;
    always@(posedge clk)begin
      if(!module_en)begin
        which_u <= 7'd0;
      end else if(reuse && ~(frozen_1_i&&frozen_2_i))begin
          case(1'b1)
            current_N[0]:which_u <= select[7:1];
            current_N[1]:which_u <= select[7:1];
            current_N[2]:which_u <= select[7:1];
            default:     which_u <= 7'd0;
          endcase
      end else if(EX_counter>=6'd0 && (EX_counter<=6'd4&&current_N[0] || EX_counter<=6'd5&&current_N[1] || EX_counter<=6'd6&&current_N[2]) && ~(frozen_1_i&&frozen_2_i))begin
        which_u <= {which_u[5:0], select_i};
      end else begin
        which_u <= 7'd0;
      end
    end
    
    reg [3:0] shift;
    always@(posedge clk)begin
      if(frozen_1_i&&frozen_2_i)begin
        shift <= 4'd0;
      end else if((EX_counter==6'd0) && current_N[0])begin
        shift <= 4'd5;
      end else if((EX_counter==6'd0) && current_N[1])begin
        shift <= 4'd6;
      end else if((EX_counter==6'd0 || EX_counter==6'b111_111) && current_N[2])begin
        shift <= 4'd7;
      end else if(reuse && ~(frozen_1_i&&frozen_2_i))begin
        shift <= 6'd1;
      end else begin
        shift <= shift - 4'd1;
      end
    end
    
    reg [9:0] u_index;
    always@(*)begin
      u_index <= which_u << shift;
    end
    
    reg signed [11:0] last_out_0;
    reg signed [11:0] last_out_1;
    reg signed [11:0] last_out_2;
    reg signed [11:0] last_out_3;
    
    always@(posedge clk)begin
      if(~select[0] && (EX_counter==6'd5&&current_N[0] || EX_counter==6'd6&&current_N[1] || EX_counter==6'd7&&current_N[2]))begin
        last_out_0 <= PE0_o;
        last_out_1 <= PE1_o;
        last_out_2 <= PE2_o;
        last_out_3 <= PE3_o;
      end
    end
    always@(posedge clk)begin
      if(!module_en)begin
        reuse <= 1'b0;
      end else if(~(frozen_1_i&&frozen_2_i) && (EX_counter==6'd5&&current_N[0] || EX_counter==6'd6&&current_N[1] || EX_counter==6'd7&&current_N[2]))begin
        if(~select[0])begin
          reuse <= 1'b1;
        end else begin
          reuse <= 1'b0;
        end
      end else if(frozen_1_i&&frozen_2_i)begin
        reuse <= 1'b0;
      end
    end
    
    always@(posedge clk)begin
      if(EX_counter==6'd0)begin
        PE128_o <= PE0_o;
        PE129_o <= PE1_o;
        PE130_o <= PE2_o;
        PE131_o <= PE3_o;
        PE132_o <= PE4_o;
        PE133_o <= PE5_o;
        PE134_o <= PE6_o;
        PE135_o <= PE7_o;
        PE136_o <= PE8_o;
        PE137_o <= PE9_o;
        PE138_o <= PE10_o;
        PE139_o <= PE11_o;
        PE140_o <= PE12_o;
        PE141_o <= PE13_o;
        PE142_o <= PE14_o;
        PE143_o <= PE15_o;
        PE144_o <= PE16_o;
        PE145_o <= PE17_o;
        PE146_o <= PE18_o;
        PE147_o <= PE19_o;
        PE148_o <= PE20_o;
        PE149_o <= PE21_o;
        PE150_o <= PE22_o;
        PE151_o <= PE23_o;
        PE152_o <= PE24_o;
        PE153_o <= PE25_o;
        PE154_o <= PE26_o;
        PE155_o <= PE27_o;
        PE156_o <= PE28_o;
        PE157_o <= PE29_o;
        PE158_o <= PE30_o;
        PE159_o <= PE31_o;
        PE160_o <= PE32_o;
        PE161_o <= PE33_o;
        PE162_o <= PE34_o;
        PE163_o <= PE35_o;
        PE164_o <= PE36_o;
        PE165_o <= PE37_o;
        PE166_o <= PE38_o;
        PE167_o <= PE39_o;
        PE168_o <= PE40_o;
        PE169_o <= PE41_o;
        PE170_o <= PE42_o;
        PE171_o <= PE43_o;
        PE172_o <= PE44_o;
        PE173_o <= PE45_o;
        PE174_o <= PE46_o;
        PE175_o <= PE47_o;
        PE176_o <= PE48_o;
        PE177_o <= PE49_o;
        PE178_o <= PE50_o;
        PE179_o <= PE51_o;
        PE180_o <= PE52_o;
        PE181_o <= PE53_o;
        PE182_o <= PE54_o;
        PE183_o <= PE55_o;
        PE184_o <= PE56_o;
        PE185_o <= PE57_o;
        PE186_o <= PE58_o;
        PE187_o <= PE59_o;
        PE188_o <= PE60_o;
        PE189_o <= PE61_o;
        PE190_o <= PE62_o;
        PE191_o <= PE63_o;
        PE192_o <= PE64_o;
        PE193_o <= PE65_o;
        PE194_o <= PE66_o;
        PE195_o <= PE67_o;
        PE196_o <= PE68_o;
        PE197_o <= PE69_o;
        PE198_o <= PE70_o;
        PE199_o <= PE71_o;
        PE200_o <= PE72_o;
        PE201_o <= PE73_o;
        PE202_o <= PE74_o;
        PE203_o <= PE75_o;
        PE204_o <= PE76_o;
        PE205_o <= PE77_o;
        PE206_o <= PE78_o;
        PE207_o <= PE79_o;
        PE208_o <= PE80_o;
        PE209_o <= PE81_o;
        PE210_o <= PE82_o;
        PE211_o <= PE83_o;
        PE212_o <= PE84_o;
        PE213_o <= PE85_o;
        PE214_o <= PE86_o;
        PE215_o <= PE87_o;
        PE216_o <= PE88_o;
        PE217_o <= PE89_o;
        PE218_o <= PE90_o;
        PE219_o <= PE91_o;
        PE220_o <= PE92_o;
        PE221_o <= PE93_o;
        PE222_o <= PE94_o;
        PE223_o <= PE95_o;
        PE224_o <= PE96_o;
        PE225_o <= PE97_o;
        PE226_o <= PE98_o;
        PE227_o <= PE99_o;
        PE228_o <= PE100_o;
        PE229_o <= PE101_o;
        PE230_o <= PE102_o;
        PE231_o <= PE103_o;
        PE232_o <= PE104_o;
        PE233_o <= PE105_o;
        PE234_o <= PE106_o;
        PE235_o <= PE107_o;
        PE236_o <= PE108_o;
        PE237_o <= PE109_o;
        PE238_o <= PE110_o;
        PE239_o <= PE111_o;
        PE240_o <= PE112_o;
        PE241_o <= PE113_o;
        PE242_o <= PE114_o;
        PE243_o <= PE115_o;
        PE244_o <= PE116_o;
        PE245_o <= PE117_o;
        PE246_o <= PE118_o;
        PE247_o <= PE119_o;
        PE248_o <= PE120_o;
        PE249_o <= PE121_o;
        PE250_o <= PE122_o;
        PE251_o <= PE123_o;
        PE252_o <= PE124_o;
        PE253_o <= PE125_o;
        PE254_o <= PE126_o;
        PE255_o <= PE127_o;
      end
    end
    
    XOR_u XOR_u(.clk_i     (clk),
                .rst_ni    (state==DONE || !module_en),
                .en_i      (en),
                .u0_i      (PE_h0),
                .u1_i      (PE_h1),
                .select_i  (num_of_u_done),
                .select_o_i(select_index),
                .u_o       (u_for_g));
    
    PE_h PE_h(.llr_1_i   (PE0_o),
              .llr_2_i   (PE1_o),
              .frozen_1_i(frozen_1_i),
              .frozen_2_i(frozen_2_i),
              .u_1_o     (PE_h0),
              .u_2_o     (PE_h1));
    
    wire choose   = select_index == select_initial;
    wire choose_0 = select_index == select_initial && current_N[0];
    wire choose_1 = select_index == select_initial && current_N[1];
    wire choose_2 = select_index == select_initial && current_N[2];
    
    wire signed [11:0] llr_1_0 = //(reuse)?last_out_0:
                                 (EX_counter==6'b111_111)?llr_1_128:
                                 (choose)?$signed(LLR00[11:0]):
                                 (reuse && select_index==3'd0)?last_out_0:
                                 PE0_o;
    wire signed [11:0] llr_2_0 = //(reuse)?last_out_1:
                                 (EX_counter==6'b111_111)?llr_2_128:
                                 (choose_0)?$signed(LLR04[11:0]):
                                 (choose_1)?$signed(LLR08[11:0]):
                                 (choose_2)?$signed(LLR016[11:0]):
                                 (select_index==4'd6)?PE128_o:
                                 (select_index==4'd5)?PE64_o:
                                 (select_index==4'd4)?PE32_o:
                                 (select_index==4'd3)?PE16_o:
                                 (select_index==4'd2)?PE8_o:
                                 (select_index==4'd1)?PE4_o:
                                 /*(select_index==4'd0)?*/(reuse && select_index==3'd0)?last_out_2:
                                 PE2_o;
    wire u0 = (EX_counter==6'b111_111)?u_for_g[u_index+128]:u_for_g[u_index];
    PE PE0(.clk_i   (clk),
           .llr_1_i (llr_1_0),
           .llr_2_i (llr_2_0),
           .sum_i   (u0),
           .select_i(select_i),
           .result_o(PE0_o));
    
    wire signed [11:0] llr_1_1 = //(reuse)?last_out_2:
                                 (EX_counter==6'b111_111)?llr_1_129:
                                 (choose)?$signed(LLR00[23:12]):
                                 (reuse && select_index==3'd0)?last_out_1:
                                 PE1_o;
    wire signed [11:0] llr_2_1 = //(reuse)?last_out_3:
                                 (EX_counter==6'b111_111)?llr_2_129:
                                 (choose_0)?$signed(LLR04[23:12]):
                                 (choose_1)?$signed(LLR08[23:12]):
                                 (choose_2)?$signed(LLR016[23:12]):
                                 (select_index==4'd6)?PE129_o:
                                 (select_index==4'd5)?PE65_o:
                                 (select_index==4'd4)?PE33_o:
                                 (select_index==4'd3)?PE17_o:
                                 (select_index==4'd2)?PE9_o:
                                 (select_index==4'd1)?PE5_o:
                                 /*(select_index==4'd0)?*/(reuse && select_index==3'd0)?last_out_3:
                                 PE3_o;
    wire u1 = (EX_counter==6'b111_111)?u_for_g[u_index+129]:u_for_g[u_index+1];
    PE PE1(.clk_i   (clk),
           .llr_1_i (llr_1_1),
           .llr_2_i (llr_2_1),
           .sum_i   (u1),
           .select_i(select_i),
           .result_o(PE1_o));
    
    wire signed [11:0] llr_1_2 = (EX_counter==6'b111_111)?llr_1_130:
                                 (choose)?$signed(LLR00[35:24]):
                                 PE2_o;
    wire signed [11:0] llr_2_2 = (EX_counter==6'b111_111)?llr_2_130:
                                 (choose_0)?$signed(LLR04[35:24]):
                                 (choose_1)?$signed(LLR08[35:24]):
                                 (choose_2)?$signed(LLR016[35:24]):
                                 (select_index==4'd6)?PE130_o:
                                 (select_index==4'd5)?PE66_o:
                                 (select_index==4'd4)?PE34_o:
                                 (select_index==4'd3)?PE18_o:
                                 (select_index==4'd2)?PE10_o:
                                 PE6_o;
    wire u2 = (EX_counter==6'b111_111)?u_for_g[u_index+130]:u_for_g[u_index+2];
    PE PE2(.clk_i   (clk),
           .llr_1_i (llr_1_2),
           .llr_2_i (llr_2_2),
           .sum_i   (u2),
           .select_i(select_i),
           .result_o(PE2_o));
    
    wire signed [11:0] llr_1_3 = (EX_counter==6'b111_111)?llr_1_131:
                                 (choose)?$signed(LLR00[47:36]):
                                 PE3_o;
    wire signed [11:0] llr_2_3 = (EX_counter==6'b111_111)?llr_2_131:
                                 (choose_0)?$signed(LLR04[47:36]):
                                 (choose_1)?$signed(LLR08[47:36]):
                                 (choose_2)?$signed(LLR016[47:36]):
                                 (select_index==4'd6)?PE131_o:
                                 (select_index==4'd5)?PE67_o:
                                 (select_index==4'd4)?PE35_o:
                                 (select_index==4'd3)?PE19_o:
                                 (select_index==4'd2)?PE11_o:
                                 PE7_o;
    wire u3 = (EX_counter==6'b111_111)?u_for_g[u_index+131]:u_for_g[u_index+3];
    PE PE3(.clk_i   (clk),
           .llr_1_i (llr_1_3),
           .llr_2_i (llr_2_3),
           .sum_i   (u3),
           .select_i(select_i),
           .result_o(PE3_o));
    
    wire signed [11:0] llr_1_4 = (EX_counter==6'b111_111)?llr_1_132:
                                 (choose)?$signed(LLR00[59:48]):
                                 PE4_o;
    wire signed [11:0] llr_2_4 = (EX_counter==6'b111_111)?llr_2_132:
                                 (choose_0)?$signed(LLR04[59:48]):
                                 (choose_1)?$signed(LLR08[59:48]):
                                 (choose_2)?$signed(LLR016[59:48]):
                                 (select_index==4'd6)?PE132_o:
                                 (select_index==4'd5)?PE68_o:
                                 (select_index==4'd4)?PE36_o:
                                 (select_index==4'd3)?PE20_o:
                                 PE12_o;
    wire u4 = (EX_counter==6'b111_111)?u_for_g[u_index+132]:u_for_g[u_index+4];
    PE PE4(.clk_i   (clk),
           .llr_1_i (llr_1_4),
           .llr_2_i (llr_2_4),
           .sum_i   (u4),
           .select_i(select_i),
           .result_o(PE4_o));
    
    wire signed [11:0] llr_1_5 = (EX_counter==6'b111_111)?llr_1_133:
                                 (choose)?$signed(LLR00[71:60]):
                                 PE5_o;
    wire signed [11:0] llr_2_5 = (EX_counter==6'b111_111)?llr_2_133:
                                 (choose_0)?$signed(LLR04[71:60]):
                                 (choose_1)?$signed(LLR08[71:60]):
                                 (choose_2)?$signed(LLR016[71:60]):
                                 (select_index==4'd6)?PE133_o:
                                 (select_index==4'd5)?PE69_o:
                                 (select_index==4'd4)?PE37_o:
                                 (select_index==4'd3)?PE21_o:
                                 PE13_o;
    wire u5 = (EX_counter==6'b111_111)?u_for_g[u_index+133]:u_for_g[u_index+5];
    PE PE5(.clk_i   (clk),
           .llr_1_i (llr_1_5),
           .llr_2_i (llr_2_5),
           .sum_i   (u5),
           .select_i(select_i),
           .result_o(PE5_o));
    
    wire signed [11:0] llr_1_6 = (EX_counter==6'b111_111)?llr_1_134:
                                 (choose)?$signed(LLR00[83:72]):
                                 PE6_o;
    wire signed [11:0] llr_2_6 = (EX_counter==6'b111_111)?llr_2_134:
                                 (choose_0)?$signed(LLR04[83:72]):
                                 (choose_1)?$signed(LLR08[83:72]):
                                 (choose_2)?$signed(LLR016[83:72]):
                                 (select_index==4'd6)?PE134_o:
                                 (select_index==4'd5)?PE70_o:
                                 (select_index==4'd4)?PE38_o:
                                 (select_index==4'd3)?PE22_o:
                                 PE14_o;
    wire u6 = (EX_counter==6'b111_111)?u_for_g[u_index+134]:u_for_g[u_index+6];
    PE PE6(.clk_i   (clk),
           .llr_1_i (llr_1_6),
           .llr_2_i (llr_2_6),
           .sum_i   (u6),
           .select_i(select_i),
           .result_o(PE6_o));
    
    wire signed [11:0] llr_1_7 = (EX_counter==6'b111_111)?llr_1_135:
                                 (choose)?$signed(LLR00[95:84]):
                                 PE7_o;
    wire signed [11:0] llr_2_7 = (EX_counter==6'b111_111)?llr_2_135:
                                 (choose_0)?$signed(LLR04[95:84]):
                                 (choose_1)?$signed(LLR08[95:84]):
                                 (choose_2)?$signed(LLR016[95:84]):
                                 (select_index==4'd6)?PE135_o:
                                 (select_index==4'd5)?PE71_o:
                                 (select_index==4'd4)?PE39_o:
                                 (select_index==4'd3)?PE23_o:
                                 PE15_o;
    wire u7 = (EX_counter==6'b111_111)?u_for_g[u_index+135]:u_for_g[u_index+7];
    PE PE7(.clk_i   (clk),
           .llr_1_i (llr_1_7),
           .llr_2_i (llr_2_7),
           .sum_i   (u7),
           .select_i(select_i),
           .result_o(PE7_o));
    
    wire signed [11:0] llr_1_8 = (EX_counter==6'b111_111)?llr_1_136:
                                 (choose)?$signed(LLR00[107:96]):
                                 PE8_o;
    wire signed [11:0] llr_2_8 = (EX_counter==6'b111_111)?llr_2_136:
                                 (choose_0)?$signed(LLR04[107:96]):
                                 (choose_1)?$signed(LLR08[107:96]):
                                 (choose_2)?$signed(LLR016[107:96]):
                                 (select_index==4'd6)?PE136_o:
                                 (select_index==4'd5)?PE72_o:
                                 (select_index==4'd4)?PE40_o:
                                 PE24_o;
    wire u8 = (EX_counter==6'b111_111)?u_for_g[u_index+136]:u_for_g[u_index+8];
    PE PE8(.clk_i   (clk),
           .llr_1_i (llr_1_8),
           .llr_2_i (llr_2_8),
           .sum_i   (u8),
           .select_i(select_i),
           .result_o(PE8_o));
    
    wire signed [11:0] llr_1_9 = (EX_counter==6'b111_111)?llr_1_137:
                                 (choose)?$signed(LLR00[119:108]):
                                 PE9_o;
    wire signed [11:0] llr_2_9 = (EX_counter==6'b111_111)?llr_2_137:
                                 (choose_0)?$signed(LLR04[119:108]):
                                 (choose_1)?$signed(LLR08[119:108]):
                                 (choose_2)?$signed(LLR016[119:108]):
                                 (select_index==4'd6)?PE137_o:
                                 (select_index==4'd5)?PE73_o:
                                 (select_index==4'd4)?PE41_o:
                                 PE25_o;
    wire u9 = (EX_counter==6'b111_111)?u_for_g[u_index+137]:u_for_g[u_index+9];
    PE PE9(.clk_i   (clk),
           .llr_1_i (llr_1_9),
           .llr_2_i (llr_2_9),
           .sum_i   (u9),
           .select_i(select_i),
           .result_o(PE9_o));
    
    wire signed [11:0] llr_1_10 = (EX_counter==6'b111_111)?llr_1_138:
                                 (choose)?$signed(LLR00[131:120]):
                                  PE10_o;
    wire signed [11:0] llr_2_10 = (EX_counter==6'b111_111)?llr_2_138:
                                 (choose_0)?$signed(LLR04[131:120]):
                                  (choose_1)?$signed(LLR08[131:120]):
                                  (choose_2)?$signed(LLR016[131:120]):
                                  (select_index==4'd6)?PE138_o:
                                  (select_index==4'd5)?PE74_o:
                                  (select_index==4'd4)?PE42_o:
                                  PE26_o;
    wire u10 = (EX_counter==6'b111_111)?u_for_g[u_index+138]:u_for_g[u_index+10];
    PE PE10(.clk_i   (clk),
            .llr_1_i (llr_1_10),
            .llr_2_i (llr_2_10),
            .sum_i   (u10),
            .select_i(select_i),
            .result_o(PE10_o));
    
    wire signed [11:0] llr_1_11 = (EX_counter==6'b111_111)?llr_1_139:
                                 (choose)?$signed(LLR00[143:132]):
                                  PE11_o;
    wire signed [11:0] llr_2_11 = (EX_counter==6'b111_111)?llr_2_139:
                                 (choose_0)?$signed(LLR04[143:132]):
                                  (choose_1)?$signed(LLR08[143:132]):
                                  (choose_2)?$signed(LLR016[143:132]):
                                  (select_index==4'd6)?PE139_o:
                                  (select_index==4'd5)?PE75_o:
                                  (select_index==4'd4)?PE43_o:
                                  PE27_o;
    wire u11 = (EX_counter==6'b111_111)?u_for_g[u_index+139]:u_for_g[u_index+11];
    PE PE11(.clk_i   (clk),
            .llr_1_i (llr_1_11),
            .llr_2_i (llr_2_11),
            .sum_i   (u11),
            .select_i(select_i),
            .result_o(PE11_o));
    
    wire signed [11:0] llr_1_12 = (EX_counter==6'b111_111)?llr_1_140:
                                 (choose)?$signed(LLR00[155:144]):
                                  PE12_o;
    wire signed [11:0] llr_2_12 = (EX_counter==6'b111_111)?llr_2_140:
                                 (choose_0)?$signed(LLR04[155:144]):
                                  (choose_1)?$signed(LLR08[155:144]):
                                  (choose_2)?$signed(LLR016[155:144]):
                                  (select_index==4'd6)?PE140_o:
                                  (select_index==4'd5)?PE76_o:
                                  (select_index==4'd4)?PE44_o:
                                  PE28_o;
    wire u12 = (EX_counter==6'b111_111)?u_for_g[u_index+140]:u_for_g[u_index+12];
    PE PE12(.clk_i   (clk),
            .llr_1_i (llr_1_12),
            .llr_2_i (llr_2_12),
            .sum_i   (u12),
            .select_i(select_i),
            .result_o(PE12_o));
    
    wire signed [11:0] llr_1_13 = (EX_counter==6'b111_111)?llr_1_141:
                                  (choose)?$signed(LLR00[167:156]):
                                  PE13_o;
    wire signed [11:0] llr_2_13 = (EX_counter==6'b111_111)?llr_2_141:
                                  (choose_0)?$signed(LLR04[167:156]):
                                  (choose_1)?$signed(LLR08[167:156]):
                                  (choose_2)?$signed(LLR016[167:156]):
                                  (select_index==4'd6)?PE141_o:
                                  (select_index==4'd5)?PE77_o:
                                  (select_index==4'd4)?PE45_o:
                                  PE29_o;
    wire u13 = (EX_counter==6'b111_111)?u_for_g[u_index+141]:u_for_g[u_index+13];
    PE PE13(.clk_i   (clk),
            .llr_1_i (llr_1_13),
            .llr_2_i (llr_2_13),
            .sum_i   (u13),
            .select_i(select_i),
            .result_o(PE13_o));
    
    wire signed [11:0] llr_1_14 = (EX_counter==6'b111_111)?llr_1_142:
                                  (choose)?$signed(LLR00[179:168]):
                                  PE14_o;
    wire signed [11:0] llr_2_14 = (EX_counter==6'b111_111)?llr_2_142:
                                  (choose_0)?$signed(LLR04[179:168]):
                                  (choose_1)?$signed(LLR08[179:168]):
                                  (choose_2)?$signed(LLR016[179:168]):
                                  (select_index==4'd6)?PE142_o:
                                  (select_index==4'd5)?PE78_o:
                                  (select_index==4'd4)?PE46_o:
                                  PE30_o;
    wire u14 = (EX_counter==6'b111_111)?u_for_g[u_index+142]:u_for_g[u_index+14];
    PE PE14(.clk_i   (clk),
            .llr_1_i (llr_1_14),
            .llr_2_i (llr_2_14),
            .sum_i   (u14),
            .select_i(select_i),
            .result_o(PE14_o));
    
    wire signed [11:0] llr_1_15 = (EX_counter==6'b111_111)?llr_1_143:
                                  (choose)?$signed(LLR00[191:180]):
                                  PE15_o;
    wire signed [11:0] llr_2_15 = (EX_counter==6'b111_111)?llr_2_143:
                                  (choose_0)?$signed(LLR04[191:180]):
                                  (choose_1)?$signed(LLR08[191:180]):
                                  (choose_2)?$signed(LLR016[191:180]):
                                  (select_index==4'd6)?PE143_o:
                                  (select_index==4'd5)?PE79_o:
                                  (select_index==4'd4)?PE47_o:
                                  PE31_o;
    wire u15 = (EX_counter==6'b111_111)?u_for_g[u_index+143]:u_for_g[u_index+15];
    PE PE15(.clk_i   (clk),
            .llr_1_i (llr_1_15),
            .llr_2_i (llr_2_15),
            .sum_i   (u15),
            .select_i(select_i),
            .result_o(PE15_o));
    
    wire signed [11:0] llr_1_16 = (EX_counter==6'b111_111)?llr_1_144:
                                  (choose)?$signed(LLR01[11:0]):
                                  PE16_o;
    wire signed [11:0] llr_2_16 = (EX_counter==6'b111_111)?llr_2_144:
                                  (choose_0)?$signed(LLR05[11:0]):
                                  (choose_1)?$signed(LLR09[11:0]):
                                  (choose_2)?$signed(LLR017[11:0]):
                                  (select_index==4'd6)?PE144_o:
                                  (select_index==4'd5)?PE80_o:
                                  PE48_o;
    wire u16 = (EX_counter==6'b111_111)?u_for_g[u_index+144]:u_for_g[u_index+16];
    PE PE16(.clk_i   (clk),
            .llr_1_i (llr_1_16),
            .llr_2_i (llr_2_16),
            .sum_i   (u16),
            .select_i(select_i),
            .result_o(PE16_o));
    
    wire signed [11:0] llr_1_17 = (EX_counter==6'b111_111)?llr_1_145:
                                  (choose)?$signed(LLR01[23:12]):
                                  PE17_o;
    wire signed [11:0] llr_2_17 = (EX_counter==6'b111_111)?llr_2_145:
                                  (choose_0)?$signed(LLR05[23:12]):
                                  (choose_1)?$signed(LLR09[23:12]):
                                  (choose_2)?$signed(LLR017[23:12]):
                                  (select_index==4'd6)?PE145_o:
                                  (select_index==4'd5)?PE81_o:
                                  PE49_o;
    wire u17 = (EX_counter==6'b111_111)?u_for_g[u_index+145]:u_for_g[u_index+17];
    PE PE17(.clk_i   (clk),
            .llr_1_i (llr_1_17),
            .llr_2_i (llr_2_17),
            .sum_i   (u17),
            .select_i(select_i),
            .result_o(PE17_o));
    
    wire signed [11:0] llr_1_18 = (EX_counter==6'b111_111)?llr_1_146:
                                  (choose)?$signed(LLR01[35:24]):
                                  PE18_o;
    wire signed [11:0] llr_2_18 = (EX_counter==6'b111_111)?llr_2_146:
                                  (choose_0)?$signed(LLR05[35:24]):
                                  (choose_1)?$signed(LLR09[35:24]):
                                  (choose_2)?$signed(LLR017[35:24]):
                                  (select_index==4'd6)?PE146_o:
                                  (select_index==4'd5)?PE82_o:
                                  PE50_o;
    wire u18 = (EX_counter==6'b111_111)?u_for_g[u_index+146]:u_for_g[u_index+18];
    PE PE18(.clk_i   (clk),
            .llr_1_i (llr_1_18),
            .llr_2_i (llr_2_18),
            .sum_i   (u18),
            .select_i(select_i),
            .result_o(PE18_o));
    
    wire signed [11:0] llr_1_19 = (EX_counter==6'b111_111)?llr_1_147:
                                  (choose)?$signed(LLR01[47:36]):
                                  PE19_o;
    wire signed [11:0] llr_2_19 = (EX_counter==6'b111_111)?llr_2_147:
                                  (choose_0)?$signed(LLR05[47:36]):
                                  (choose_1)?$signed(LLR09[47:36]):
                                  (choose_2)?$signed(LLR017[47:36]):
                                  (select_index==4'd6)?PE147_o:
                                  (select_index==4'd5)?PE83_o:
                                  PE51_o;
    wire u19 = (EX_counter==6'b111_111)?u_for_g[u_index+147]:u_for_g[u_index+19];
    PE PE19(.clk_i   (clk),
            .llr_1_i (llr_1_19),
            .llr_2_i (llr_2_19),
            .sum_i   (u19),
            .select_i(select_i),
            .result_o(PE19_o));
    
    wire signed [11:0] llr_1_20 = (EX_counter==6'b111_111)?llr_1_148:
                                  (choose)?$signed(LLR01[59:48]):
                                  PE20_o;
    wire signed [11:0] llr_2_20 = (EX_counter==6'b111_111)?llr_2_148:
                                  (choose_0)?$signed(LLR05[59:48]):
                                  (choose_1)?$signed(LLR09[59:48]):
                                  (choose_2)?$signed(LLR017[59:48]):
                                  (select_index==4'd6)?PE148_o:
                                  (select_index==4'd5)?PE84_o:
                                  PE52_o;
    wire u20 = (EX_counter==6'b111_111)?u_for_g[u_index+148]:u_for_g[u_index+20];
    PE PE20(.clk_i   (clk),
            .llr_1_i (llr_1_20),
            .llr_2_i (llr_2_20),
            .sum_i   (u20),
            .select_i(select_i),
            .result_o(PE20_o));
    
    wire signed [11:0] llr_1_21 = (EX_counter==6'b111_111)?llr_1_149:
                                  (choose)?$signed(LLR01[71:60]):
                                  PE21_o;
    wire signed [11:0] llr_2_21 = (EX_counter==6'b111_111)?llr_2_149:
                                  (choose_0)?$signed(LLR05[71:60]):
                                  (choose_1)?$signed(LLR09[71:60]):
                                  (choose_2)?$signed(LLR017[71:60]):
                                  (select_index==4'd6)?PE149_o:
                                  (select_index==4'd5)?PE85_o:
                                  PE53_o;
    wire u21 = (EX_counter==6'b111_111)?u_for_g[u_index+149]:u_for_g[u_index+21];
    PE PE21(.clk_i   (clk),
            .llr_1_i (llr_1_21),
            .llr_2_i (llr_2_21),
            .sum_i   (u21),
            .select_i(select_i),
            .result_o(PE21_o));
    
    wire signed [11:0] llr_1_22 = (EX_counter==6'b111_111)?llr_1_150:
                                  (choose)?$signed(LLR01[83:72]):
                                  PE22_o;
    wire signed [11:0] llr_2_22 = (EX_counter==6'b111_111)?llr_2_150:
                                  (choose_0)?$signed(LLR05[83:72]):
                                  (choose_1)?$signed(LLR09[83:72]):
                                  (choose_2)?$signed(LLR017[83:72]):
                                  (select_index==4'd6)?PE150_o:
                                  (select_index==4'd5)?PE86_o:
                                  PE54_o;
    wire u22 = (EX_counter==6'b111_111)?u_for_g[u_index+150]:u_for_g[u_index+22];
    PE PE22(.clk_i   (clk),
            .llr_1_i (llr_1_22),
            .llr_2_i (llr_2_22),
            .sum_i   (u22),
            .select_i(select_i),
            .result_o(PE22_o));
    
    wire signed [11:0] llr_1_23 = (EX_counter==6'b111_111)?llr_1_151:
                                  (choose)?$signed(LLR01[95:84]):
                                  PE23_o;
    wire signed [11:0] llr_2_23 = (EX_counter==6'b111_111)?llr_2_151:
                                  (choose_0)?$signed(LLR05[95:84]):
                                  (choose_1)?$signed(LLR09[95:84]):
                                  (choose_2)?$signed(LLR017[95:84]):
                                  (select_index==4'd6)?PE151_o:
                                  (select_index==4'd5)?PE87_o:
                                  PE55_o;
    wire u23 = (EX_counter==6'b111_111)?u_for_g[u_index+151]:u_for_g[u_index+23];
    PE PE23(.clk_i   (clk),
            .llr_1_i (llr_1_23),
            .llr_2_i (llr_2_23),
            .sum_i   (u23),
            .select_i(select_i),
            .result_o(PE23_o));
    
    wire signed [11:0] llr_1_24 = (EX_counter==6'b111_111)?llr_1_152:
                                  (choose)?$signed(LLR01[107:96]):
                                  PE24_o;
    wire signed [11:0] llr_2_24 = (EX_counter==6'b111_111)?llr_2_152:
                                  (choose_0)?$signed(LLR05[107:96]):
                                  (choose_1)?$signed(LLR09[107:96]):
                                  (choose_2)?$signed(LLR017[107:96]):
                                  (select_index==4'd6)?PE152_o:
                                  (select_index==4'd5)?PE88_o:
                                  PE56_o;
    wire u24 = (EX_counter==6'b111_111)?u_for_g[u_index+152]:u_for_g[u_index+24];
    PE PE24(.clk_i   (clk),
            .llr_1_i (llr_1_24),
            .llr_2_i (llr_2_24),
            .sum_i   (u24),
            .select_i(select_i),
            .result_o(PE24_o));
    
    wire signed [11:0] llr_1_25 = (EX_counter==6'b111_111)?llr_1_153:
                                  (choose)?$signed(LLR01[119:108]):
                                  PE25_o;
    wire signed [11:0] llr_2_25 = (EX_counter==6'b111_111)?llr_2_153:
                                  (choose_0)?$signed(LLR05[119:108]):
                                  (choose_1)?$signed(LLR09[119:108]):
                                  (choose_2)?$signed(LLR017[119:108]):
                                  (select_index==4'd6)?PE153_o:
                                  (select_index==4'd5)?PE89_o:
                                  PE57_o;
    wire u25 = (EX_counter==6'b111_111)?u_for_g[u_index+153]:u_for_g[u_index+25];
    PE PE25(.clk_i   (clk),
            .llr_1_i (llr_1_25),
            .llr_2_i (llr_2_25),
            .sum_i   (u25),
            .select_i(select_i),
            .result_o(PE25_o));
    
    wire signed [11:0] llr_1_26 = (EX_counter==6'b111_111)?llr_1_154:
                                  (choose)?$signed(LLR01[131:120]):
                                  PE26_o;
    wire signed [11:0] llr_2_26 = (EX_counter==6'b111_111)?llr_2_154:
                                  (choose_0)?$signed(LLR05[131:120]):
                                  (choose_1)?$signed(LLR09[131:120]):
                                  (choose_2)?$signed(LLR017[131:120]):
                                  (select_index==4'd6)?PE154_o:
                                  (select_index==4'd5)?PE90_o:
                                  PE58_o;
    wire u26 = (EX_counter==6'b111_111)?u_for_g[u_index+154]:u_for_g[u_index+26];
    PE PE26(.clk_i   (clk),
            .llr_1_i (llr_1_26),
            .llr_2_i (llr_2_26),
            .sum_i   (u26),
            .select_i(select_i),
            .result_o(PE26_o));
    
    wire signed [11:0] llr_1_27 = (EX_counter==6'b111_111)?llr_1_155:
                                  (choose)?$signed(LLR01[143:132]):
                                  PE27_o;
    wire signed [11:0] llr_2_27 = (EX_counter==6'b111_111)?llr_2_155:
                                  (choose_0)?$signed(LLR05[143:132]):
                                  (choose_1)?$signed(LLR09[143:132]):
                                  (choose_2)?$signed(LLR017[143:132]):
                                  (select_index==4'd6)?PE155_o:
                                  (select_index==4'd5)?PE91_o:
                                  PE59_o;
    wire u27 = (EX_counter==6'b111_111)?u_for_g[u_index+155]:u_for_g[u_index+27];
    PE PE27(.clk_i   (clk),
            .llr_1_i (llr_1_27),
            .llr_2_i (llr_2_27),
            .sum_i   (u27),
            .select_i(select_i),
            .result_o(PE27_o));
    
    wire signed [11:0] llr_1_28 = (EX_counter==6'b111_111)?llr_1_156:
                                  (choose)?$signed(LLR01[155:144]):
                                  PE28_o;
    wire signed [11:0] llr_2_28 = (EX_counter==6'b111_111)?llr_2_156:
                                  (choose_0)?$signed(LLR05[155:144]):
                                  (choose_1)?$signed(LLR09[155:144]):
                                  (choose_2)?$signed(LLR017[155:144]):
                                  (select_index==4'd6)?PE156_o:
                                  (select_index==4'd5)?PE92_o:
                                  PE60_o;
    wire u28 = (EX_counter==6'b111_111)?u_for_g[u_index+156]:u_for_g[u_index+28];
    PE PE28(.clk_i   (clk),
            .llr_1_i (llr_1_28),
            .llr_2_i (llr_2_28),
            .sum_i   (u28),
            .select_i(select_i),
            .result_o(PE28_o));
    
    wire signed [11:0] llr_1_29 = (EX_counter==6'b111_111)?llr_1_157:
                                  (choose)?$signed(LLR01[167:156]):
                                  PE29_o;
    wire signed [11:0] llr_2_29 = (EX_counter==6'b111_111)?llr_2_157:
                                  (choose_0)?$signed(LLR05[167:156]):
                                  (choose_1)?$signed(LLR09[167:156]):
                                  (choose_2)?$signed(LLR017[167:156]):
                                  (select_index==4'd6)?PE157_o:
                                  (select_index==4'd5)?PE93_o:
                                  PE61_o;
    wire u29 = (EX_counter==6'b111_111)?u_for_g[u_index+157]:u_for_g[u_index+29];
    PE PE29(.clk_i   (clk),
            .llr_1_i (llr_1_29),
            .llr_2_i (llr_2_29),
            .sum_i   (u29),
            .select_i(select_i),
            .result_o(PE29_o));
    
    wire signed [11:0] llr_1_30 = (EX_counter==6'b111_111)?llr_1_158:
                                  (choose)?$signed(LLR01[179:168]):
                                  PE30_o;
    wire signed [11:0] llr_2_30 = (EX_counter==6'b111_111)?llr_2_158:
                                  (choose_0)?$signed(LLR05[179:168]):
                                  (choose_1)?$signed(LLR09[179:168]):
                                  (choose_2)?$signed(LLR017[179:168]):
                                  (select_index==4'd6)?PE158_o:
                                  (select_index==4'd5)?PE94_o:
                                  PE62_o;
    wire u30 = (EX_counter==6'b111_111)?u_for_g[u_index+158]:u_for_g[u_index+30];
    PE PE30(.clk_i   (clk),
            .llr_1_i (llr_1_30),
            .llr_2_i (llr_2_30),
            .sum_i   (u30),
            .select_i(select_i),
            .result_o(PE30_o));
    
    wire signed [11:0] llr_1_31 = (EX_counter==6'b111_111)?llr_1_159:
                                  (choose)?$signed(LLR01[191:180]):
                                  PE31_o;
    wire signed [11:0] llr_2_31 = (EX_counter==6'b111_111)?llr_2_159:
                                  (choose_0)?$signed(LLR05[191:180]):
                                  (choose_1)?$signed(LLR09[191:180]):
                                  (choose_2)?$signed(LLR017[191:180]):
                                  (select_index==4'd6)?PE159_o:
                                  (select_index==4'd5)?PE95_o:
                                  PE63_o;
    wire u31 = (EX_counter==6'b111_111)?u_for_g[u_index+159]:u_for_g[u_index+31];
    PE PE31(.clk_i   (clk),
            .llr_1_i (llr_1_31),
            .llr_2_i (llr_2_31),
            .sum_i   (u31),
            .select_i(select_i),
            .result_o(PE31_o));
    
    wire signed [11:0] llr_1_32 = (EX_counter==6'b111_111)?llr_1_160:
                                  (choose)?$signed(LLR02[11:0]):
                                  PE32_o;                                     
    wire signed [11:0] llr_2_32 = (EX_counter==6'b111_111)?llr_2_160:
                                  (choose_0)?$signed(LLR06[11:0]):
                                  (choose_1)?$signed(LLR010[11:0]):
                                  (choose_2)?$signed(LLR018[11:0]):
                                  (select_index==4'd6)?PE160_o:
                                  PE96_o;                                     
    wire u32 = (EX_counter==6'b111_111)?u_for_g[u_index+160]:u_for_g[u_index+32];
    PE PE32(.clk_i   (clk),                                           
            .llr_1_i (llr_1_32),                                      
            .llr_2_i (llr_2_32),                                      
            .sum_i   (u32),                                   
            .select_i(select_i),                                      
            .result_o(PE32_o));                                       
                                                                      
    wire signed [11:0] llr_1_33 = (EX_counter==6'b111_111)?llr_1_161:
                                  (choose)?$signed(LLR02[23:12]):
                                  PE33_o;                                     
    wire signed [11:0] llr_2_33 = (EX_counter==6'b111_111)?llr_2_161:
                                  (choose_0)?$signed(LLR06[23:12]):
                                  (choose_1)?$signed(LLR010[23:12]):
                                  (choose_2)?$signed(LLR018[23:12]):
                                  (select_index==4'd6)?PE161_o:
                                  PE97_o;                                     
    wire u33 = (EX_counter==6'b111_111)?u_for_g[u_index+161]:u_for_g[u_index+33];
    PE PE33(.clk_i   (clk),                                           
            .llr_1_i (llr_1_33),                                      
            .llr_2_i (llr_2_33),                                      
            .sum_i   (u33),                                   
            .select_i(select_i),                                      
            .result_o(PE33_o));                                       
                                                                      
    wire signed [11:0] llr_1_34 = (EX_counter==6'b111_111)?llr_1_162:
                                  (choose)?$signed(LLR02[35:24]):
                                  PE34_o;                                     
    wire signed [11:0] llr_2_34 = (EX_counter==6'b111_111)?llr_2_162:
                                  (choose_0)?$signed(LLR06[35:24]):
                                  (choose_1)?$signed(LLR010[35:24]):
                                  (choose_2)?$signed(LLR018[35:24]):
                                  (select_index==4'd6)?PE162_o:
                                  PE98_o;                                     
    wire u34 = (EX_counter==6'b111_111)?u_for_g[u_index+162]:u_for_g[u_index+34];
    PE PE34(.clk_i   (clk),                                           
            .llr_1_i (llr_1_34),                                      
            .llr_2_i (llr_2_34),                                      
            .sum_i   (u34),                                   
            .select_i(select_i),                                      
            .result_o(PE34_o));                                       
                                                                      
    wire signed [11:0] llr_1_35 = (EX_counter==6'b111_111)?llr_1_163:
                                  (choose)?$signed(LLR02[47:36]):
                                  PE35_o;                                     
    wire signed [11:0] llr_2_35 = (EX_counter==6'b111_111)?llr_2_163:
                                  (choose_0)?$signed(LLR06[47:36]):
                                  (choose_1)?$signed(LLR010[47:36]):
                                  (choose_2)?$signed(LLR018[47:36]):
                                  (select_index==4'd6)?PE163_o:
                                  PE99_o;                                     
    wire u35 = (EX_counter==6'b111_111)?u_for_g[u_index+163]:u_for_g[u_index+35];
    PE PE35(.clk_i   (clk),                                           
            .llr_1_i (llr_1_35),                                      
            .llr_2_i (llr_2_35),                                      
            .sum_i   (u35),                                   
            .select_i(select_i),                                      
            .result_o(PE35_o));                                       
                                                                      
    wire signed [11:0] llr_1_36 = (EX_counter==6'b111_111)?llr_1_164:
                                  (choose)?$signed(LLR02[59:48]):
                                  PE36_o;                                     
    wire signed [11:0] llr_2_36 = (EX_counter==6'b111_111)?llr_2_164:
                                  (choose_0)?$signed(LLR06[59:48]):
                                  (choose_1)?$signed(LLR010[59:48]):
                                  (choose_2)?$signed(LLR018[59:48]):
                                  (select_index==4'd6)?PE164_o:
                                  PE100_o;                                     
    wire u36 = (EX_counter==6'b111_111)?u_for_g[u_index+164]:u_for_g[u_index+36];
    PE PE36(.clk_i   (clk),                                           
            .llr_1_i (llr_1_36),                                      
            .llr_2_i (llr_2_36),                                      
            .sum_i   (u36),                                   
            .select_i(select_i),                                      
            .result_o(PE36_o));                                       
                                                                      
    wire signed [11:0] llr_1_37 = (EX_counter==6'b111_111)?llr_1_165:
                                  (choose)?$signed(LLR02[71:60]):
                                  PE37_o;                                     
    wire signed [11:0] llr_2_37 = (EX_counter==6'b111_111)?llr_2_165:
                                  (choose_0)?$signed(LLR06[71:60]):
                                  (choose_1)?$signed(LLR010[71:60]):
                                  (choose_2)?$signed(LLR018[71:60]):
                                  (select_index==4'd6)?PE165_o:
                                  PE101_o;                                     
    wire u37 = (EX_counter==6'b111_111)?u_for_g[u_index+165]:u_for_g[u_index+37];
    PE PE37(.clk_i   (clk),                                           
            .llr_1_i (llr_1_37),                                      
            .llr_2_i (llr_2_37),                                      
            .sum_i   (u37),                                   
            .select_i(select_i),                                      
            .result_o(PE37_o));                                       
                                                                      
    wire signed [11:0] llr_1_38 = (EX_counter==6'b111_111)?llr_1_166:
                                  (choose)?$signed(LLR02[83:72]):
                                  PE38_o;                                     
    wire signed [11:0] llr_2_38 = (EX_counter==6'b111_111)?llr_2_166:
                                  (choose_0)?$signed(LLR06[83:72]):
                                  (choose_1)?$signed(LLR010[83:72]):
                                  (choose_2)?$signed(LLR018[83:72]):
                                  (select_index==4'd6)?PE166_o:
                                  PE102_o;                                     
    wire u38 = (EX_counter==6'b111_111)?u_for_g[u_index+166]:u_for_g[u_index+38];
    PE PE38(.clk_i   (clk),                                           
            .llr_1_i (llr_1_38),                                      
            .llr_2_i (llr_2_38),                                      
            .sum_i   (u38),                                   
            .select_i(select_i),                                      
            .result_o(PE38_o));                                       
                                                                      
    wire signed [11:0] llr_1_39 = (EX_counter==6'b111_111)?llr_1_167:
                                  (choose)?$signed(LLR02[95:84]):
                                  PE39_o;                                     
    wire signed [11:0] llr_2_39 = (EX_counter==6'b111_111)?llr_2_167:
                                  (choose_0)?$signed(LLR06[95:84]):
                                  (choose_1)?$signed(LLR010[95:84]):
                                  (choose_2)?$signed(LLR018[95:84]):
                                  (select_index==4'd6)?PE167_o:
                                  PE103_o;                                     
    wire u39 = (EX_counter==6'b111_111)?u_for_g[u_index+167]:u_for_g[u_index+39];
    PE PE39(.clk_i   (clk),                                           
            .llr_1_i (llr_1_39),                                      
            .llr_2_i (llr_2_39),                                      
            .sum_i   (u39),                                   
            .select_i(select_i),                                      
            .result_o(PE39_o));                                       
                                                                      
    wire signed [11:0] llr_1_40 = (EX_counter==6'b111_111)?llr_1_168:
                                  (choose)?$signed(LLR02[107:96]):
                                  PE40_o;                                     
    wire signed [11:0] llr_2_40 = (EX_counter==6'b111_111)?llr_2_168:
                                  (choose_0)?$signed(LLR06[107:96]):
                                  (choose_1)?$signed(LLR010[107:96]):
                                  (choose_2)?$signed(LLR018[107:96]):
                                  (select_index==4'd6)?PE168_o:
                                  PE104_o;                                     
    wire u40 = (EX_counter==6'b111_111)?u_for_g[u_index+168]:u_for_g[u_index+40];
    PE PE40(.clk_i   (clk),                                           
            .llr_1_i (llr_1_40),                                      
            .llr_2_i (llr_2_40),                                      
            .sum_i   (u40),                                   
            .select_i(select_i),                                      
            .result_o(PE40_o));                                       
                                                                      
    wire signed [11:0] llr_1_41 = (EX_counter==6'b111_111)?llr_1_169:
                                  (choose)?$signed(LLR02[119:108]):
                                  PE41_o;                                     
    wire signed [11:0] llr_2_41 = (EX_counter==6'b111_111)?llr_2_169:
                                  (choose_0)?$signed(LLR06[119:108]):
                                  (choose_1)?$signed(LLR010[119:108]):
                                  (choose_2)?$signed(LLR018[119:108]):
                                  (select_index==4'd6)?PE169_o:
                                  PE105_o;                                     
    wire u41 = (EX_counter==6'b111_111)?u_for_g[u_index+169]:u_for_g[u_index+41];
    PE PE41(.clk_i   (clk),                                           
            .llr_1_i (llr_1_41),                                      
            .llr_2_i (llr_2_41),                                      
            .sum_i   (u41),                                   
            .select_i(select_i),                                      
            .result_o(PE41_o));                                       
                                                                      
    wire signed [11:0] llr_1_42 = (EX_counter==6'b111_111)?llr_1_170:
                                  (choose)?$signed(LLR02[131:120]):
                                  PE42_o;                                     
    wire signed [11:0] llr_2_42 = (EX_counter==6'b111_111)?llr_2_170:
                                  (choose_0)?$signed(LLR06[131:120]):
                                  (choose_1)?$signed(LLR010[131:120]):
                                  (choose_2)?$signed(LLR018[131:120]):
                                  (select_index==4'd6)?PE170_o:
                                  PE106_o;                                     
    wire u42 = (EX_counter==6'b111_111)?u_for_g[u_index+170]:u_for_g[u_index+42];
    PE PE42(.clk_i   (clk),                                           
            .llr_1_i (llr_1_42),                                      
            .llr_2_i (llr_2_42),                                      
            .sum_i   (u42),                                   
            .select_i(select_i),                                      
            .result_o(PE42_o));                                       
                                                                      
    wire signed [11:0] llr_1_43 = (EX_counter==6'b111_111)?llr_1_171:
                                  (choose)?$signed(LLR02[143:132]):
                                  PE43_o;                                     
    wire signed [11:0] llr_2_43 = (EX_counter==6'b111_111)?llr_2_171:
                                  (choose_0)?$signed(LLR06[143:132]):
                                  (choose_1)?$signed(LLR010[143:132]):
                                  (choose_2)?$signed(LLR018[143:132]):
                                  (select_index==4'd6)?PE171_o:
                                  PE107_o;                                     
    wire u43 = (EX_counter==6'b111_111)?u_for_g[u_index+171]:u_for_g[u_index+43];
    PE PE43(.clk_i   (clk),                                           
            .llr_1_i (llr_1_43),                                      
            .llr_2_i (llr_2_43),                                      
            .sum_i   (u43),                                   
            .select_i(select_i),                                      
            .result_o(PE43_o));                                       
                                                                      
    wire signed [11:0] llr_1_44 = (EX_counter==6'b111_111)?llr_1_172:
                                  (choose)?$signed(LLR02[155:144]):
                                  PE44_o;                                     
    wire signed [11:0] llr_2_44 = (EX_counter==6'b111_111)?llr_2_172:
                                  (choose_0)?$signed(LLR06[155:144]):
                                  (choose_1)?$signed(LLR010[155:144]):
                                  (choose_2)?$signed(LLR018[155:144]):
                                  (select_index==4'd6)?PE172_o:
                                  PE108_o;                                     
    wire u44 = (EX_counter==6'b111_111)?u_for_g[u_index+172]:u_for_g[u_index+44];
    PE PE44(.clk_i   (clk),                                           
            .llr_1_i (llr_1_44),                                      
            .llr_2_i (llr_2_44),                                      
            .sum_i   (u44),                                   
            .select_i(select_i),                                      
            .result_o(PE44_o));                                       
                                                                      
    wire signed [11:0] llr_1_45 = (EX_counter==6'b111_111)?llr_1_173:
                                  (choose)?$signed(LLR02[167:156]):
                                  PE45_o;                                     
    wire signed [11:0] llr_2_45 = (EX_counter==6'b111_111)?llr_2_173:
                                  (choose_0)?$signed(LLR06[167:156]):
                                  (choose_1)?$signed(LLR010[167:156]):
                                  (choose_2)?$signed(LLR018[167:156]):
                                  (select_index==4'd6)?PE173_o:
                                  PE109_o;                                     
    wire u45 = (EX_counter==6'b111_111)?u_for_g[u_index+173]:u_for_g[u_index+45];
    PE PE45(.clk_i   (clk),                                           
            .llr_1_i (llr_1_45),                                      
            .llr_2_i (llr_2_45),                                      
            .sum_i   (u45),                                   
            .select_i(select_i),                                      
            .result_o(PE45_o));                                       
                                                                      
    wire signed [11:0] llr_1_46 = (EX_counter==6'b111_111)?llr_1_174:
                                  (choose)?$signed(LLR02[179:168]):
                                  PE46_o;                                         
    wire signed [11:0] llr_2_46 = (EX_counter==6'b111_111)?llr_2_174:
                                  (choose_0)?$signed(LLR06[179:168]):
                                  (choose_1)?$signed(LLR010[179:168]):
                                  (choose_2)?$signed(LLR018[179:168]):
                                  (select_index==4'd6)?PE174_o:
                                  PE110_o;                                     
    wire u46 = (EX_counter==6'b111_111)?u_for_g[u_index+174]:u_for_g[u_index+46];
    PE PE46(.clk_i   (clk),                                           
            .llr_1_i (llr_1_46),                                      
            .llr_2_i (llr_2_46),                                      
            .sum_i   (u46),                                   
            .select_i(select_i),                                      
            .result_o(PE46_o));                                       
                                                                      
    wire signed [11:0] llr_1_47 = (EX_counter==6'b111_111)?llr_1_175:
                                  (choose)?$signed(LLR02[191:180]):
                                  PE47_o;                                         
    wire signed [11:0] llr_2_47 = (EX_counter==6'b111_111)?llr_2_175:
                                  (choose_0)?$signed(LLR06[191:180]):
                                  (choose_1)?$signed(LLR010[191:180]):
                                  (choose_2)?$signed(LLR018[191:180]):
                                  (select_index==4'd6)?PE175_o:
                                  PE111_o;                                     
    wire u47 = (EX_counter==6'b111_111)?u_for_g[u_index+175]:u_for_g[u_index+47];
    PE PE47(.clk_i   (clk),
            .llr_1_i (llr_1_47),
            .llr_2_i (llr_2_47),
            .sum_i   (u47),
            .select_i(select_i),
            .result_o(PE47_o));
    
    wire signed [11:0] llr_1_48 = (EX_counter==6'b111_111)?llr_1_176:
                                  (choose)?$signed(LLR03[11:0]):
                                  PE48_o;                                     
    wire signed [11:0] llr_2_48 = (EX_counter==6'b111_111)?llr_2_176:
                                  (choose_0)?$signed(LLR07[11:0]):
                                  (choose_1)?$signed(LLR011[11:0]):
                                  (choose_2)?$signed(LLR019[11:0]):
                                  (select_index==4'd6)?PE176_o:
                                  PE112_o;                                     
    wire u48 = (EX_counter==6'b111_111)?u_for_g[u_index+176]:u_for_g[u_index+48];
    PE PE48(.clk_i   (clk),                                           
            .llr_1_i (llr_1_48),                                      
            .llr_2_i (llr_2_48),                                      
            .sum_i   (u48),                                   
            .select_i(select_i),                                      
            .result_o(PE48_o));                                       
                                                                      
    wire signed [11:0] llr_1_49 = (EX_counter==6'b111_111)?llr_1_177:
                                  (choose)?$signed(LLR03[23:12]):
                                  PE49_o;                                         
    wire signed [11:0] llr_2_49 = (EX_counter==6'b111_111)?llr_2_177:
                                  (choose_0)?$signed(LLR07[23:12]):
                                  (choose_1)?$signed(LLR011[23:12]):
                                  (choose_2)?$signed(LLR019[23:12]):
                                  (select_index==4'd6)?PE177_o:
                                  PE113_o;                                     
    wire u49 = (EX_counter==6'b111_111)?u_for_g[u_index+177]:u_for_g[u_index+49];
    PE PE49(.clk_i   (clk),                                           
            .llr_1_i (llr_1_49),                                      
            .llr_2_i (llr_2_49),                                      
            .sum_i   (u49),                                   
            .select_i(select_i),                                      
            .result_o(PE49_o));                                       
                                                                      
    wire signed [11:0] llr_1_50 = (EX_counter==6'b111_111)?llr_1_178:
                                  (choose)?$signed(LLR03[35:24]):
                                  PE50_o;                                         
    wire signed [11:0] llr_2_50 = (EX_counter==6'b111_111)?llr_2_178:
                                  (choose_0)?$signed(LLR07[35:24]):
                                  (choose_1)?$signed(LLR011[35:24]):
                                  (choose_2)?$signed(LLR019[35:24]):
                                  (select_index==4'd6)?PE178_o:
                                  PE114_o;                                     
    wire u50 = (EX_counter==6'b111_111)?u_for_g[u_index+178]:u_for_g[u_index+50];
    PE PE50(.clk_i   (clk),                                           
            .llr_1_i (llr_1_50),                                      
            .llr_2_i (llr_2_50),                                      
            .sum_i   (u50),                                   
            .select_i(select_i),                                      
            .result_o(PE50_o));                                       
                                                                      
    wire signed [11:0] llr_1_51 = (EX_counter==6'b111_111)?llr_1_179:
                                  (choose)?$signed(LLR03[47:36]):
                                  PE51_o;                                         
    wire signed [11:0] llr_2_51 = (EX_counter==6'b111_111)?llr_2_179:
                                  (choose_0)?$signed(LLR07[47:36]):
                                  (choose_1)?$signed(LLR011[47:36]):
                                  (choose_2)?$signed(LLR019[47:36]):
                                  (select_index==4'd6)?PE179_o:
                                  PE115_o;                                     
    wire u51 = (EX_counter==6'b111_111)?u_for_g[u_index+179]:u_for_g[u_index+51];
    PE PE51(.clk_i   (clk),                                           
            .llr_1_i (llr_1_51),                                      
            .llr_2_i (llr_2_51),                                      
            .sum_i   (u51),                                   
            .select_i(select_i),                                      
            .result_o(PE51_o));                                       
                                                                      
    wire signed [11:0] llr_1_52 = (EX_counter==6'b111_111)?llr_1_180:
                                  (choose)?$signed(LLR03[59:48]):
                                  PE52_o;                                         
    wire signed [11:0] llr_2_52 = (EX_counter==6'b111_111)?llr_2_180:
                                  (choose_0)?$signed(LLR07[59:48]):
                                  (choose_1)?$signed(LLR011[59:48]):
                                  (choose_2)?$signed(LLR019[59:48]):
                                  (select_index==4'd6)?PE180_o:
                                  PE116_o;                                     
    wire u52 = (EX_counter==6'b111_111)?u_for_g[u_index+180]:u_for_g[u_index+52];
    PE PE52(.clk_i   (clk),                                           
            .llr_1_i (llr_1_52),                                      
            .llr_2_i (llr_2_52),                                      
            .sum_i   (u52),                                   
            .select_i(select_i),                                      
            .result_o(PE52_o));                                       
                                                                      
    wire signed [11:0] llr_1_53 = (EX_counter==6'b111_111)?llr_1_181:
                                  (choose)?$signed(LLR03[71:60]):
                                  PE53_o;                                         
    wire signed [11:0] llr_2_53 = (EX_counter==6'b111_111)?llr_2_181:
                                  (choose_0)?$signed(LLR07[71:60]):
                                  (choose_1)?$signed(LLR011[71:60]):
                                  (choose_2)?$signed(LLR019[71:60]):
                                  (select_index==4'd6)?PE181_o:
                                  PE117_o;                                     
    wire u53 = (EX_counter==6'b111_111)?u_for_g[u_index+181]:u_for_g[u_index+53];
    PE PE53(.clk_i   (clk),                                           
            .llr_1_i (llr_1_53),                                      
            .llr_2_i (llr_2_53),                                      
            .sum_i   (u53),                                   
            .select_i(select_i),                                      
            .result_o(PE53_o));                                       
                                                                      
    wire signed [11:0] llr_1_54 = (EX_counter==6'b111_111)?llr_1_182:
                                  (choose)?$signed(LLR03[83:72]):
                                  PE54_o;                                         
    wire signed [11:0] llr_2_54 = (EX_counter==6'b111_111)?llr_2_182:
                                  (choose_0)?$signed(LLR07[83:72]):
                                  (choose_1)?$signed(LLR011[83:72]):
                                  (choose_2)?$signed(LLR019[83:72]):
                                  (select_index==4'd6)?PE182_o:
                                  PE118_o;                                     
    wire u54 = (EX_counter==6'b111_111)?u_for_g[u_index+182]:u_for_g[u_index+54];
    PE PE54(.clk_i   (clk),                                           
            .llr_1_i (llr_1_54),                                      
            .llr_2_i (llr_2_54),                                      
            .sum_i   (u54),                                   
            .select_i(select_i),                                      
            .result_o(PE54_o));                                       
                                                                      
    wire signed [11:0] llr_1_55 = (EX_counter==6'b111_111)?llr_1_183:
                                  (choose)?$signed(LLR03[95:84]):
                                  PE55_o;                                         
    wire signed [11:0] llr_2_55 = (EX_counter==6'b111_111)?llr_2_183:
                                  (choose_0)?$signed(LLR07[95:84]):
                                  (choose_1)?$signed(LLR011[95:84]):
                                  (choose_2)?$signed(LLR019[95:84]):
                                  (select_index==4'd6)?PE183_o:
                                  PE119_o;                                     
    wire u55 = (EX_counter==6'b111_111)?u_for_g[u_index+183]:u_for_g[u_index+55];
    PE PE55(.clk_i   (clk),                                           
            .llr_1_i (llr_1_55),                                      
            .llr_2_i (llr_2_55),                                      
            .sum_i   (u55),                                   
            .select_i(select_i),                                      
            .result_o(PE55_o));                                       
                                                                      
    wire signed [11:0] llr_1_56 = (EX_counter==6'b111_111)?llr_1_184:
                                  (choose)?$signed(LLR03[107:96]):
                                  PE56_o;                                         
    wire signed [11:0] llr_2_56 = (EX_counter==6'b111_111)?llr_2_184:
                                  (choose_0)?$signed(LLR07[107:96]):
                                  (choose_1)?$signed(LLR011[107:96]):
                                  (choose_2)?$signed(LLR019[107:96]):
                                  (select_index==4'd6)?PE184_o:
                                  PE120_o;                                     
    wire u56 = (EX_counter==6'b111_111)?u_for_g[u_index+184]:u_for_g[u_index+56];
    PE PE56(.clk_i   (clk),                                           
            .llr_1_i (llr_1_56),                                      
            .llr_2_i (llr_2_56),                                      
            .sum_i   (u56),                                   
            .select_i(select_i),                                      
            .result_o(PE56_o));                                       
                                                                      
    wire signed [11:0] llr_1_57 = (EX_counter==6'b111_111)?llr_1_185:
                                  (choose)?$signed(LLR03[119:108]):
                                  PE57_o;                                         
    wire signed [11:0] llr_2_57 = (EX_counter==6'b111_111)?llr_2_185:
                                  (choose_0)?$signed(LLR07[119:108]):
                                  (choose_1)?$signed(LLR011[119:108]):
                                  (choose_2)?$signed(LLR019[119:108]):
                                  (select_index==4'd6)?PE185_o:
                                  PE121_o;                                     
    wire u57 = (EX_counter==6'b111_111)?u_for_g[u_index+185]:u_for_g[u_index+57];
    PE PE57(.clk_i   (clk),                                           
            .llr_1_i (llr_1_57),                                      
            .llr_2_i (llr_2_57),                                      
            .sum_i   (u57),                                   
            .select_i(select_i),                                      
            .result_o(PE57_o));                                       
                                                                      
    wire signed [11:0] llr_1_58 = (EX_counter==6'b111_111)?llr_1_186:
                                  (choose)?$signed(LLR03[131:120]):
                                  PE58_o;                                         
    wire signed [11:0] llr_2_58 = (EX_counter==6'b111_111)?llr_2_186:
                                  (choose_0)?$signed(LLR07[131:120]):
                                  (choose_1)?$signed(LLR011[131:120]):
                                  (choose_2)?$signed(LLR019[131:120]):
                                  (select_index==4'd6)?PE186_o:
                                  PE122_o;                                     
    wire u58 = (EX_counter==6'b111_111)?u_for_g[u_index+186]:u_for_g[u_index+58];
    PE PE58(.clk_i   (clk),                                           
            .llr_1_i (llr_1_58),                                      
            .llr_2_i (llr_2_58),                                      
            .sum_i   (u58),                                   
            .select_i(select_i),                                      
            .result_o(PE58_o));                                       
                                                                      
    wire signed [11:0] llr_1_59 = (EX_counter==6'b111_111)?llr_1_187:
                                  (choose)?$signed(LLR03[143:132]):
                                  PE59_o;                                         
    wire signed [11:0] llr_2_59 = (EX_counter==6'b111_111)?llr_2_187:
                                  (choose_0)?$signed(LLR07[143:132]):
                                  (choose_1)?$signed(LLR011[143:132]):
                                  (choose_2)?$signed(LLR019[143:132]):
                                  (select_index==4'd6)?PE187_o:
                                  PE123_o;                                     
    wire u59 = (EX_counter==6'b111_111)?u_for_g[u_index+187]:u_for_g[u_index+59];
    PE PE59(.clk_i   (clk),                                           
            .llr_1_i (llr_1_59),                                      
            .llr_2_i (llr_2_59),                                      
            .sum_i   (u59),                                   
            .select_i(select_i),                                      
            .result_o(PE59_o));                                       
                                                                      
    wire signed [11:0] llr_1_60 = (EX_counter==6'b111_111)?llr_1_188:
                                  (choose)?$signed(LLR03[155:144]):
                                  PE60_o;                                         
    wire signed [11:0] llr_2_60 = (EX_counter==6'b111_111)?llr_2_188:
                                  (choose_0)?$signed(LLR07[155:144]):
                                  (choose_1)?$signed(LLR011[155:144]):
                                  (choose_2)?$signed(LLR019[155:144]):
                                  (select_index==4'd6)?PE188_o:
                                  PE124_o;                                     
    wire u60 = (EX_counter==6'b111_111)?u_for_g[u_index+188]:u_for_g[u_index+60];
    PE PE60(.clk_i   (clk),                                           
            .llr_1_i (llr_1_60),                                      
            .llr_2_i (llr_2_60),                                      
            .sum_i   (u60),                                   
            .select_i(select_i),                                      
            .result_o(PE60_o));                                       
                                                                      
    wire signed [11:0] llr_1_61 = (EX_counter==6'b111_111)?llr_1_189:
                                  (choose)?$signed(LLR03[167:156]):
                                  PE61_o;                                         
    wire signed [11:0] llr_2_61 = (EX_counter==6'b111_111)?llr_2_189:
                                  (choose_0)?$signed(LLR07[167:156]):
                                  (choose_1)?$signed(LLR011[167:156]):
                                  (choose_2)?$signed(LLR019[167:156]):
                                  (select_index==4'd6)?PE189_o:
                                  PE125_o;                                     
    wire u61 = (EX_counter==6'b111_111)?u_for_g[u_index+189]:u_for_g[u_index+61];
    PE PE61(.clk_i   (clk),                                           
            .llr_1_i (llr_1_61),                                      
            .llr_2_i (llr_2_61),                                      
            .sum_i   (u61),                                   
            .select_i(select_i),                                      
            .result_o(PE61_o));                                       
                                                                      
    wire signed [11:0] llr_1_62 = (EX_counter==6'b111_111)?llr_1_190:
                                  (choose)?$signed(LLR03[179:168]):
                                  PE62_o;                                         
    wire signed [11:0] llr_2_62 = (EX_counter==6'b111_111)?llr_2_190:
                                  (choose_0)?$signed(LLR07[179:168]):
                                  (choose_1)?$signed(LLR011[179:168]):
                                  (choose_2)?$signed(LLR019[179:168]):
                                  (select_index==4'd6)?PE190_o:
                                  PE126_o;                                     
    wire u62 = (EX_counter==6'b111_111)?u_for_g[u_index+190]:u_for_g[u_index+62];
    PE PE62(.clk_i   (clk),                                           
            .llr_1_i (llr_1_62),                                      
            .llr_2_i (llr_2_62),                                      
            .sum_i   (u62),                                   
            .select_i(select_i),                                      
            .result_o(PE62_o));                                       
                                                                      
    wire signed [11:0] llr_1_63 = (EX_counter==6'b111_111)?llr_1_191:
                                  (choose)?$signed(LLR03[191:180]):
                                  PE63_o;                                         
    wire signed [11:0] llr_2_63 = (EX_counter==6'b111_111)?llr_2_191:
                                  (choose_0)?$signed(LLR07[191:180]):
                                  (choose_1)?$signed(LLR011[191:180]):
                                  (choose_2)?$signed(LLR019[191:180]):
                                  (select_index==4'd6)?PE191_o:
                                  PE127_o;                                     
    wire u63 = (EX_counter==6'b111_111)?u_for_g[u_index+191]:u_for_g[u_index+63];
    PE PE63(.clk_i   (clk),
            .llr_1_i (llr_1_63),
            .llr_2_i (llr_2_63),
            .sum_i   (u63),
            .select_i(select_i),
            .result_o(PE63_o));
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    wire signed [11:0] llr_1_64 = (EX_counter==6'b111_111)?llr_1_192:
                                  (choose)?$signed(LLR04[11:0]):
                                  PE64_o;                                         
    wire signed [11:0] llr_2_64 = (EX_counter==6'b111_111)?llr_2_192:
                                  (choose_1)?$signed(LLR012[11:0]):
                                  (choose_2)?$signed(LLR020[11:0]):
                                  PE192_o;
    wire u64 = (EX_counter==6'b111_111)?u_for_g[u_index+192]:u_for_g[u_index+64];
    PE PE64(.clk_i   (clk),
            .llr_1_i (llr_1_64),
            .llr_2_i (llr_2_64),
            .sum_i   (u64),
            .select_i(select_i),
            .result_o(PE64_o));
    
    wire signed [11:0] llr_1_65 = (EX_counter==6'b111_111)?llr_1_193:
                                  (choose)?$signed(LLR04[23:12]):
                                  PE65_o;                                         
    wire signed [11:0] llr_2_65 = (EX_counter==6'b111_111)?llr_2_193:
                                  (choose_1)?$signed(LLR012[23:12]):
                                  (choose_2)?$signed(LLR020[23:12]):
                                  PE193_o;
    wire u65 = (EX_counter==6'b111_111)?u_for_g[u_index+193]:u_for_g[u_index+65];
    PE PE65(.clk_i   (clk),
            .llr_1_i (llr_1_65),
            .llr_2_i (llr_2_65),
            .sum_i   (u65),
            .select_i(select_i),
            .result_o(PE65_o));
    
    wire signed [11:0] llr_1_66 = (EX_counter==6'b111_111)?llr_1_194:
                                  (choose)?$signed(LLR04[35:24]):
                                  PE66_o;                                         
    wire signed [11:0] llr_2_66 = (EX_counter==6'b111_111)?llr_2_194:
                                  (choose_1)?$signed(LLR012[35:24]):
                                  (choose_2)?$signed(LLR020[35:24]):
                                  PE194_o;
    wire u66 = (EX_counter==6'b111_111)?u_for_g[u_index+194]:u_for_g[u_index+66];
    PE PE66(.clk_i   (clk),
            .llr_1_i (llr_1_66),
            .llr_2_i (llr_2_66),
            .sum_i   (u66),
            .select_i(select_i),
            .result_o(PE66_o));
    
    wire signed [11:0] llr_1_67 = (EX_counter==6'b111_111)?llr_1_195:
                                  (choose)?$signed(LLR04[47:36]):
                                  PE67_o;                                         
    wire signed [11:0] llr_2_67 = (EX_counter==6'b111_111)?llr_2_195:
                                  (choose_1)?$signed(LLR012[47:36]):
                                  (choose_2)?$signed(LLR020[47:36]):
                                  PE195_o;
    wire u67 = (EX_counter==6'b111_111)?u_for_g[u_index+195]:u_for_g[u_index+67];
    PE PE67(.clk_i   (clk),
            .llr_1_i (llr_1_67),
            .llr_2_i (llr_2_67),
            .sum_i   (u67),
            .select_i(select_i),
            .result_o(PE67_o));
    
    wire signed [11:0] llr_1_68 = (EX_counter==6'b111_111)?llr_1_196:
                                  (choose)?$signed(LLR04[59:48]):
                                  PE68_o;                                         
    wire signed [11:0] llr_2_68 = (EX_counter==6'b111_111)?llr_2_196:
                                  (choose_1)?$signed(LLR012[59:48]):
                                  (choose_2)?$signed(LLR020[59:48]):
                                  PE196_o;
    wire u68 = (EX_counter==6'b111_111)?u_for_g[u_index+196]:u_for_g[u_index+68];
    PE PE68(.clk_i   (clk),
            .llr_1_i (llr_1_68),
            .llr_2_i (llr_2_68),
            .sum_i   (u68),
            .select_i(select_i),
            .result_o(PE68_o));
    
    wire signed [11:0] llr_1_69 = (EX_counter==6'b111_111)?llr_1_197:
                                  (choose)?$signed(LLR04[71:60]):
                                  PE69_o;                                         
    wire signed [11:0] llr_2_69 = (EX_counter==6'b111_111)?llr_2_197:
                                  (choose_1)?$signed(LLR012[71:60]):
                                  (choose_2)?$signed(LLR020[71:60]):
                                  PE197_o;
    wire u69 = (EX_counter==6'b111_111)?u_for_g[u_index+197]:u_for_g[u_index+69];
    PE PE69(.clk_i   (clk),
            .llr_1_i (llr_1_69),
            .llr_2_i (llr_2_69),
            .sum_i   (u69),
            .select_i(select_i),
            .result_o(PE69_o));
    
    wire signed [11:0] llr_1_70 = (EX_counter==6'b111_111)?llr_1_198:
                                  (choose)?$signed(LLR04[83:72]):
                                  PE70_o;                                         
    wire signed [11:0] llr_2_70 = (EX_counter==6'b111_111)?llr_2_198:
                                  (choose_1)?$signed(LLR012[83:72]):
                                  (choose_2)?$signed(LLR020[83:72]):
                                  PE198_o;
    wire u70 = (EX_counter==6'b111_111)?u_for_g[u_index+198]:u_for_g[u_index+70];
    PE PE70(.clk_i   (clk),
            .llr_1_i (llr_1_70),
            .llr_2_i (llr_2_70),
            .sum_i   (u70),
            .select_i(select_i),
            .result_o(PE70_o));
    
    wire signed [11:0] llr_1_71 = (EX_counter==6'b111_111)?llr_1_199:
                                  (choose)?$signed(LLR04[95:84]):
                                  PE71_o;                                         
    wire signed [11:0] llr_2_71 = (EX_counter==6'b111_111)?llr_2_199:
                                  (choose_1)?$signed(LLR012[95:84]):
                                  (choose_2)?$signed(LLR020[95:84]):
                                  PE199_o;
    wire u71 = (EX_counter==6'b111_111)?u_for_g[u_index+199]:u_for_g[u_index+71];
    PE PE71(.clk_i   (clk),
            .llr_1_i (llr_1_71),
            .llr_2_i (llr_2_71),
            .sum_i   (u71),
            .select_i(select_i),
            .result_o(PE71_o));
    
    wire signed [11:0] llr_1_72 = (EX_counter==6'b111_111)?llr_1_200:
                                  (choose)?$signed(LLR04[107:96]):
                                  PE72_o;                                         
    wire signed [11:0] llr_2_72 = (EX_counter==6'b111_111)?llr_2_200:
                                  (choose_1)?$signed(LLR012[107:96]):
                                  (choose_2)?$signed(LLR020[107:96]):
                                  PE200_o;
    wire u72 = (EX_counter==6'b111_111)?u_for_g[u_index+200]:u_for_g[u_index+72];
    PE PE72(.clk_i   (clk),
            .llr_1_i (llr_1_72),
            .llr_2_i (llr_2_72),
            .sum_i   (u72),
            .select_i(select_i),
            .result_o(PE72_o));
    
    wire signed [11:0] llr_1_73 = (EX_counter==6'b111_111)?llr_1_201:
                                  (choose)?$signed(LLR04[119:108]):
                                  PE73_o;                                         
    wire signed [11:0] llr_2_73 = (EX_counter==6'b111_111)?llr_2_201:
                                  (choose_1)?$signed(LLR012[119:108]):
                                  (choose_2)?$signed(LLR020[119:108]):
                                  PE201_o;
    wire u73 = (EX_counter==6'b111_111)?u_for_g[u_index+201]:u_for_g[u_index+73];
    PE PE73(.clk_i   (clk),
            .llr_1_i (llr_1_73),
            .llr_2_i (llr_2_73),
            .sum_i   (u73),
            .select_i(select_i),
            .result_o(PE73_o));
    
    wire signed [11:0] llr_1_74 = (EX_counter==6'b111_111)?llr_1_202:
                                  (choose)?$signed(LLR04[131:120]):
                                  PE74_o;                                         
    wire signed [11:0] llr_2_74 = (EX_counter==6'b111_111)?llr_2_202:
                                  (choose_1)?$signed(LLR012[131:120]):
                                  (choose_2)?$signed(LLR020[131:120]):
                                  PE202_o;
    wire u74 = (EX_counter==6'b111_111)?u_for_g[u_index+202]:u_for_g[u_index+74];
    PE PE74(.clk_i   (clk),
            .llr_1_i (llr_1_74),
            .llr_2_i (llr_2_74),
            .sum_i   (u74),
            .select_i(select_i),
            .result_o(PE74_o));
    
    wire signed [11:0] llr_1_75 = (EX_counter==6'b111_111)?llr_1_203:
                                  (choose)?$signed(LLR04[143:132]):
                                  PE75_o;                                         
    wire signed [11:0] llr_2_75 = (EX_counter==6'b111_111)?llr_2_203:
                                  (choose_1)?$signed(LLR012[143:132]):
                                  (choose_2)?$signed(LLR020[143:132]):
                                  PE203_o;
    wire u75 = (EX_counter==6'b111_111)?u_for_g[u_index+203]:u_for_g[u_index+75];
    PE PE75(.clk_i   (clk),
            .llr_1_i (llr_1_75),
            .llr_2_i (llr_2_75),
            .sum_i   (u75),
            .select_i(select_i),
            .result_o(PE75_o));
    
    wire signed [11:0] llr_1_76 = (EX_counter==6'b111_111)?llr_1_204:
                                  (choose)?$signed(LLR04[155:144]):
                                  PE76_o;                                         
    wire signed [11:0] llr_2_76 = (EX_counter==6'b111_111)?llr_2_204:
                                  (choose_1)?$signed(LLR012[155:144]):
                                  (choose_2)?$signed(LLR020[155:144]):
                                  PE204_o;
    wire u76 = (EX_counter==6'b111_111)?u_for_g[u_index+204]:u_for_g[u_index+76];
    PE PE76(.clk_i   (clk),
            .llr_1_i (llr_1_76),
            .llr_2_i (llr_2_76),
            .sum_i   (u76),
            .select_i(select_i),
            .result_o(PE76_o));
    
    wire signed [11:0] llr_1_77 = (EX_counter==6'b111_111)?llr_1_205:
                                  (choose)?$signed(LLR04[167:156]):
                                  PE77_o;                                         
    wire signed [11:0] llr_2_77 = (EX_counter==6'b111_111)?llr_2_205:
                                  (choose_1)?$signed(LLR012[167:156]):
                                  (choose_2)?$signed(LLR020[167:156]):
                                  PE205_o;
    wire u77 = (EX_counter==6'b111_111)?u_for_g[u_index+205]:u_for_g[u_index+77];
    PE PE77(.clk_i   (clk),
            .llr_1_i (llr_1_77),
            .llr_2_i (llr_2_77),
            .sum_i   (u77),
            .select_i(select_i),
            .result_o(PE77_o));
    
    wire signed [11:0] llr_1_78 = (EX_counter==6'b111_111)?llr_1_206:
                                  (choose)?$signed(LLR04[179:168]):
                                  PE78_o;                                         
    wire signed [11:0] llr_2_78 = (EX_counter==6'b111_111)?llr_2_206:
                                  (choose_1)?$signed(LLR012[179:168]):
                                  (choose_2)?$signed(LLR020[179:168]):
                                  PE206_o;
    wire u78 = (EX_counter==6'b111_111)?u_for_g[u_index+206]:u_for_g[u_index+78];
    PE PE78(.clk_i   (clk),
            .llr_1_i (llr_1_78),
            .llr_2_i (llr_2_78),
            .sum_i   (u78),
            .select_i(select_i),
            .result_o(PE78_o));
    
    wire signed [11:0] llr_1_79 = (EX_counter==6'b111_111)?llr_1_207:
                                  (choose)?$signed(LLR04[191:180]):
                                  PE79_o;                                         
    wire signed [11:0] llr_2_79 = (EX_counter==6'b111_111)?llr_2_207:
                                  (choose_1)?$signed(LLR012[191:180]):
                                  (choose_2)?$signed(LLR020[191:180]):
                                  PE207_o;
    wire u79 = (EX_counter==6'b111_111)?u_for_g[u_index+207]:u_for_g[u_index+79];
    PE PE79(.clk_i   (clk),
            .llr_1_i (llr_1_79),
            .llr_2_i (llr_2_79),
            .sum_i   (u79),
            .select_i(select_i),
            .result_o(PE79_o));
    
    wire signed [11:0] llr_1_80 = (EX_counter==6'b111_111)?llr_1_208:
                                  (choose)?$signed(LLR05[11:0]):
                                  PE80_o;                                         
    wire signed [11:0] llr_2_80 = (EX_counter==6'b111_111)?llr_2_208:
                                  (choose_1)?$signed(LLR013[11:0]):
                                  (choose_2)?$signed(LLR021[11:0]):
                                  PE208_o;
    wire u80 = (EX_counter==6'b111_111)?u_for_g[u_index+208]:u_for_g[u_index+80];
    PE PE80(.clk_i   (clk),
            .llr_1_i (llr_1_80),
            .llr_2_i (llr_2_80),
            .sum_i   (u80),
            .select_i(select_i),
            .result_o(PE80_o));
    
    wire signed [11:0] llr_1_81 = (EX_counter==6'b111_111)?llr_1_209:
                                  (choose)?$signed(LLR05[23:12]):
                                  PE81_o;                                         
    wire signed [11:0] llr_2_81 = (EX_counter==6'b111_111)?llr_2_209:
                                  (choose_1)?$signed(LLR013[23:12]):
                                  (choose_2)?$signed(LLR021[23:12]):
                                  PE209_o;
    wire u81 = (EX_counter==6'b111_111)?u_for_g[u_index+209]:u_for_g[u_index+81];
    PE PE81(.clk_i   (clk),
            .llr_1_i (llr_1_81),
            .llr_2_i (llr_2_81),
            .sum_i   (u81),
            .select_i(select_i),
            .result_o(PE81_o));
    
    wire signed [11:0] llr_1_82 = (EX_counter==6'b111_111)?llr_1_210:
                                  (choose)?$signed(LLR05[35:24]):
                                  PE82_o;                                         
    wire signed [11:0] llr_2_82 = (EX_counter==6'b111_111)?llr_2_210:
                                  (choose_1)?$signed(LLR013[35:24]):
                                  (choose_2)?$signed(LLR021[35:24]):
                                  PE210_o;
    wire u82 = (EX_counter==6'b111_111)?u_for_g[u_index+210]:u_for_g[u_index+82];
    PE PE82(.clk_i   (clk),
            .llr_1_i (llr_1_82),
            .llr_2_i (llr_2_82),
            .sum_i   (u82),
            .select_i(select_i),
            .result_o(PE82_o));
    
    wire signed [11:0] llr_1_83 = (EX_counter==6'b111_111)?llr_1_211:
                                  (choose)?$signed(LLR05[47:36]):
                                  PE83_o;                                         
    wire signed [11:0] llr_2_83 = (EX_counter==6'b111_111)?llr_2_211:
                                  (choose_1)?$signed(LLR013[47:36]):
                                  (choose_2)?$signed(LLR021[47:36]):
                                  PE211_o;
    wire u83 = (EX_counter==6'b111_111)?u_for_g[u_index+211]:u_for_g[u_index+83];
    PE PE83(.clk_i   (clk),
            .llr_1_i (llr_1_83),
            .llr_2_i (llr_2_83),
            .sum_i   (u83),
            .select_i(select_i),
            .result_o(PE83_o));
    
    wire signed [11:0] llr_1_84 = (EX_counter==6'b111_111)?llr_1_212:
                                  (choose)?$signed(LLR05[59:48]):
                                  PE84_o;                                         
    wire signed [11:0] llr_2_84 = (EX_counter==6'b111_111)?llr_2_212:
                                  (choose_1)?$signed(LLR013[59:48]):
                                  (choose_2)?$signed(LLR021[59:48]):
                                  PE212_o;
    wire u84 = (EX_counter==6'b111_111)?u_for_g[u_index+212]:u_for_g[u_index+84];
    PE PE84(.clk_i   (clk),
            .llr_1_i (llr_1_84),
            .llr_2_i (llr_2_84),
            .sum_i   (u84),
            .select_i(select_i),
            .result_o(PE84_o));
    
    wire signed [11:0] llr_1_85 = (EX_counter==6'b111_111)?llr_1_213:
                                  (choose)?$signed(LLR05[71:60]):
                                  PE85_o;                                         
    wire signed [11:0] llr_2_85 = (EX_counter==6'b111_111)?llr_2_213:
                                  (choose_1)?$signed(LLR013[71:60]):
                                  (choose_2)?$signed(LLR021[71:60]):
                                  PE213_o;
    wire u85 = (EX_counter==6'b111_111)?u_for_g[u_index+213]:u_for_g[u_index+85];
    PE PE85(.clk_i   (clk),
            .llr_1_i (llr_1_85),
            .llr_2_i (llr_2_85),
            .sum_i   (u85),
            .select_i(select_i),
            .result_o(PE85_o));
    
    wire signed [11:0] llr_1_86 = (EX_counter==6'b111_111)?llr_1_214:
                                  (choose)?$signed(LLR05[83:72]):
                                  PE86_o;                                         
    wire signed [11:0] llr_2_86 = (EX_counter==6'b111_111)?llr_2_214:
                                  (choose_1)?$signed(LLR013[83:72]):
                                  (choose_2)?$signed(LLR021[83:72]):
                                  PE214_o;
    wire u86 = (EX_counter==6'b111_111)?u_for_g[u_index+214]:u_for_g[u_index+86];
    PE PE86(.clk_i   (clk),
            .llr_1_i (llr_1_86),
            .llr_2_i (llr_2_86),
            .sum_i   (u86),
            .select_i(select_i),
            .result_o(PE86_o));
    
    wire signed [11:0] llr_1_87 = (EX_counter==6'b111_111)?llr_1_215:
                                  (choose)?$signed(LLR05[95:84]):
                                  PE87_o;                                         
    wire signed [11:0] llr_2_87 = (EX_counter==6'b111_111)?llr_2_215:
                                  (choose_1)?$signed(LLR013[95:84]):
                                  (choose_2)?$signed(LLR021[95:84]):
                                  PE215_o;
    wire u87 = (EX_counter==6'b111_111)?u_for_g[u_index+215]:u_for_g[u_index+87];
    PE PE87(.clk_i   (clk),
            .llr_1_i (llr_1_87),
            .llr_2_i (llr_2_87),
            .sum_i   (u87),
            .select_i(select_i),
            .result_o(PE87_o));
    
    wire signed [11:0] llr_1_88 = (EX_counter==6'b111_111)?llr_1_216:
                                  (choose)?$signed(LLR05[107:96]):
                                  PE88_o;                                         
    wire signed [11:0] llr_2_88 = (EX_counter==6'b111_111)?llr_2_216:
                                  (choose_1)?$signed(LLR013[107:96]):
                                  (choose_2)?$signed(LLR021[107:96]):
                                  PE216_o;
    wire u88 = (EX_counter==6'b111_111)?u_for_g[u_index+216]:u_for_g[u_index+88];
    PE PE88(.clk_i   (clk),
            .llr_1_i (llr_1_88),
            .llr_2_i (llr_2_88),
            .sum_i   (u88),
            .select_i(select_i),
            .result_o(PE88_o));
    
    wire signed [11:0] llr_1_89 = (EX_counter==6'b111_111)?llr_1_217:
                                  (choose)?$signed(LLR05[119:108]):
                                  PE89_o;                                         
    wire signed [11:0] llr_2_89 = (EX_counter==6'b111_111)?llr_2_217:
                                  (choose_1)?$signed(LLR013[119:108]):
                                  (choose_2)?$signed(LLR021[119:108]):
                                  PE217_o;
    wire u89 = (EX_counter==6'b111_111)?u_for_g[u_index+217]:u_for_g[u_index+89];
    PE PE89(.clk_i   (clk),
            .llr_1_i (llr_1_89),
            .llr_2_i (llr_2_89),
            .sum_i   (u89),
            .select_i(select_i),
            .result_o(PE89_o));
    
    wire signed [11:0] llr_1_90 = (EX_counter==6'b111_111)?llr_1_218:
                                  (choose)?$signed(LLR05[131:120]):
                                  PE90_o;                                         
    wire signed [11:0] llr_2_90 = (EX_counter==6'b111_111)?llr_2_218:
                                  (choose_1)?$signed(LLR013[131:120]):
                                  (choose_2)?$signed(LLR021[131:120]):
                                  PE218_o;
    wire u90 = (EX_counter==6'b111_111)?u_for_g[u_index+218]:u_for_g[u_index+90];
    PE PE90(.clk_i   (clk),
            .llr_1_i (llr_1_90),
            .llr_2_i (llr_2_90),
            .sum_i   (u90),
            .select_i(select_i),
            .result_o(PE90_o));
    
    wire signed [11:0] llr_1_91 = (EX_counter==6'b111_111)?llr_1_219:
                                  (choose)?$signed(LLR05[143:132]):
                                  PE91_o;                                         
    wire signed [11:0] llr_2_91 = (EX_counter==6'b111_111)?llr_2_219:
                                  (choose_1)?$signed(LLR013[143:132]):
                                  (choose_2)?$signed(LLR021[143:132]):
                                  PE219_o;
    wire u91 = (EX_counter==6'b111_111)?u_for_g[u_index+219]:u_for_g[u_index+91];
    PE PE91(.clk_i   (clk),
            .llr_1_i (llr_1_91),
            .llr_2_i (llr_2_91),
            .sum_i   (u91),
            .select_i(select_i),
            .result_o(PE91_o));
    
    wire signed [11:0] llr_1_92 = (EX_counter==6'b111_111)?llr_1_220:
                                  (choose)?$signed(LLR05[155:144]):
                                  PE92_o;                                         
    wire signed [11:0] llr_2_92 = (EX_counter==6'b111_111)?llr_2_220:
                                  (choose_1)?$signed(LLR013[155:144]):
                                  (choose_2)?$signed(LLR021[155:144]):
                                  PE220_o;
    wire u92 = (EX_counter==6'b111_111)?u_for_g[u_index+220]:u_for_g[u_index+92];
    PE PE92(.clk_i   (clk),
            .llr_1_i (llr_1_92),
            .llr_2_i (llr_2_92),
            .sum_i   (u92),
            .select_i(select_i),
            .result_o(PE92_o));
    
    wire signed [11:0] llr_1_93 = (EX_counter==6'b111_111)?llr_1_221:
                                  (choose)?$signed(LLR05[167:156]):
                                  PE93_o;                                         
    wire signed [11:0] llr_2_93 = (EX_counter==6'b111_111)?llr_2_221:
                                  (choose_1)?$signed(LLR013[167:156]):
                                  (choose_2)?$signed(LLR021[167:156]):
                                  PE221_o;
    wire u93 = (EX_counter==6'b111_111)?u_for_g[u_index+221]:u_for_g[u_index+93];
    PE PE93(.clk_i   (clk),
            .llr_1_i (llr_1_93),
            .llr_2_i (llr_2_93),
            .sum_i   (u93),
            .select_i(select_i),
            .result_o(PE93_o));
    
    wire signed [11:0] llr_1_94 = (EX_counter==6'b111_111)?llr_1_222:
                                  (choose)?$signed(LLR05[179:168]):
                                  PE94_o;                                         
    wire signed [11:0] llr_2_94 = (EX_counter==6'b111_111)?llr_2_222:
                                  (choose_1)?$signed(LLR013[179:168]):
                                  (choose_2)?$signed(LLR021[179:168]):
                                  PE222_o;
    wire u94 = (EX_counter==6'b111_111)?u_for_g[u_index+222]:u_for_g[u_index+94];
    PE PE94(.clk_i   (clk),
            .llr_1_i (llr_1_94),
            .llr_2_i (llr_2_94),
            .sum_i   (u94),
            .select_i(select_i),
            .result_o(PE94_o));
    
    wire signed [11:0] llr_1_95 = (EX_counter==6'b111_111)?llr_1_223:
                                  (choose)?$signed(LLR05[191:180]):
                                  PE95_o;                                         
    wire signed [11:0] llr_2_95 = (EX_counter==6'b111_111)?llr_2_223:
                                  (choose_1)?$signed(LLR013[191:180]):
                                  (choose_2)?$signed(LLR021[191:180]):
                                  PE223_o;
    wire u95 = (EX_counter==6'b111_111)?u_for_g[u_index+223]:u_for_g[u_index+95];
    PE PE95(.clk_i   (clk),
            .llr_1_i (llr_1_95),
            .llr_2_i (llr_2_95),
            .sum_i   (u95),
            .select_i(select_i),
            .result_o(PE95_o));
    
    wire signed [11:0] llr_1_96 = (EX_counter==6'b111_111)?llr_1_224:
                                  (choose)?$signed(LLR06[11:0]):
                                  PE96_o;                                         
    wire signed [11:0] llr_2_96 = (EX_counter==6'b111_111)?llr_2_224:
                                  (choose_1)?$signed(LLR014[11:0]):
                                  (choose_2)?$signed(LLR022[11:0]):
                                  PE224_o;
    wire u96 = (EX_counter==6'b111_111)?u_for_g[u_index+224]:u_for_g[u_index+96];
    PE PE96(.clk_i   (clk),
            .llr_1_i (llr_1_96),
            .llr_2_i (llr_2_96),
            .sum_i   (u96),
            .select_i(select_i),
            .result_o(PE96_o));
    
    wire signed [11:0] llr_1_97 = (EX_counter==6'b111_111)?llr_1_225:
                                  (choose)?$signed(LLR06[23:12]):
                                  PE97_o;                                         
    wire signed [11:0] llr_2_97 = (EX_counter==6'b111_111)?llr_2_225:
                                  (choose_1)?$signed(LLR014[23:12]):
                                  (choose_2)?$signed(LLR022[23:12]):
                                  PE225_o;
    wire u97 = (EX_counter==6'b111_111)?u_for_g[u_index+225]:u_for_g[u_index+97];
    PE PE97(.clk_i   (clk),
            .llr_1_i (llr_1_97),
            .llr_2_i (llr_2_97),
            .sum_i   (u97),
            .select_i(select_i),
            .result_o(PE97_o));
    
    wire signed [11:0] llr_1_98 = (EX_counter==6'b111_111)?llr_1_226:
                                  (choose)?$signed(LLR06[35:24]):
                                  PE98_o;                                         
    wire signed [11:0] llr_2_98 = (EX_counter==6'b111_111)?llr_2_226:
                                  (choose_1)?$signed(LLR014[35:24]):
                                  (choose_2)?$signed(LLR022[35:24]):
                                  PE226_o;
    wire u98 = (EX_counter==6'b111_111)?u_for_g[u_index+226]:u_for_g[u_index+98];
    PE PE98(.clk_i   (clk),
            .llr_1_i (llr_1_98),
            .llr_2_i (llr_2_98),
            .sum_i   (u98),
            .select_i(select_i),
            .result_o(PE98_o));
    
    wire signed [11:0] llr_1_99 = (EX_counter==6'b111_111)?llr_1_227:
                                  (choose)?$signed(LLR06[47:36]):
                                  PE99_o;                                         
    wire signed [11:0] llr_2_99 = (EX_counter==6'b111_111)?llr_2_227:
                                  (choose_1)?$signed(LLR014[47:36]):
                                  (choose_2)?$signed(LLR022[47:36]):
                                  PE227_o;
    wire u99 = (EX_counter==6'b111_111)?u_for_g[u_index+227]:u_for_g[u_index+99];
    PE PE99(.clk_i   (clk),
            .llr_1_i (llr_1_99),
            .llr_2_i (llr_2_99),
            .sum_i   (u99),
            .select_i(select_i),
            .result_o(PE99_o));
    
    wire signed [11:0] llr_1_100 = (EX_counter==6'b111_111)?llr_1_228:
                                   (choose)?$signed(LLR06[59:48]):
                                   PE100_o;                                         
    wire signed [11:0] llr_2_100 = (EX_counter==6'b111_111)?llr_2_228:
                                   (choose_1)?$signed(LLR014[59:48]):
                                   (choose_2)?$signed(LLR022[59:48]):
                                   PE228_o;
    wire u100 = (EX_counter==6'b111_111)?u_for_g[u_index+228]:u_for_g[u_index+100];
    PE PE100(.clk_i   (clk),
             .llr_1_i (llr_1_100),
             .llr_2_i (llr_2_100),
             .sum_i   (u100),
             .select_i(select_i),
             .result_o(PE100_o));
    
    wire signed [11:0] llr_1_101 = (EX_counter==6'b111_111)?llr_1_229:
                                   (choose)?$signed(LLR06[71:60]):
                                   PE101_o;                                         
    wire signed [11:0] llr_2_101 = (EX_counter==6'b111_111)?llr_2_229:
                                   (choose_1)?$signed(LLR014[71:60]):
                                   (choose_2)?$signed(LLR022[71:60]):
                                   PE229_o;
    wire u101 = (EX_counter==6'b111_111)?u_for_g[u_index+229]:u_for_g[u_index+101];
    PE PE101(.clk_i   (clk),
             .llr_1_i (llr_1_101),
             .llr_2_i (llr_2_101),
             .sum_i   (u101),
             .select_i(select_i),
             .result_o(PE101_o));
    
    wire signed [11:0] llr_1_102 = (EX_counter==6'b111_111)?llr_1_230:
                                   (choose)?$signed(LLR06[83:72]):
                                   PE102_o;                                         
    wire signed [11:0] llr_2_102 = (EX_counter==6'b111_111)?llr_2_230:
                                   (choose_1)?$signed(LLR014[83:72]):
                                   (choose_2)?$signed(LLR022[83:72]):
                                   PE230_o;
    wire u102 = (EX_counter==6'b111_111)?u_for_g[u_index+230]:u_for_g[u_index+102];
    PE PE102(.clk_i   (clk),
             .llr_1_i (llr_1_102),
             .llr_2_i (llr_2_102),
             .sum_i   (u102),
             .select_i(select_i),
             .result_o(PE102_o));
    
    wire signed [11:0] llr_1_103 = (EX_counter==6'b111_111)?llr_1_231:
                                   (choose)?$signed(LLR06[95:84]):
                                   PE103_o;                                         
    wire signed [11:0] llr_2_103 = (EX_counter==6'b111_111)?llr_2_231:
                                   (choose_1)?$signed(LLR014[95:84]):
                                   (choose_2)?$signed(LLR022[95:84]):
                                   PE231_o;
    wire u103 = (EX_counter==6'b111_111)?u_for_g[u_index+231]:u_for_g[u_index+103];
    PE PE103(.clk_i   (clk),
             .llr_1_i (llr_1_103),
             .llr_2_i (llr_2_103),
             .sum_i   (u103),
             .select_i(select_i),
             .result_o(PE103_o));
    
    wire signed [11:0] llr_1_104 = (EX_counter==6'b111_111)?llr_1_232:
                                   (choose)?$signed(LLR06[107:96]):
                                   PE104_o;                                         
    wire signed [11:0] llr_2_104 = (EX_counter==6'b111_111)?llr_2_232:
                                   (choose_1)?$signed(LLR014[107:96]):
                                   (choose_2)?$signed(LLR022[107:96]):
                                   PE232_o;
    wire u104 = (EX_counter==6'b111_111)?u_for_g[u_index+232]:u_for_g[u_index+104];
    PE PE104(.clk_i   (clk),
             .llr_1_i (llr_1_104),
             .llr_2_i (llr_2_104),
             .sum_i   (u104),
             .select_i(select_i),
             .result_o(PE104_o));
    
    wire signed [11:0] llr_1_105 = (EX_counter==6'b111_111)?llr_1_233:
                                   (choose)?$signed(LLR06[119:108]):
                                   PE105_o;                                         
    wire signed [11:0] llr_2_105 = (EX_counter==6'b111_111)?llr_2_233:
                                   (choose_1)?$signed(LLR014[119:108]):
                                   (choose_2)?$signed(LLR022[119:108]):
                                   PE233_o;
    wire u105 = (EX_counter==6'b111_111)?u_for_g[u_index+233]:u_for_g[u_index+105];
    PE PE105(.clk_i   (clk),
             .llr_1_i (llr_1_105),
             .llr_2_i (llr_2_105),
             .sum_i   (u105),
             .select_i(select_i),
             .result_o(PE105_o));
    
    wire signed [11:0] llr_1_106 = (EX_counter==6'b111_111)?llr_1_234:
                                   (choose)?$signed(LLR06[131:120]):
                                   PE106_o;                                         
    wire signed [11:0] llr_2_106 = (EX_counter==6'b111_111)?llr_2_234:
                                   (choose_1)?$signed(LLR014[131:120]):
                                   (choose_2)?$signed(LLR022[131:120]):
                                   PE234_o;
    wire u106 = (EX_counter==6'b111_111)?u_for_g[u_index+234]:u_for_g[u_index+106];
    PE PE106(.clk_i   (clk),
             .llr_1_i (llr_1_106),
             .llr_2_i (llr_2_106),
             .sum_i   (u106),
             .select_i(select_i),
             .result_o(PE106_o));
    
    wire signed [11:0] llr_1_107 = (EX_counter==6'b111_111)?llr_1_235:
                                   (choose)?$signed(LLR06[143:132]):
                                   PE107_o;                                         
    wire signed [11:0] llr_2_107 = (EX_counter==6'b111_111)?llr_2_235:
                                   (choose_1)?$signed(LLR014[143:132]):
                                   (choose_2)?$signed(LLR022[143:132]):
                                   PE235_o;
    wire u107 = (EX_counter==6'b111_111)?u_for_g[u_index+235]:u_for_g[u_index+107];
    PE PE107(.clk_i   (clk),
             .llr_1_i (llr_1_107),
             .llr_2_i (llr_2_107),
             .sum_i   (u107),
             .select_i(select_i),
             .result_o(PE107_o));
    
    wire signed [11:0] llr_1_108 = (EX_counter==6'b111_111)?llr_1_236:
                                   (choose)?$signed(LLR06[155:144]):
                                   PE108_o;                                         
    wire signed [11:0] llr_2_108 = (EX_counter==6'b111_111)?llr_2_236:
                                   (choose_1)?$signed(LLR014[155:144]):
                                   (choose_2)?$signed(LLR022[155:144]):
                                   PE236_o;
    wire u108 = (EX_counter==6'b111_111)?u_for_g[u_index+236]:u_for_g[u_index+108];
    PE PE108(.clk_i   (clk),
             .llr_1_i (llr_1_108),
             .llr_2_i (llr_2_108),
             .sum_i   (u108),
             .select_i(select_i),
             .result_o(PE108_o));
    
    wire signed [11:0] llr_1_109 = (EX_counter==6'b111_111)?llr_1_237:
                                   (choose)?$signed(LLR06[167:156]):
                                   PE109_o;                                         
    wire signed [11:0] llr_2_109 = (EX_counter==6'b111_111)?llr_2_237:
                                   (choose_1)?$signed(LLR014[167:156]):
                                   (choose_2)?$signed(LLR022[167:156]):
                                   PE237_o;
    wire u109 = (EX_counter==6'b111_111)?u_for_g[u_index+237]:u_for_g[u_index+109];
    PE PE109(.clk_i   (clk),
             .llr_1_i (llr_1_109),
             .llr_2_i (llr_2_109),
             .sum_i   (u109),
             .select_i(select_i),
             .result_o(PE109_o));
    
    wire signed [11:0] llr_1_110 = (EX_counter==6'b111_111)?llr_1_238:
                                   (choose)?$signed(LLR06[179:168]):
                                   PE110_o;                                         
    wire signed [11:0] llr_2_110 = (EX_counter==6'b111_111)?llr_2_238:
                                   (choose_1)?$signed(LLR014[179:168]):
                                   (choose_2)?$signed(LLR022[179:168]):
                                   PE238_o;
    wire u110 = (EX_counter==6'b111_111)?u_for_g[u_index+238]:u_for_g[u_index+110];
    PE PE110(.clk_i   (clk),
             .llr_1_i (llr_1_110),
             .llr_2_i (llr_2_110),
             .sum_i   (u110),
             .select_i(select_i),
             .result_o(PE110_o));
    
    wire signed [11:0] llr_1_111 = (EX_counter==6'b111_111)?llr_1_239:
                                   (choose)?$signed(LLR06[191:180]):
                                   PE111_o;                                         
    wire signed [11:0] llr_2_111 = (EX_counter==6'b111_111)?llr_2_239:
                                   (choose_1)?$signed(LLR014[191:180]):
                                   (choose_2)?$signed(LLR022[191:180]):
                                   PE239_o;
    wire u111 = (EX_counter==6'b111_111)?u_for_g[u_index+239]:u_for_g[u_index+111];
    PE PE111(.clk_i   (clk),
             .llr_1_i (llr_1_111),
             .llr_2_i (llr_2_111),
             .sum_i   (u111),
             .select_i(select_i),
             .result_o(PE111_o));
    
    wire signed [11:0] llr_1_112 = (EX_counter==6'b111_111)?llr_1_240:
                                   (choose)?$signed(LLR07[11:0]):
                                   PE112_o;                                         
    wire signed [11:0] llr_2_112 = (EX_counter==6'b111_111)?llr_2_240:
                                   (choose_1)?$signed(LLR015[11:0]):
                                   (choose_2)?$signed(LLR023[11:0]):
                                   PE240_o;
    wire u112 = (EX_counter==6'b111_111)?u_for_g[u_index+240]:u_for_g[u_index+112];
    PE PE112(.clk_i   (clk),
             .llr_1_i (llr_1_112),
             .llr_2_i (llr_2_112),
             .sum_i   (u112),
             .select_i(select_i),
             .result_o(PE112_o));
    
    wire signed [11:0] llr_1_113 = (EX_counter==6'b111_111)?llr_1_241:
                                   (choose)?$signed(LLR07[23:12]):
                                   PE113_o;                                         
    wire signed [11:0] llr_2_113 = (EX_counter==6'b111_111)?llr_2_241:
                                   (choose_1)?$signed(LLR015[23:12]):
                                   (choose_2)?$signed(LLR023[23:12]):
                                   PE241_o;
    wire u113 = (EX_counter==6'b111_111)?u_for_g[u_index+241]:u_for_g[u_index+113];
    PE PE113(.clk_i   (clk),
             .llr_1_i (llr_1_113),
             .llr_2_i (llr_2_113),
             .sum_i   (u113),
             .select_i(select_i),
             .result_o(PE113_o));
    
    wire signed [11:0] llr_1_114 = (EX_counter==6'b111_111)?llr_1_242:
                                   (choose)?$signed(LLR07[35:24]):
                                   PE114_o;                                         
    wire signed [11:0] llr_2_114 = (EX_counter==6'b111_111)?llr_2_242:
                                   (choose_1)?$signed(LLR015[35:24]):
                                   (choose_2)?$signed(LLR023[35:24]):
                                   PE242_o;
    wire u114 = (EX_counter==6'b111_111)?u_for_g[u_index+242]:u_for_g[u_index+114];
    PE PE114(.clk_i   (clk),
             .llr_1_i (llr_1_114),
             .llr_2_i (llr_2_114),
             .sum_i   (u114),
             .select_i(select_i),
             .result_o(PE114_o));
    
    wire signed [11:0] llr_1_115 = (EX_counter==6'b111_111)?llr_1_243:
                                   (choose)?$signed(LLR07[47:36]):
                                   PE115_o;                                         
    wire signed [11:0] llr_2_115 = (EX_counter==6'b111_111)?llr_2_243:
                                   (choose_1)?$signed(LLR015[47:36]):
                                   (choose_2)?$signed(LLR023[47:36]):
                                   PE243_o;
    wire u115 = (EX_counter==6'b111_111)?u_for_g[u_index+243]:u_for_g[u_index+115];
    PE PE115(.clk_i   (clk),
             .llr_1_i (llr_1_115),
             .llr_2_i (llr_2_115),
             .sum_i   (u115),
             .select_i(select_i),
             .result_o(PE115_o));
    
    wire signed [11:0] llr_1_116 = (EX_counter==6'b111_111)?llr_1_244:
                                   (choose)?$signed(LLR07[59:48]):
                                   PE116_o;                                         
    wire signed [11:0] llr_2_116 = (EX_counter==6'b111_111)?llr_2_244:
                                   (choose_1)?$signed(LLR015[59:48]):
                                   (choose_2)?$signed(LLR023[59:48]):
                                   PE244_o;
    wire u116 = (EX_counter==6'b111_111)?u_for_g[u_index+244]:u_for_g[u_index+116];
    PE PE116(.clk_i   (clk),
             .llr_1_i (llr_1_116),
             .llr_2_i (llr_2_116),
             .sum_i   (u116),
             .select_i(select_i),
             .result_o(PE116_o));
    
    wire signed [11:0] llr_1_117 = (EX_counter==6'b111_111)?llr_1_245:
                                   (choose)?$signed(LLR07[71:60]):
                                   PE117_o;                                         
    wire signed [11:0] llr_2_117 = (EX_counter==6'b111_111)?llr_2_245:
                                   (choose_1)?$signed(LLR015[71:60]):
                                   (choose_2)?$signed(LLR023[71:60]):
                                   PE245_o;
    wire u117 = (EX_counter==6'b111_111)?u_for_g[u_index+245]:u_for_g[u_index+117];
    PE PE117(.clk_i   (clk),
             .llr_1_i (llr_1_117),
             .llr_2_i (llr_2_117),
             .sum_i   (u117),
             .select_i(select_i),
             .result_o(PE117_o));
    
    wire signed [11:0] llr_1_118 = (EX_counter==6'b111_111)?llr_1_246:
                                   (choose)?$signed(LLR07[83:72]):
                                   PE118_o;                                         
    wire signed [11:0] llr_2_118 = (EX_counter==6'b111_111)?llr_2_246:
                                   (choose_1)?$signed(LLR015[83:72]):
                                   (choose_2)?$signed(LLR023[83:72]):
                                   PE246_o;
    wire u118 = (EX_counter==6'b111_111)?u_for_g[u_index+246]:u_for_g[u_index+118];
    PE PE118(.clk_i   (clk),
             .llr_1_i (llr_1_118),
             .llr_2_i (llr_2_118),
             .sum_i   (u118),
             .select_i(select_i),
             .result_o(PE118_o));
    
    wire signed [11:0] llr_1_119 = (EX_counter==6'b111_111)?llr_1_247:
                                   (choose)?$signed(LLR07[95:84]):
                                   PE119_o;                                         
    wire signed [11:0] llr_2_119 = (EX_counter==6'b111_111)?llr_2_247:
                                   (choose_1)?$signed(LLR015[95:84]):
                                   (choose_2)?$signed(LLR023[95:84]):
                                   PE247_o;
    wire u119 = (EX_counter==6'b111_111)?u_for_g[u_index+247]:u_for_g[u_index+119];
    PE PE119(.clk_i   (clk),
             .llr_1_i (llr_1_119),
             .llr_2_i (llr_2_119),
             .sum_i   (u119),
             .select_i(select_i),
             .result_o(PE119_o));
    
    wire signed [11:0] llr_1_120 = (EX_counter==6'b111_111)?llr_1_248:
                                   (choose)?$signed(LLR07[107:96]):
                                   PE120_o;                                         
    wire signed [11:0] llr_2_120 = (EX_counter==6'b111_111)?llr_2_248:
                                   (choose_1)?$signed(LLR015[107:96]):
                                   (choose_2)?$signed(LLR023[107:96]):
                                   PE248_o;
    wire u120 = (EX_counter==6'b111_111)?u_for_g[u_index+248]:u_for_g[u_index+120];
    PE PE120(.clk_i   (clk),
             .llr_1_i (llr_1_120),
             .llr_2_i (llr_2_120),
             .sum_i   (u120),
             .select_i(select_i),
             .result_o(PE120_o));
    
    wire signed [11:0] llr_1_121 = (EX_counter==6'b111_111)?llr_1_249:
                                   (choose)?$signed(LLR07[119:108]):
                                   PE121_o;                                         
    wire signed [11:0] llr_2_121 = (EX_counter==6'b111_111)?llr_2_249:
                                   (choose_1)?$signed(LLR015[119:108]):
                                   (choose_2)?$signed(LLR023[119:108]):
                                   PE249_o;
    wire u121 = (EX_counter==6'b111_111)?u_for_g[u_index+249]:u_for_g[u_index+121];
    PE PE121(.clk_i   (clk),
             .llr_1_i (llr_1_121),
             .llr_2_i (llr_2_121),
             .sum_i   (u121),
             .select_i(select_i),
             .result_o(PE121_o));
    
    wire signed [11:0] llr_1_122 = (EX_counter==6'b111_111)?llr_1_250:
                                   (choose)?$signed(LLR07[131:120]):
                                   PE122_o;                                         
    wire signed [11:0] llr_2_122 = (EX_counter==6'b111_111)?llr_2_250:
                                   (choose_1)?$signed(LLR015[131:120]):
                                   (choose_2)?$signed(LLR023[131:120]):
                                   PE250_o;
    wire u122 = (EX_counter==6'b111_111)?u_for_g[u_index+250]:u_for_g[u_index+122];
    PE PE122(.clk_i   (clk),
             .llr_1_i (llr_1_122),
             .llr_2_i (llr_2_122),
             .sum_i   (u122),
             .select_i(select_i),
             .result_o(PE122_o));
    
    wire signed [11:0] llr_1_123 = (EX_counter==6'b111_111)?llr_1_251:
                                   (choose)?$signed(LLR07[143:132]):
                                   PE123_o;                                         
    wire signed [11:0] llr_2_123 = (EX_counter==6'b111_111)?llr_2_251:
                                   (choose_1)?$signed(LLR015[143:132]):
                                   (choose_2)?$signed(LLR023[143:132]):
                                   PE251_o;
    wire u123 = (EX_counter==6'b111_111)?u_for_g[u_index+251]:u_for_g[u_index+123];
    PE PE123(.clk_i   (clk),
             .llr_1_i (llr_1_123),
             .llr_2_i (llr_2_123),
             .sum_i   (u123),
             .select_i(select_i),
             .result_o(PE123_o));
    
    wire signed [11:0] llr_1_124 = (EX_counter==6'b111_111)?llr_1_252:
                                   (choose)?$signed(LLR07[155:144]):
                                   PE124_o;                                         
    wire signed [11:0] llr_2_124 = (EX_counter==6'b111_111)?llr_2_252:
                                   (choose_1)?$signed(LLR015[155:144]):
                                   (choose_2)?$signed(LLR023[155:144]):
                                   PE252_o;
    wire u124 = (EX_counter==6'b111_111)?u_for_g[u_index+252]:u_for_g[u_index+124];
    PE PE124(.clk_i   (clk),
             .llr_1_i (llr_1_124),
             .llr_2_i (llr_2_124),
             .sum_i   (u124),
             .select_i(select_i),
             .result_o(PE124_o));
    
    wire signed [11:0] llr_1_125 = (EX_counter==6'b111_111)?llr_1_253:
                                   (choose)?$signed(LLR07[167:156]):
                                   PE125_o;                                         
    wire signed [11:0] llr_2_125 = (EX_counter==6'b111_111)?llr_2_253:
                                   (choose_1)?$signed(LLR015[167:156]):
                                   (choose_2)?$signed(LLR023[167:156]):
                                   PE253_o;
    wire u125 = (EX_counter==6'b111_111)?u_for_g[u_index+253]:u_for_g[u_index+125];
    PE PE125(.clk_i   (clk),
             .llr_1_i (llr_1_125),
             .llr_2_i (llr_2_125),
             .sum_i   (u125),
             .select_i(select_i),
             .result_o(PE125_o));
    
    wire signed [11:0] llr_1_126 = (EX_counter==6'b111_111)?llr_1_254:
                                   (choose)?$signed(LLR07[179:168]):
                                   PE126_o;                                         
    wire signed [11:0] llr_2_126 = (EX_counter==6'b111_111)?llr_2_254:
                                   (choose_1)?$signed(LLR015[179:168]):
                                   (choose && N[2])?$signed(LLR023[179:168]):
                                   PE254_o;
    wire u126 = (EX_counter==6'b111_111)?u_for_g[u_index+254]:u_for_g[u_index+126];
    PE PE126(.clk_i   (clk),
             .llr_1_i (llr_1_126),
             .llr_2_i (llr_2_126),
             .sum_i   (u126),
             .select_i(select_i),
             .result_o(PE126_o));
    
    wire signed [11:0] llr_1_127 = (EX_counter==6'b111_111)?llr_1_255:
                                   (choose)?$signed(LLR07[191:180]):
                                   PE127_o;                                         
    wire signed [11:0] llr_2_127 = (EX_counter==6'b111_111)?llr_2_255:
                                   (choose_1)?$signed(LLR015[191:180]):
                                   (choose_2)?$signed(LLR023[191:180]):
                                   PE255_o;
    wire u127 = (EX_counter==6'b111_111)?u_for_g[u_index+255]:u_for_g[u_index+127];
    PE PE127(.clk_i   (clk),
             .llr_1_i (llr_1_127),
             .llr_2_i (llr_2_127),
             .sum_i   (u127),
             .select_i(select_i),
             .result_o(PE127_o));
    /////////////////////////////////////////////////////////////////////////////////////////
    
    assign RELIABILITY_128[  0] = 7'd0;
    assign RELIABILITY_128[  1] = 7'd1;
    assign RELIABILITY_128[  2] = 7'd2;
    assign RELIABILITY_128[  3] = 7'd4;
    assign RELIABILITY_128[  4] = 7'd8;
    assign RELIABILITY_128[  5] = 7'd16;
    assign RELIABILITY_128[  6] = 7'd32;
    assign RELIABILITY_128[  7] = 7'd3;
    assign RELIABILITY_128[  8] = 7'd5;
    assign RELIABILITY_128[  9] = 7'd64;
    assign RELIABILITY_128[ 10] = 7'd9;
    assign RELIABILITY_128[ 11] = 7'd6;
    assign RELIABILITY_128[ 12] = 7'd17;
    assign RELIABILITY_128[ 13] = 7'd10;
    assign RELIABILITY_128[ 14] = 7'd18;
    assign RELIABILITY_128[ 15] = 7'd12;
    assign RELIABILITY_128[ 16] = 7'd33;
    assign RELIABILITY_128[ 17] = 7'd65;
    assign RELIABILITY_128[ 18] = 7'd20;
    assign RELIABILITY_128[ 19] = 7'd34;
    assign RELIABILITY_128[ 20] = 7'd24;
    assign RELIABILITY_128[ 21] = 7'd36;
    assign RELIABILITY_128[ 22] = 7'd7;
    assign RELIABILITY_128[ 23] = 7'd66;
    assign RELIABILITY_128[ 24] = 7'd11;
    assign RELIABILITY_128[ 25] = 7'd40;
    assign RELIABILITY_128[ 26] = 7'd68;
    assign RELIABILITY_128[ 27] = 7'd19;
    assign RELIABILITY_128[ 28] = 7'd13;
    assign RELIABILITY_128[ 29] = 7'd48;
    assign RELIABILITY_128[ 30] = 7'd14;
    assign RELIABILITY_128[ 31] = 7'd72;
    assign RELIABILITY_128[ 32] = 7'd21;
    assign RELIABILITY_128[ 33] = 7'd35;
    assign RELIABILITY_128[ 34] = 7'd26;
    assign RELIABILITY_128[ 35] = 7'd80;
    assign RELIABILITY_128[ 36] = 7'd37;
    assign RELIABILITY_128[ 37] = 7'd25;
    assign RELIABILITY_128[ 38] = 7'd22;
    assign RELIABILITY_128[ 39] = 7'd38;
    assign RELIABILITY_128[ 40] = 7'd96;
    assign RELIABILITY_128[ 41] = 7'd67;
    assign RELIABILITY_128[ 42] = 7'd41;
    assign RELIABILITY_128[ 43] = 7'd28;
    assign RELIABILITY_128[ 44] = 7'd69;
    assign RELIABILITY_128[ 45] = 7'd42;
    assign RELIABILITY_128[ 46] = 7'd49;
    assign RELIABILITY_128[ 47] = 7'd74;
    assign RELIABILITY_128[ 48] = 7'd70;
    assign RELIABILITY_128[ 49] = 7'd44;
    assign RELIABILITY_128[ 50] = 7'd81;
    assign RELIABILITY_128[ 51] = 7'd50;
    assign RELIABILITY_128[ 52] = 7'd73;
    assign RELIABILITY_128[ 53] = 7'd15;
    assign RELIABILITY_128[ 54] = 7'd52;
    assign RELIABILITY_128[ 55] = 7'd23;
    assign RELIABILITY_128[ 56] = 7'd76;
    assign RELIABILITY_128[ 57] = 7'd82;
    assign RELIABILITY_128[ 58] = 7'd56;
    assign RELIABILITY_128[ 59] = 7'd27;
    assign RELIABILITY_128[ 60] = 7'd97;
    assign RELIABILITY_128[ 61] = 7'd39;
    assign RELIABILITY_128[ 62] = 7'd84;
    assign RELIABILITY_128[ 63] = 7'd29;
    assign RELIABILITY_128[ 64] = 7'd43;
    assign RELIABILITY_128[ 65] = 7'd98;
    assign RELIABILITY_128[ 66] = 7'd88;
    assign RELIABILITY_128[ 67] = 7'd30;
    assign RELIABILITY_128[ 68] = 7'd71;
    assign RELIABILITY_128[ 69] = 7'd45;
    assign RELIABILITY_128[ 70] = 7'd100;
    assign RELIABILITY_128[ 71] = 7'd51;
    assign RELIABILITY_128[ 72] = 7'd46;
    assign RELIABILITY_128[ 73] = 7'd75;
    assign RELIABILITY_128[ 74] = 7'd104;
    assign RELIABILITY_128[ 75] = 7'd53;
    assign RELIABILITY_128[ 76] = 7'd77;
    assign RELIABILITY_128[ 77] = 7'd54;
    assign RELIABILITY_128[ 78] = 7'd83;
    assign RELIABILITY_128[ 79] = 7'd57;
    assign RELIABILITY_128[ 80] = 7'd112;
    assign RELIABILITY_128[ 81] = 7'd78;
    assign RELIABILITY_128[ 82] = 7'd85;
    assign RELIABILITY_128[ 83] = 7'd58;
    assign RELIABILITY_128[ 84] = 7'd99;
    assign RELIABILITY_128[ 85] = 7'd86;
    assign RELIABILITY_128[ 86] = 7'd60;
    assign RELIABILITY_128[ 87] = 7'd89;
    assign RELIABILITY_128[ 88] = 7'd101;
    assign RELIABILITY_128[ 89] = 7'd31;
    assign RELIABILITY_128[ 90] = 7'd90;
    assign RELIABILITY_128[ 91] = 7'd102;
    assign RELIABILITY_128[ 92] = 7'd105;
    assign RELIABILITY_128[ 93] = 7'd92;
    assign RELIABILITY_128[ 94] = 7'd47;
    assign RELIABILITY_128[ 95] = 7'd106;
    assign RELIABILITY_128[ 96] = 7'd55;
    assign RELIABILITY_128[ 97] = 7'd113;
    assign RELIABILITY_128[ 98] = 7'd79;
    assign RELIABILITY_128[ 99] = 7'd108;
    assign RELIABILITY_128[100] = 7'd59;
    assign RELIABILITY_128[101] = 7'd114;
    assign RELIABILITY_128[102] = 7'd87;
    assign RELIABILITY_128[103] = 7'd116;
    assign RELIABILITY_128[104] = 7'd61;
    assign RELIABILITY_128[105] = 7'd91;
    assign RELIABILITY_128[106] = 7'd120;
    assign RELIABILITY_128[107] = 7'd62;
    assign RELIABILITY_128[108] = 7'd103;
    assign RELIABILITY_128[109] = 7'd93;
    assign RELIABILITY_128[110] = 7'd107;
    assign RELIABILITY_128[111] = 7'd94;
    assign RELIABILITY_128[112] = 7'd109;
    assign RELIABILITY_128[113] = 7'd115;
    assign RELIABILITY_128[114] = 7'd110;
    assign RELIABILITY_128[115] = 7'd117;
    assign RELIABILITY_128[116] = 7'd118;
    assign RELIABILITY_128[117] = 7'd121;
    assign RELIABILITY_128[118] = 7'd122;
    assign RELIABILITY_128[119] = 7'd63;
    assign RELIABILITY_128[120] = 7'd124;
    assign RELIABILITY_128[121] = 7'd95;
    assign RELIABILITY_128[122] = 7'd111;
    assign RELIABILITY_128[123] = 7'd119;
    assign RELIABILITY_128[124] = 7'd123;
    assign RELIABILITY_128[125] = 7'd125;
    assign RELIABILITY_128[126] = 7'd126;
    assign RELIABILITY_128[127] = 7'd127;
    
    assign RELIABILITY_256[  0] = 8'd0  ;
    assign RELIABILITY_256[  1] = 8'd1  ;
    assign RELIABILITY_256[  2] = 8'd2  ;
    assign RELIABILITY_256[  3] = 8'd4  ;
    assign RELIABILITY_256[  4] = 8'd8  ;
    assign RELIABILITY_256[  5] = 8'd16 ;
    assign RELIABILITY_256[  6] = 8'd32 ;
    assign RELIABILITY_256[  7] = 8'd3  ;
    assign RELIABILITY_256[  8] = 8'd5  ;
    assign RELIABILITY_256[  9] = 8'd64 ;
    assign RELIABILITY_256[ 10] = 8'd9  ;
    assign RELIABILITY_256[ 11] = 8'd6  ;
    assign RELIABILITY_256[ 12] = 8'd17 ;
    assign RELIABILITY_256[ 13] = 8'd10 ;
    assign RELIABILITY_256[ 14] = 8'd18 ;
    assign RELIABILITY_256[ 15] = 8'd128;
    assign RELIABILITY_256[ 16] = 8'd12 ;
    assign RELIABILITY_256[ 17] = 8'd33 ;
    assign RELIABILITY_256[ 18] = 8'd65 ;
    assign RELIABILITY_256[ 19] = 8'd20 ;
    assign RELIABILITY_256[ 20] = 8'd34 ;
    assign RELIABILITY_256[ 21] = 8'd24 ;
    assign RELIABILITY_256[ 22] = 8'd36 ;
    assign RELIABILITY_256[ 23] = 8'd7  ;
    assign RELIABILITY_256[ 24] = 8'd129;
    assign RELIABILITY_256[ 25] = 8'd66 ;
    assign RELIABILITY_256[ 26] = 8'd11 ;
    assign RELIABILITY_256[ 27] = 8'd40 ;
    assign RELIABILITY_256[ 28] = 8'd68 ;
    assign RELIABILITY_256[ 29] = 8'd130;
    assign RELIABILITY_256[ 30] = 8'd19 ;
    assign RELIABILITY_256[ 31] = 8'd13 ;
    assign RELIABILITY_256[ 32] = 8'd48 ;
    assign RELIABILITY_256[ 33] = 8'd14 ;
    assign RELIABILITY_256[ 34] = 8'd72 ;
    assign RELIABILITY_256[ 35] = 8'd21 ;
    assign RELIABILITY_256[ 36] = 8'd132;
    assign RELIABILITY_256[ 37] = 8'd35 ;
    assign RELIABILITY_256[ 38] = 8'd26 ;
    assign RELIABILITY_256[ 39] = 8'd80 ;
    assign RELIABILITY_256[ 40] = 8'd37 ;
    assign RELIABILITY_256[ 41] = 8'd25 ;
    assign RELIABILITY_256[ 42] = 8'd22 ;
    assign RELIABILITY_256[ 43] = 8'd136;
    assign RELIABILITY_256[ 44] = 8'd38 ;
    assign RELIABILITY_256[ 45] = 8'd96 ;
    assign RELIABILITY_256[ 46] = 8'd67 ;
    assign RELIABILITY_256[ 47] = 8'd41 ;
    assign RELIABILITY_256[ 48] = 8'd144;
    assign RELIABILITY_256[ 49] = 8'd28 ;
    assign RELIABILITY_256[ 50] = 8'd69 ;
    assign RELIABILITY_256[ 51] = 8'd42 ;
    assign RELIABILITY_256[ 52] = 8'd49 ;
    assign RELIABILITY_256[ 53] = 8'd74 ;
    assign RELIABILITY_256[ 54] = 8'd160;
    assign RELIABILITY_256[ 55] = 8'd192;
    assign RELIABILITY_256[ 56] = 8'd70 ;
    assign RELIABILITY_256[ 57] = 8'd44 ;
    assign RELIABILITY_256[ 58] = 8'd131;
    assign RELIABILITY_256[ 59] = 8'd81 ;
    assign RELIABILITY_256[ 60] = 8'd50 ;
    assign RELIABILITY_256[ 61] = 8'd73 ;
    assign RELIABILITY_256[ 62] = 8'd15 ;
    assign RELIABILITY_256[ 63] = 8'd133;
    assign RELIABILITY_256[ 64] = 8'd52 ;
    assign RELIABILITY_256[ 65] = 8'd23 ;
    assign RELIABILITY_256[ 66] = 8'd134;
    assign RELIABILITY_256[ 67] = 8'd76 ;
    assign RELIABILITY_256[ 68] = 8'd137;
    assign RELIABILITY_256[ 69] = 8'd82 ;
    assign RELIABILITY_256[ 70] = 8'd56 ;
    assign RELIABILITY_256[ 71] = 8'd27 ;
    assign RELIABILITY_256[ 72] = 8'd97 ;
    assign RELIABILITY_256[ 73] = 8'd39 ;
    assign RELIABILITY_256[ 74] = 8'd84 ;
    assign RELIABILITY_256[ 75] = 8'd138;
    assign RELIABILITY_256[ 76] = 8'd145;
    assign RELIABILITY_256[ 77] = 8'd29 ;
    assign RELIABILITY_256[ 78] = 8'd43 ;
    assign RELIABILITY_256[ 79] = 8'd98 ;
    assign RELIABILITY_256[ 80] = 8'd88 ;
    assign RELIABILITY_256[ 81] = 8'd140;
    assign RELIABILITY_256[ 82] = 8'd30 ;
    assign RELIABILITY_256[ 83] = 8'd146;
    assign RELIABILITY_256[ 84] = 8'd71 ;
    assign RELIABILITY_256[ 85] = 8'd161;
    assign RELIABILITY_256[ 86] = 8'd45 ;
    assign RELIABILITY_256[ 87] = 8'd100;
    assign RELIABILITY_256[ 88] = 8'd51 ;
    assign RELIABILITY_256[ 89] = 8'd148;
    assign RELIABILITY_256[ 90] = 8'd46 ;
    assign RELIABILITY_256[ 91] = 8'd75 ;
    assign RELIABILITY_256[ 92] = 8'd104;
    assign RELIABILITY_256[ 93] = 8'd162;
    assign RELIABILITY_256[ 94] = 8'd53 ;
    assign RELIABILITY_256[ 95] = 8'd193;
    assign RELIABILITY_256[ 96] = 8'd152;
    assign RELIABILITY_256[ 97] = 8'd77 ;
    assign RELIABILITY_256[ 98] = 8'd164;
    assign RELIABILITY_256[ 99] = 8'd54 ;
    assign RELIABILITY_256[100] = 8'd83 ;
    assign RELIABILITY_256[101] = 8'd57 ;
    assign RELIABILITY_256[102] = 8'd112;
    assign RELIABILITY_256[103] = 8'd135;
    assign RELIABILITY_256[104] = 8'd78 ;
    assign RELIABILITY_256[105] = 8'd194;
    assign RELIABILITY_256[106] = 8'd85 ;
    assign RELIABILITY_256[107] = 8'd58 ;
    assign RELIABILITY_256[108] = 8'd168;
    assign RELIABILITY_256[109] = 8'd139;
    assign RELIABILITY_256[110] = 8'd99 ;
    assign RELIABILITY_256[111] = 8'd86 ;
    assign RELIABILITY_256[112] = 8'd60 ;
    assign RELIABILITY_256[113] = 8'd89 ;
    assign RELIABILITY_256[114] = 8'd196;
    assign RELIABILITY_256[115] = 8'd141;
    assign RELIABILITY_256[116] = 8'd101;
    assign RELIABILITY_256[117] = 8'd147;
    assign RELIABILITY_256[118] = 8'd176;
    assign RELIABILITY_256[119] = 8'd142;
    assign RELIABILITY_256[120] = 8'd31 ;
    assign RELIABILITY_256[121] = 8'd200;
    assign RELIABILITY_256[122] = 8'd90 ;
    assign RELIABILITY_256[123] = 8'd149;
    assign RELIABILITY_256[124] = 8'd102;
    assign RELIABILITY_256[125] = 8'd105;
    assign RELIABILITY_256[126] = 8'd163;
    assign RELIABILITY_256[127] = 8'd92 ;
    assign RELIABILITY_256[128] = 8'd47 ;
    assign RELIABILITY_256[129] = 8'd208;
    assign RELIABILITY_256[130] = 8'd150;
    assign RELIABILITY_256[131] = 8'd153;
    assign RELIABILITY_256[132] = 8'd165;
    assign RELIABILITY_256[133] = 8'd106;
    assign RELIABILITY_256[134] = 8'd55 ;
    assign RELIABILITY_256[135] = 8'd113;
    assign RELIABILITY_256[136] = 8'd154;
    assign RELIABILITY_256[137] = 8'd79 ;
    assign RELIABILITY_256[138] = 8'd108;
    assign RELIABILITY_256[139] = 8'd224;
    assign RELIABILITY_256[140] = 8'd166;
    assign RELIABILITY_256[141] = 8'd195;
    assign RELIABILITY_256[142] = 8'd59 ;
    assign RELIABILITY_256[143] = 8'd169;
    assign RELIABILITY_256[144] = 8'd114;
    assign RELIABILITY_256[145] = 8'd156;
    assign RELIABILITY_256[146] = 8'd87 ;
    assign RELIABILITY_256[147] = 8'd197;
    assign RELIABILITY_256[148] = 8'd116;
    assign RELIABILITY_256[149] = 8'd170;
    assign RELIABILITY_256[150] = 8'd61 ;
    assign RELIABILITY_256[151] = 8'd177;
    assign RELIABILITY_256[152] = 8'd91 ;
    assign RELIABILITY_256[153] = 8'd198;
    assign RELIABILITY_256[154] = 8'd172;
    assign RELIABILITY_256[155] = 8'd120;
    assign RELIABILITY_256[156] = 8'd201;
    assign RELIABILITY_256[157] = 8'd62 ;
    assign RELIABILITY_256[158] = 8'd143;
    assign RELIABILITY_256[159] = 8'd103;
    assign RELIABILITY_256[160] = 8'd178;
    assign RELIABILITY_256[161] = 8'd93 ;
    assign RELIABILITY_256[162] = 8'd202;
    assign RELIABILITY_256[163] = 8'd107;
    assign RELIABILITY_256[164] = 8'd180;
    assign RELIABILITY_256[165] = 8'd151;
    assign RELIABILITY_256[166] = 8'd209;
    assign RELIABILITY_256[167] = 8'd94 ;
    assign RELIABILITY_256[168] = 8'd204;
    assign RELIABILITY_256[169] = 8'd155;
    assign RELIABILITY_256[170] = 8'd210;
    assign RELIABILITY_256[171] = 8'd109;
    assign RELIABILITY_256[172] = 8'd184;
    assign RELIABILITY_256[173] = 8'd115;
    assign RELIABILITY_256[174] = 8'd167;
    assign RELIABILITY_256[175] = 8'd225;
    assign RELIABILITY_256[176] = 8'd157;
    assign RELIABILITY_256[177] = 8'd110;
    assign RELIABILITY_256[178] = 8'd117;
    assign RELIABILITY_256[179] = 8'd212;
    assign RELIABILITY_256[180] = 8'd171;
    assign RELIABILITY_256[181] = 8'd226;
    assign RELIABILITY_256[182] = 8'd216;
    assign RELIABILITY_256[183] = 8'd158;
    assign RELIABILITY_256[184] = 8'd118;
    assign RELIABILITY_256[185] = 8'd173;
    assign RELIABILITY_256[186] = 8'd121;
    assign RELIABILITY_256[187] = 8'd199;
    assign RELIABILITY_256[188] = 8'd179;
    assign RELIABILITY_256[189] = 8'd228;
    assign RELIABILITY_256[190] = 8'd174;
    assign RELIABILITY_256[191] = 8'd122;
    assign RELIABILITY_256[192] = 8'd203;
    assign RELIABILITY_256[193] = 8'd63 ;
    assign RELIABILITY_256[194] = 8'd181;
    assign RELIABILITY_256[195] = 8'd232;
    assign RELIABILITY_256[196] = 8'd124;
    assign RELIABILITY_256[197] = 8'd205;
    assign RELIABILITY_256[198] = 8'd182;
    assign RELIABILITY_256[199] = 8'd211;
    assign RELIABILITY_256[200] = 8'd185;
    assign RELIABILITY_256[201] = 8'd240;
    assign RELIABILITY_256[202] = 8'd206;
    assign RELIABILITY_256[203] = 8'd95 ;
    assign RELIABILITY_256[204] = 8'd213;
    assign RELIABILITY_256[205] = 8'd186;
    assign RELIABILITY_256[206] = 8'd227;
    assign RELIABILITY_256[207] = 8'd111;
    assign RELIABILITY_256[208] = 8'd214;
    assign RELIABILITY_256[209] = 8'd188;
    assign RELIABILITY_256[210] = 8'd217;
    assign RELIABILITY_256[211] = 8'd229;
    assign RELIABILITY_256[212] = 8'd159;
    assign RELIABILITY_256[213] = 8'd119;
    assign RELIABILITY_256[214] = 8'd218;
    assign RELIABILITY_256[215] = 8'd230;
    assign RELIABILITY_256[216] = 8'd233;
    assign RELIABILITY_256[217] = 8'd175;
    assign RELIABILITY_256[218] = 8'd123;
    assign RELIABILITY_256[219] = 8'd220;
    assign RELIABILITY_256[220] = 8'd183;
    assign RELIABILITY_256[221] = 8'd234;
    assign RELIABILITY_256[222] = 8'd125;
    assign RELIABILITY_256[223] = 8'd241;
    assign RELIABILITY_256[224] = 8'd207;
    assign RELIABILITY_256[225] = 8'd187;
    assign RELIABILITY_256[226] = 8'd236;
    assign RELIABILITY_256[227] = 8'd126;
    assign RELIABILITY_256[228] = 8'd242;
    assign RELIABILITY_256[229] = 8'd244;
    assign RELIABILITY_256[230] = 8'd189;
    assign RELIABILITY_256[231] = 8'd215;
    assign RELIABILITY_256[232] = 8'd219;
    assign RELIABILITY_256[233] = 8'd231;
    assign RELIABILITY_256[234] = 8'd248;
    assign RELIABILITY_256[235] = 8'd190;
    assign RELIABILITY_256[236] = 8'd221;
    assign RELIABILITY_256[237] = 8'd235;
    assign RELIABILITY_256[238] = 8'd222;
    assign RELIABILITY_256[239] = 8'd237;
    assign RELIABILITY_256[240] = 8'd243;
    assign RELIABILITY_256[241] = 8'd238;
    assign RELIABILITY_256[242] = 8'd245;
    assign RELIABILITY_256[243] = 8'd127;
    assign RELIABILITY_256[244] = 8'd191;
    assign RELIABILITY_256[245] = 8'd246;
    assign RELIABILITY_256[246] = 8'd249;
    assign RELIABILITY_256[247] = 8'd250;
    assign RELIABILITY_256[248] = 8'd252;
    assign RELIABILITY_256[249] = 8'd223;
    assign RELIABILITY_256[250] = 8'd239;
    assign RELIABILITY_256[251] = 8'd251;
    assign RELIABILITY_256[252] = 8'd247;
    assign RELIABILITY_256[253] = 8'd253;
    assign RELIABILITY_256[254] = 8'd254;
    assign RELIABILITY_256[255] = 8'd255;
    
    assign RELIABILITY_512[  0] = 9'd0  ;
    assign RELIABILITY_512[  1] = 9'd1  ;
    assign RELIABILITY_512[  2] = 9'd2  ;
    assign RELIABILITY_512[  3] = 9'd4  ;
    assign RELIABILITY_512[  4] = 9'd8  ;
    assign RELIABILITY_512[  5] = 9'd16 ;
    assign RELIABILITY_512[  6] = 9'd32 ;
    assign RELIABILITY_512[  7] = 9'd3  ;
    assign RELIABILITY_512[  8] = 9'd5  ;
    assign RELIABILITY_512[  9] = 9'd64 ;
    assign RELIABILITY_512[ 10] = 9'd9  ;
    assign RELIABILITY_512[ 11] = 9'd6  ;
    assign RELIABILITY_512[ 12] = 9'd17 ;
    assign RELIABILITY_512[ 13] = 9'd10 ;
    assign RELIABILITY_512[ 14] = 9'd18 ;
    assign RELIABILITY_512[ 15] = 9'd128;
    assign RELIABILITY_512[ 16] = 9'd12 ;
    assign RELIABILITY_512[ 17] = 9'd33 ;
    assign RELIABILITY_512[ 18] = 9'd65 ;
    assign RELIABILITY_512[ 19] = 9'd20 ;
    assign RELIABILITY_512[ 20] = 9'd256;
    assign RELIABILITY_512[ 21] = 9'd34 ;
    assign RELIABILITY_512[ 22] = 9'd24 ;
    assign RELIABILITY_512[ 23] = 9'd36 ;
    assign RELIABILITY_512[ 24] = 9'd7  ;
    assign RELIABILITY_512[ 25] = 9'd129;
    assign RELIABILITY_512[ 26] = 9'd66 ;
    assign RELIABILITY_512[ 27] = 9'd11 ;
    assign RELIABILITY_512[ 28] = 9'd40 ;
    assign RELIABILITY_512[ 29] = 9'd68 ;
    assign RELIABILITY_512[ 30] = 9'd130;
    assign RELIABILITY_512[ 31] = 9'd19 ;
    assign RELIABILITY_512[ 32] = 9'd13 ;
    assign RELIABILITY_512[ 33] = 9'd48 ;
    assign RELIABILITY_512[ 34] = 9'd14 ;
    assign RELIABILITY_512[ 35] = 9'd72 ;
    assign RELIABILITY_512[ 36] = 9'd257;
    assign RELIABILITY_512[ 37] = 9'd21 ;
    assign RELIABILITY_512[ 38] = 9'd132;
    assign RELIABILITY_512[ 39] = 9'd35 ;
    assign RELIABILITY_512[ 40] = 9'd258;
    assign RELIABILITY_512[ 41] = 9'd26 ;
    assign RELIABILITY_512[ 42] = 9'd80 ;
    assign RELIABILITY_512[ 43] = 9'd37 ;
    assign RELIABILITY_512[ 44] = 9'd25 ;
    assign RELIABILITY_512[ 45] = 9'd22 ;
    assign RELIABILITY_512[ 46] = 9'd136;
    assign RELIABILITY_512[ 47] = 9'd260;
    assign RELIABILITY_512[ 48] = 9'd264;
    assign RELIABILITY_512[ 49] = 9'd38 ;
    assign RELIABILITY_512[ 50] = 9'd96 ;
    assign RELIABILITY_512[ 51] = 9'd67 ;
    assign RELIABILITY_512[ 52] = 9'd41 ;
    assign RELIABILITY_512[ 53] = 9'd144;
    assign RELIABILITY_512[ 54] = 9'd28 ;
    assign RELIABILITY_512[ 55] = 9'd69 ;
    assign RELIABILITY_512[ 56] = 9'd42 ;
    assign RELIABILITY_512[ 57] = 9'd49 ;
    assign RELIABILITY_512[ 58] = 9'd74 ;
    assign RELIABILITY_512[ 59] = 9'd272;
    assign RELIABILITY_512[ 60] = 9'd160;
    assign RELIABILITY_512[ 61] = 9'd288;
    assign RELIABILITY_512[ 62] = 9'd192;
    assign RELIABILITY_512[ 63] = 9'd70 ;
    assign RELIABILITY_512[ 64] = 9'd44 ;
    assign RELIABILITY_512[ 65] = 9'd131;
    assign RELIABILITY_512[ 66] = 9'd81 ;
    assign RELIABILITY_512[ 67] = 9'd50 ;
    assign RELIABILITY_512[ 68] = 9'd73 ;
    assign RELIABILITY_512[ 69] = 9'd15 ;
    assign RELIABILITY_512[ 70] = 9'd320;
    assign RELIABILITY_512[ 71] = 9'd133;
    assign RELIABILITY_512[ 72] = 9'd52 ;
    assign RELIABILITY_512[ 73] = 9'd23 ;
    assign RELIABILITY_512[ 74] = 9'd134;
    assign RELIABILITY_512[ 75] = 9'd384;
    assign RELIABILITY_512[ 76] = 9'd76 ;
    assign RELIABILITY_512[ 77] = 9'd137;
    assign RELIABILITY_512[ 78] = 9'd82 ;
    assign RELIABILITY_512[ 79] = 9'd56 ;
    assign RELIABILITY_512[ 80] = 9'd27 ;
    assign RELIABILITY_512[ 81] = 9'd97 ;
    assign RELIABILITY_512[ 82] = 9'd39 ;
    assign RELIABILITY_512[ 83] = 9'd259;
    assign RELIABILITY_512[ 84] = 9'd84 ;
    assign RELIABILITY_512[ 85] = 9'd138;
    assign RELIABILITY_512[ 86] = 9'd145;
    assign RELIABILITY_512[ 87] = 9'd261;
    assign RELIABILITY_512[ 88] = 9'd29 ;
    assign RELIABILITY_512[ 89] = 9'd43 ;
    assign RELIABILITY_512[ 90] = 9'd98 ;
    assign RELIABILITY_512[ 91] = 9'd88 ;
    assign RELIABILITY_512[ 92] = 9'd140;
    assign RELIABILITY_512[ 93] = 9'd30 ;
    assign RELIABILITY_512[ 94] = 9'd146;
    assign RELIABILITY_512[ 95] = 9'd71 ;
    assign RELIABILITY_512[ 96] = 9'd262;
    assign RELIABILITY_512[ 97] = 9'd265;
    assign RELIABILITY_512[ 98] = 9'd161;
    assign RELIABILITY_512[ 99] = 9'd45 ;
    assign RELIABILITY_512[100] = 9'd100;
    assign RELIABILITY_512[101] = 9'd51 ;
    assign RELIABILITY_512[102] = 9'd148;
    assign RELIABILITY_512[103] = 9'd46 ;
    assign RELIABILITY_512[104] = 9'd75 ;
    assign RELIABILITY_512[105] = 9'd266;
    assign RELIABILITY_512[106] = 9'd273;
    assign RELIABILITY_512[107] = 9'd104;
    assign RELIABILITY_512[108] = 9'd162;
    assign RELIABILITY_512[109] = 9'd53 ;
    assign RELIABILITY_512[110] = 9'd193;
    assign RELIABILITY_512[111] = 9'd152;
    assign RELIABILITY_512[112] = 9'd77 ;
    assign RELIABILITY_512[113] = 9'd164;
    assign RELIABILITY_512[114] = 9'd268;
    assign RELIABILITY_512[115] = 9'd274;
    assign RELIABILITY_512[116] = 9'd54 ;
    assign RELIABILITY_512[117] = 9'd83 ;
    assign RELIABILITY_512[118] = 9'd57 ;
    assign RELIABILITY_512[119] = 9'd112;
    assign RELIABILITY_512[120] = 9'd135;
    assign RELIABILITY_512[121] = 9'd78 ;
    assign RELIABILITY_512[122] = 9'd289;
    assign RELIABILITY_512[123] = 9'd194;
    assign RELIABILITY_512[124] = 9'd85 ;
    assign RELIABILITY_512[125] = 9'd276;
    assign RELIABILITY_512[126] = 9'd58 ;
    assign RELIABILITY_512[127] = 9'd168;
    assign RELIABILITY_512[128] = 9'd139;
    assign RELIABILITY_512[129] = 9'd99 ;
    assign RELIABILITY_512[130] = 9'd86 ;
    assign RELIABILITY_512[131] = 9'd60 ;
    assign RELIABILITY_512[132] = 9'd280;
    assign RELIABILITY_512[133] = 9'd89 ;
    assign RELIABILITY_512[134] = 9'd290;
    assign RELIABILITY_512[135] = 9'd196;
    assign RELIABILITY_512[136] = 9'd141;
    assign RELIABILITY_512[137] = 9'd101;
    assign RELIABILITY_512[138] = 9'd147;
    assign RELIABILITY_512[139] = 9'd176;
    assign RELIABILITY_512[140] = 9'd142;
    assign RELIABILITY_512[141] = 9'd321;
    assign RELIABILITY_512[142] = 9'd31 ;
    assign RELIABILITY_512[143] = 9'd200;
    assign RELIABILITY_512[144] = 9'd90 ;
    assign RELIABILITY_512[145] = 9'd292;
    assign RELIABILITY_512[146] = 9'd322;
    assign RELIABILITY_512[147] = 9'd263;
    assign RELIABILITY_512[148] = 9'd149;
    assign RELIABILITY_512[149] = 9'd102;
    assign RELIABILITY_512[150] = 9'd105;
    assign RELIABILITY_512[151] = 9'd304;
    assign RELIABILITY_512[152] = 9'd296;
    assign RELIABILITY_512[153] = 9'd163;
    assign RELIABILITY_512[154] = 9'd92 ;
    assign RELIABILITY_512[155] = 9'd47 ;
    assign RELIABILITY_512[156] = 9'd267;
    assign RELIABILITY_512[157] = 9'd385;
    assign RELIABILITY_512[158] = 9'd324;
    assign RELIABILITY_512[159] = 9'd208;
    assign RELIABILITY_512[160] = 9'd386;
    assign RELIABILITY_512[161] = 9'd150;
    assign RELIABILITY_512[162] = 9'd153;
    assign RELIABILITY_512[163] = 9'd165;
    assign RELIABILITY_512[164] = 9'd106;
    assign RELIABILITY_512[165] = 9'd55 ;
    assign RELIABILITY_512[166] = 9'd328;
    assign RELIABILITY_512[167] = 9'd113;
    assign RELIABILITY_512[168] = 9'd154;
    assign RELIABILITY_512[169] = 9'd79 ;
    assign RELIABILITY_512[170] = 9'd269;
    assign RELIABILITY_512[171] = 9'd108;
    assign RELIABILITY_512[172] = 9'd224;
    assign RELIABILITY_512[173] = 9'd166;
    assign RELIABILITY_512[174] = 9'd195;
    assign RELIABILITY_512[175] = 9'd270;
    assign RELIABILITY_512[176] = 9'd275;
    assign RELIABILITY_512[177] = 9'd291;
    assign RELIABILITY_512[178] = 9'd59 ;
    assign RELIABILITY_512[179] = 9'd169;
    assign RELIABILITY_512[180] = 9'd114;
    assign RELIABILITY_512[181] = 9'd277;
    assign RELIABILITY_512[182] = 9'd156;
    assign RELIABILITY_512[183] = 9'd87 ;
    assign RELIABILITY_512[184] = 9'd197;
    assign RELIABILITY_512[185] = 9'd116;
    assign RELIABILITY_512[186] = 9'd170;
    assign RELIABILITY_512[187] = 9'd61 ;
    assign RELIABILITY_512[188] = 9'd281;
    assign RELIABILITY_512[189] = 9'd278;
    assign RELIABILITY_512[190] = 9'd177;
    assign RELIABILITY_512[191] = 9'd293;
    assign RELIABILITY_512[192] = 9'd388;
    assign RELIABILITY_512[193] = 9'd91 ;
    assign RELIABILITY_512[194] = 9'd198;
    assign RELIABILITY_512[195] = 9'd172;
    assign RELIABILITY_512[196] = 9'd120;
    assign RELIABILITY_512[197] = 9'd201;
    assign RELIABILITY_512[198] = 9'd336;
    assign RELIABILITY_512[199] = 9'd62 ;
    assign RELIABILITY_512[200] = 9'd282;
    assign RELIABILITY_512[201] = 9'd143;
    assign RELIABILITY_512[202] = 9'd103;
    assign RELIABILITY_512[203] = 9'd178;
    assign RELIABILITY_512[204] = 9'd294;
    assign RELIABILITY_512[205] = 9'd93 ;
    assign RELIABILITY_512[206] = 9'd202;
    assign RELIABILITY_512[207] = 9'd323;
    assign RELIABILITY_512[208] = 9'd392;
    assign RELIABILITY_512[209] = 9'd297;
    assign RELIABILITY_512[210] = 9'd107;
    assign RELIABILITY_512[211] = 9'd180;
    assign RELIABILITY_512[212] = 9'd151;
    assign RELIABILITY_512[213] = 9'd209;
    assign RELIABILITY_512[214] = 9'd284;
    assign RELIABILITY_512[215] = 9'd94 ;
    assign RELIABILITY_512[216] = 9'd204;
    assign RELIABILITY_512[217] = 9'd298;
    assign RELIABILITY_512[218] = 9'd400;
    assign RELIABILITY_512[219] = 9'd352;
    assign RELIABILITY_512[220] = 9'd325;
    assign RELIABILITY_512[221] = 9'd155;
    assign RELIABILITY_512[222] = 9'd210;
    assign RELIABILITY_512[223] = 9'd305;
    assign RELIABILITY_512[224] = 9'd300;
    assign RELIABILITY_512[225] = 9'd109;
    assign RELIABILITY_512[226] = 9'd184;
    assign RELIABILITY_512[227] = 9'd115;
    assign RELIABILITY_512[228] = 9'd167;
    assign RELIABILITY_512[229] = 9'd225;
    assign RELIABILITY_512[230] = 9'd326;
    assign RELIABILITY_512[231] = 9'd306;
    assign RELIABILITY_512[232] = 9'd157;
    assign RELIABILITY_512[233] = 9'd329;
    assign RELIABILITY_512[234] = 9'd110;
    assign RELIABILITY_512[235] = 9'd117;
    assign RELIABILITY_512[236] = 9'd212;
    assign RELIABILITY_512[237] = 9'd171;
    assign RELIABILITY_512[238] = 9'd330;
    assign RELIABILITY_512[239] = 9'd226;
    assign RELIABILITY_512[240] = 9'd387;
    assign RELIABILITY_512[241] = 9'd308;
    assign RELIABILITY_512[242] = 9'd216;
    assign RELIABILITY_512[243] = 9'd416;
    assign RELIABILITY_512[244] = 9'd271;
    assign RELIABILITY_512[245] = 9'd279;
    assign RELIABILITY_512[246] = 9'd158;
    assign RELIABILITY_512[247] = 9'd337;
    assign RELIABILITY_512[248] = 9'd118;
    assign RELIABILITY_512[249] = 9'd332;
    assign RELIABILITY_512[250] = 9'd389;
    assign RELIABILITY_512[251] = 9'd173;
    assign RELIABILITY_512[252] = 9'd121;
    assign RELIABILITY_512[253] = 9'd199;
    assign RELIABILITY_512[254] = 9'd179;
    assign RELIABILITY_512[255] = 9'd228;
    assign RELIABILITY_512[256] = 9'd338;
    assign RELIABILITY_512[257] = 9'd312;
    assign RELIABILITY_512[258] = 9'd390;
    assign RELIABILITY_512[259] = 9'd174;
    assign RELIABILITY_512[260] = 9'd393;
    assign RELIABILITY_512[261] = 9'd283;
    assign RELIABILITY_512[262] = 9'd122;
    assign RELIABILITY_512[263] = 9'd448;
    assign RELIABILITY_512[264] = 9'd353;
    assign RELIABILITY_512[265] = 9'd203;
    assign RELIABILITY_512[266] = 9'd63 ;
    assign RELIABILITY_512[267] = 9'd340;
    assign RELIABILITY_512[268] = 9'd394;
    assign RELIABILITY_512[269] = 9'd181;
    assign RELIABILITY_512[270] = 9'd295;
    assign RELIABILITY_512[271] = 9'd285;
    assign RELIABILITY_512[272] = 9'd232;
    assign RELIABILITY_512[273] = 9'd124;
    assign RELIABILITY_512[274] = 9'd205;
    assign RELIABILITY_512[275] = 9'd182;
    assign RELIABILITY_512[276] = 9'd286;
    assign RELIABILITY_512[277] = 9'd299;
    assign RELIABILITY_512[278] = 9'd354;
    assign RELIABILITY_512[279] = 9'd211;
    assign RELIABILITY_512[280] = 9'd401;
    assign RELIABILITY_512[281] = 9'd185;
    assign RELIABILITY_512[282] = 9'd396;
    assign RELIABILITY_512[283] = 9'd344;
    assign RELIABILITY_512[284] = 9'd240;
    assign RELIABILITY_512[285] = 9'd206;
    assign RELIABILITY_512[286] = 9'd95 ;
    assign RELIABILITY_512[287] = 9'd327;
    assign RELIABILITY_512[288] = 9'd402;
    assign RELIABILITY_512[289] = 9'd356;
    assign RELIABILITY_512[290] = 9'd307;
    assign RELIABILITY_512[291] = 9'd301;
    assign RELIABILITY_512[292] = 9'd417;
    assign RELIABILITY_512[293] = 9'd213;
    assign RELIABILITY_512[294] = 9'd186;
    assign RELIABILITY_512[295] = 9'd404;
    assign RELIABILITY_512[296] = 9'd227;
    assign RELIABILITY_512[297] = 9'd418;
    assign RELIABILITY_512[298] = 9'd302;
    assign RELIABILITY_512[299] = 9'd360;
    assign RELIABILITY_512[300] = 9'd111;
    assign RELIABILITY_512[301] = 9'd331;
    assign RELIABILITY_512[302] = 9'd214;
    assign RELIABILITY_512[303] = 9'd309;
    assign RELIABILITY_512[304] = 9'd188;
    assign RELIABILITY_512[305] = 9'd449;
    assign RELIABILITY_512[306] = 9'd217;
    assign RELIABILITY_512[307] = 9'd408;
    assign RELIABILITY_512[308] = 9'd229;
    assign RELIABILITY_512[309] = 9'd159;
    assign RELIABILITY_512[310] = 9'd420;
    assign RELIABILITY_512[311] = 9'd310;
    assign RELIABILITY_512[312] = 9'd333;
    assign RELIABILITY_512[313] = 9'd119;
    assign RELIABILITY_512[314] = 9'd339;
    assign RELIABILITY_512[315] = 9'd218;
    assign RELIABILITY_512[316] = 9'd368;
    assign RELIABILITY_512[317] = 9'd230;
    assign RELIABILITY_512[318] = 9'd391;
    assign RELIABILITY_512[319] = 9'd313;
    assign RELIABILITY_512[320] = 9'd450;
    assign RELIABILITY_512[321] = 9'd334;
    assign RELIABILITY_512[322] = 9'd233;
    assign RELIABILITY_512[323] = 9'd175;
    assign RELIABILITY_512[324] = 9'd123;
    assign RELIABILITY_512[325] = 9'd341;
    assign RELIABILITY_512[326] = 9'd220;
    assign RELIABILITY_512[327] = 9'd314;
    assign RELIABILITY_512[328] = 9'd424;
    assign RELIABILITY_512[329] = 9'd395;
    assign RELIABILITY_512[330] = 9'd355;
    assign RELIABILITY_512[331] = 9'd287;
    assign RELIABILITY_512[332] = 9'd183;
    assign RELIABILITY_512[333] = 9'd234;
    assign RELIABILITY_512[334] = 9'd125;
    assign RELIABILITY_512[335] = 9'd342;
    assign RELIABILITY_512[336] = 9'd316;
    assign RELIABILITY_512[337] = 9'd241;
    assign RELIABILITY_512[338] = 9'd345;
    assign RELIABILITY_512[339] = 9'd452;
    assign RELIABILITY_512[340] = 9'd397;
    assign RELIABILITY_512[341] = 9'd403;
    assign RELIABILITY_512[342] = 9'd207;
    assign RELIABILITY_512[343] = 9'd432;
    assign RELIABILITY_512[344] = 9'd357;
    assign RELIABILITY_512[345] = 9'd187;
    assign RELIABILITY_512[346] = 9'd236;
    assign RELIABILITY_512[347] = 9'd126;
    assign RELIABILITY_512[348] = 9'd242;
    assign RELIABILITY_512[349] = 9'd398;
    assign RELIABILITY_512[350] = 9'd346;
    assign RELIABILITY_512[351] = 9'd456;
    assign RELIABILITY_512[352] = 9'd358;
    assign RELIABILITY_512[353] = 9'd405;
    assign RELIABILITY_512[354] = 9'd303;
    assign RELIABILITY_512[355] = 9'd244;
    assign RELIABILITY_512[356] = 9'd189;
    assign RELIABILITY_512[357] = 9'd361;
    assign RELIABILITY_512[358] = 9'd215;
    assign RELIABILITY_512[359] = 9'd348;
    assign RELIABILITY_512[360] = 9'd419;
    assign RELIABILITY_512[361] = 9'd406;
    assign RELIABILITY_512[362] = 9'd464;
    assign RELIABILITY_512[363] = 9'd362;
    assign RELIABILITY_512[364] = 9'd409;
    assign RELIABILITY_512[365] = 9'd219;
    assign RELIABILITY_512[366] = 9'd311;
    assign RELIABILITY_512[367] = 9'd421;
    assign RELIABILITY_512[368] = 9'd410;
    assign RELIABILITY_512[369] = 9'd231;
    assign RELIABILITY_512[370] = 9'd248;
    assign RELIABILITY_512[371] = 9'd369;
    assign RELIABILITY_512[372] = 9'd190;
    assign RELIABILITY_512[373] = 9'd364;
    assign RELIABILITY_512[374] = 9'd335;
    assign RELIABILITY_512[375] = 9'd480;
    assign RELIABILITY_512[376] = 9'd315;
    assign RELIABILITY_512[377] = 9'd221;
    assign RELIABILITY_512[378] = 9'd370;
    assign RELIABILITY_512[379] = 9'd422;
    assign RELIABILITY_512[380] = 9'd425;
    assign RELIABILITY_512[381] = 9'd451;
    assign RELIABILITY_512[382] = 9'd235;
    assign RELIABILITY_512[383] = 9'd412;
    assign RELIABILITY_512[384] = 9'd343;
    assign RELIABILITY_512[385] = 9'd372;
    assign RELIABILITY_512[386] = 9'd317;
    assign RELIABILITY_512[387] = 9'd222;
    assign RELIABILITY_512[388] = 9'd426;
    assign RELIABILITY_512[389] = 9'd453;
    assign RELIABILITY_512[390] = 9'd237;
    assign RELIABILITY_512[391] = 9'd433;
    assign RELIABILITY_512[392] = 9'd347;
    assign RELIABILITY_512[393] = 9'd243;
    assign RELIABILITY_512[394] = 9'd454;
    assign RELIABILITY_512[395] = 9'd318;
    assign RELIABILITY_512[396] = 9'd376;
    assign RELIABILITY_512[397] = 9'd428;
    assign RELIABILITY_512[398] = 9'd238;
    assign RELIABILITY_512[399] = 9'd359;
    assign RELIABILITY_512[400] = 9'd457;
    assign RELIABILITY_512[401] = 9'd399;
    assign RELIABILITY_512[402] = 9'd434;
    assign RELIABILITY_512[403] = 9'd349;
    assign RELIABILITY_512[404] = 9'd245;
    assign RELIABILITY_512[405] = 9'd458;
    assign RELIABILITY_512[406] = 9'd363;
    assign RELIABILITY_512[407] = 9'd127;
    assign RELIABILITY_512[408] = 9'd191;
    assign RELIABILITY_512[409] = 9'd407;
    assign RELIABILITY_512[410] = 9'd436;
    assign RELIABILITY_512[411] = 9'd465;
    assign RELIABILITY_512[412] = 9'd246;
    assign RELIABILITY_512[413] = 9'd350;
    assign RELIABILITY_512[414] = 9'd460;
    assign RELIABILITY_512[415] = 9'd249;
    assign RELIABILITY_512[416] = 9'd411;
    assign RELIABILITY_512[417] = 9'd365;
    assign RELIABILITY_512[418] = 9'd440;
    assign RELIABILITY_512[419] = 9'd374;
    assign RELIABILITY_512[420] = 9'd423;
    assign RELIABILITY_512[421] = 9'd466;
    assign RELIABILITY_512[422] = 9'd250;
    assign RELIABILITY_512[423] = 9'd371;
    assign RELIABILITY_512[424] = 9'd481;
    assign RELIABILITY_512[425] = 9'd413;
    assign RELIABILITY_512[426] = 9'd366;
    assign RELIABILITY_512[427] = 9'd468;
    assign RELIABILITY_512[428] = 9'd429;
    assign RELIABILITY_512[429] = 9'd252;
    assign RELIABILITY_512[430] = 9'd373;
    assign RELIABILITY_512[431] = 9'd482;
    assign RELIABILITY_512[432] = 9'd427;
    assign RELIABILITY_512[433] = 9'd414;
    assign RELIABILITY_512[434] = 9'd223;
    assign RELIABILITY_512[435] = 9'd472;
    assign RELIABILITY_512[436] = 9'd455;
    assign RELIABILITY_512[437] = 9'd377;
    assign RELIABILITY_512[438] = 9'd435;
    assign RELIABILITY_512[439] = 9'd319;
    assign RELIABILITY_512[440] = 9'd484;
    assign RELIABILITY_512[441] = 9'd430;
    assign RELIABILITY_512[442] = 9'd488;
    assign RELIABILITY_512[443] = 9'd239;
    assign RELIABILITY_512[444] = 9'd378;
    assign RELIABILITY_512[445] = 9'd459;
    assign RELIABILITY_512[446] = 9'd437;
    assign RELIABILITY_512[447] = 9'd380;
    assign RELIABILITY_512[448] = 9'd461;
    assign RELIABILITY_512[449] = 9'd496;
    assign RELIABILITY_512[450] = 9'd351;
    assign RELIABILITY_512[451] = 9'd467;
    assign RELIABILITY_512[452] = 9'd438;
    assign RELIABILITY_512[453] = 9'd251;
    assign RELIABILITY_512[454] = 9'd462;
    assign RELIABILITY_512[455] = 9'd442;
    assign RELIABILITY_512[456] = 9'd441;
    assign RELIABILITY_512[457] = 9'd469;
    assign RELIABILITY_512[458] = 9'd247;
    assign RELIABILITY_512[459] = 9'd367;
    assign RELIABILITY_512[460] = 9'd253;
    assign RELIABILITY_512[461] = 9'd375;
    assign RELIABILITY_512[462] = 9'd444;
    assign RELIABILITY_512[463] = 9'd470;
    assign RELIABILITY_512[464] = 9'd483;
    assign RELIABILITY_512[465] = 9'd415;
    assign RELIABILITY_512[466] = 9'd485;
    assign RELIABILITY_512[467] = 9'd473;
    assign RELIABILITY_512[468] = 9'd474;
    assign RELIABILITY_512[469] = 9'd254;
    assign RELIABILITY_512[470] = 9'd379;
    assign RELIABILITY_512[471] = 9'd431;
    assign RELIABILITY_512[472] = 9'd489;
    assign RELIABILITY_512[473] = 9'd486;
    assign RELIABILITY_512[474] = 9'd476;
    assign RELIABILITY_512[475] = 9'd439;
    assign RELIABILITY_512[476] = 9'd490;
    assign RELIABILITY_512[477] = 9'd463;
    assign RELIABILITY_512[478] = 9'd381;
    assign RELIABILITY_512[479] = 9'd497;
    assign RELIABILITY_512[480] = 9'd492;
    assign RELIABILITY_512[481] = 9'd443;
    assign RELIABILITY_512[482] = 9'd382;
    assign RELIABILITY_512[483] = 9'd498;
    assign RELIABILITY_512[484] = 9'd445;
    assign RELIABILITY_512[485] = 9'd471;
    assign RELIABILITY_512[486] = 9'd500;
    assign RELIABILITY_512[487] = 9'd446;
    assign RELIABILITY_512[488] = 9'd475;
    assign RELIABILITY_512[489] = 9'd487;
    assign RELIABILITY_512[490] = 9'd504;
    assign RELIABILITY_512[491] = 9'd255;
    assign RELIABILITY_512[492] = 9'd477;
    assign RELIABILITY_512[493] = 9'd491;
    assign RELIABILITY_512[494] = 9'd478;
    assign RELIABILITY_512[495] = 9'd383;
    assign RELIABILITY_512[496] = 9'd493;
    assign RELIABILITY_512[497] = 9'd499;
    assign RELIABILITY_512[498] = 9'd502;
    assign RELIABILITY_512[499] = 9'd494;
    assign RELIABILITY_512[500] = 9'd501;
    assign RELIABILITY_512[501] = 9'd447;
    assign RELIABILITY_512[502] = 9'd505;
    assign RELIABILITY_512[503] = 9'd506;
    assign RELIABILITY_512[504] = 9'd479;
    assign RELIABILITY_512[505] = 9'd508;
    assign RELIABILITY_512[506] = 9'd495;
    assign RELIABILITY_512[507] = 9'd503;
    assign RELIABILITY_512[508] = 9'd507;
    assign RELIABILITY_512[509] = 9'd509;
    assign RELIABILITY_512[510] = 9'd510;
    assign RELIABILITY_512[511] = 9'd511;

endmodule