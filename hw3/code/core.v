
module core (                       //Don't modify interface
	input         i_clk,
	input         i_rst_n,
	input         i_op_valid,
	input  [ 3:0] i_op_mode,
    output        o_op_ready,
	input         i_in_valid,
	input  [ 7:0] i_in_data,
	output        o_in_ready,
	output        o_out_valid,
	output [12:0] o_out_data
);
  
  reg        op_ready_reg;
  reg        in_ready_reg;
  reg        out_valid_reg;
  reg [12:0] out_data_reg;
  
  assign o_op_ready = op_ready_reg;
  assign o_in_ready = in_ready_reg;
  assign o_out_valid = out_valid_reg;
  assign o_out_data = out_data_reg;
  
  reg [2:0] state;
  reg [2:0] n_state;
  reg [2:0] row;
  reg [2:0] col;
  reg [2:0] row_t;
  reg [2:0] col_t;
  reg [3:0] depth;
  reg [7:0] addr_SRAM;
  reg [8:0] counter;
  reg [7:0] sram_wen;
  reg       outside;
  reg       outside_pipeline_1;
  reg [2:0] addr_incre;
  
  reg [2:0] change_output;
  reg       o_out_valid_pipeline_1;
  reg       o_out_valid_pipeline_2;
  reg       o_out_valid_pipeline_3;
  reg       have_load;
  
  wire [7:0] sram_Q0;
  wire [7:0] sram_Q1;
  wire [7:0] sram_Q2;
  wire [7:0] sram_Q3;
  wire [7:0] sram_Q4;
  wire [7:0] sram_Q5;
  wire [7:0] sram_Q6;
  wire [7:0] sram_Q7;
  
  reg [7:0] add_i_0;
  reg [7:0] add_i_1;
  reg [7:0] add_i_2;
  reg [7:0] add_i_3;
  reg [7:0] add_i_4;
  reg [7:0] add_i_5;
  reg [7:0] add_i_6;
  reg [7:0] add_i_7;
  
  wire [8:0] temp0;
  wire [8:0] temp1;
  wire [8:0] temp2;
  wire [8:0] temp3;
  
  reg [9:0] temp4;
  reg [9:0] temp5;
  
  wire [10:0] answer;
  
  parameter RST        = 3'b000,
            READY      = 3'b001,
            GET        = 3'b010,
            LOAD       = 3'b011,
            DISPALY    = 3'b100,
            CONV       = 3'b101,
            WAIT       = 3'b110,
            WAIT_3     = 3'b111;
  //////////////////////////////////////////////// 8 SRAM //////////////////////////////////////////////////
  sram_256x8 sram0(.Q  (sram_Q0),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[0] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  
  sram_256x8 sram1(.Q  (sram_Q1),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[1] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  
  sram_256x8 sram2(.Q  (sram_Q2),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[2] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  
  sram_256x8 sram3(.Q  (sram_Q3),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[3] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  
  sram_256x8 sram4(.Q  (sram_Q4),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[4] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  
  sram_256x8 sram5(.Q  (sram_Q5),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[5] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  
  sram_256x8 sram6(.Q  (sram_Q6),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[6] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  
  sram_256x8 sram7(.Q  (sram_Q7),
                   .CLK(i_clk),
                   .CEN(1'b0),
                   .WEN(~(~sram_wen[7] && i_in_valid)),
                   .A  (addr_SRAM),
                   .D  (i_in_data));
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  ////////////////////////////// compute convolution ADDER TREE with pipeline ///////////////////////////////////////////////
  always@(posedge i_clk)begin
    if(outside || counter==9'd0)begin
      add_i_0 <= 8'd0;
      add_i_1 <= 8'd0;
      add_i_2 <= 8'd0;
      add_i_3 <= 8'd0;
      add_i_4 <= 8'd0;
      add_i_5 <= 8'd0;
      add_i_6 <= 8'd0;
      add_i_7 <= 8'd0;
    end else begin
      add_i_0 <= sram_Q0;
      add_i_1 <= sram_Q1;
      add_i_2 <= sram_Q2;
      add_i_3 <= sram_Q3;
      add_i_4 <= sram_Q4;
      add_i_5 <= sram_Q5;
      add_i_6 <= sram_Q6;
      add_i_7 <= sram_Q7;
    end
  end
  /*
  always@(*)begin
    if(outside && counter!=9'd0)begin
      add_i_0 = 10'd0;
      add_i_1 = 10'd0;
      add_i_2 = 10'd0;
      add_i_3 = 10'd0;
      add_i_4 = 10'd0;
      add_i_5 = 10'd0;
      add_i_6 = 10'd0;
      add_i_7 = 10'd0;
    end else if(~counter[0])begin
      add_i_0 = {1'b0, sram_Q0, 1'b0};
      add_i_1 = {1'b0, sram_Q1, 1'b0};
      add_i_2 = {1'b0, sram_Q2, 1'b0};
      add_i_3 = {1'b0, sram_Q3, 1'b0};
      add_i_4 = {1'b0, sram_Q4, 1'b0};
      add_i_5 = {1'b0, sram_Q5, 1'b0};
      add_i_6 = {1'b0, sram_Q6, 1'b0};
      add_i_7 = {1'b0, sram_Q7, 1'b0};
    end else if(counter[2:0]==3'd5)begin
      add_i_0 = {sram_Q0, 2'b0};
      add_i_1 = {sram_Q1, 2'b0};
      add_i_2 = {sram_Q2, 2'b0};
      add_i_3 = {sram_Q3, 2'b0};
      add_i_4 = {sram_Q4, 2'b0};
      add_i_5 = {sram_Q5, 2'b0};
      add_i_6 = {sram_Q6, 2'b0};
      add_i_7 = {sram_Q7, 2'b0};
    end else begin
      add_i_0 = {2'b0, sram_Q0};
      add_i_1 = {2'b0, sram_Q1};
      add_i_2 = {2'b0, sram_Q2};
      add_i_3 = {2'b0, sram_Q3};
      add_i_4 = {2'b0, sram_Q4};
      add_i_5 = {2'b0, sram_Q5};
      add_i_6 = {2'b0, sram_Q6};
      add_i_7 = {2'b0, sram_Q7};
    end
  end
  */
  
  assign temp0 = add_i_0 + add_i_1;
  assign temp1 = add_i_2 + add_i_3;
  assign temp2 = add_i_4 + add_i_5;
  assign temp3 = add_i_6 + add_i_7;
  /*
  always@(posedge i_clk)begin
    if(counter==9'd0)begin
      temp0 <= 9'd0;
      temp1 <= 9'd0;
      temp2 <= 9'd0;
      temp3 <= 9'd0;
    end else begin
      temp0 <= add_i_0 + add_i_1;
      temp1 <= add_i_2 + add_i_3;
      temp2 <= add_i_4 + add_i_5;
      temp3 <= add_i_6 + add_i_7;
    end
  end
  */
  /*
  assign temp4 = temp0 + temp1;
  assign temp5 = temp2 + temp3;
  */
  
  //pipeline
  always@(posedge i_clk)begin
    if(counter==9'd0)begin
      temp4 <= 10'd0;
      temp5 <= 10'd0;
    end else begin
      temp4 <= temp0 + temp1;
      temp5 <= temp2 + temp3;
    end
  end
  
  assign answer = temp4 + temp5;
  
  reg [1:0] extend;
  always@(posedge i_clk)begin
    if(counter==9'd2 || counter==9'd4 || counter==9'd8 || counter==9'd1)begin
      extend <= 2'd0;
    end else if(counter[2:0]==3'd6)begin
      extend <= 2'd2;
    end else begin
      extend <= 2'd1;
    end
  end
  
  wire [12:0] answer_ex = (extend==2'd1)?{answer, 1'b0}:
                          (extend==2'd2)?{answer, 2'b0}:
                          answer;
  
  reg [16:0] out_data_conv;
  always@(posedge i_clk)begin
    out_data_conv <= (counter[3:0]==4'd0)?13'd0:
                     (o_out_valid_pipeline_3)?answer:
                     out_data_conv+answer_ex;
  end
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  //three stage pipeline
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      o_out_valid_pipeline_3 <= 1'b0;
      o_out_valid_pipeline_2 <= 1'b0;
      out_valid_reg          <= 1'b0;
    end else begin
      o_out_valid_pipeline_2 <= o_out_valid_pipeline_1;
      o_out_valid_pipeline_3 <= o_out_valid_pipeline_2;
      out_valid_reg          <= o_out_valid_pipeline_3;
    end
  end
  
  /////////////////////////////////////////// display with two stage pipeline////////////////////////////////////////////////////////
  reg [12:0] out_data_dis_temp;
  reg [12:0] out_data_dis;
  always@(posedge i_clk)begin
    if(~have_load)begin
      out_data_dis <= 13'd0;
    end else begin
      out_data_dis <= out_data_dis_temp;
    end
  end
  always@(posedge i_clk)begin
    if(change_output==3'd7)begin
      out_data_dis_temp <= sram_Q7;
    end else if(change_output==3'd6)begin
      out_data_dis_temp <= sram_Q6;
    end else if(change_output==3'd5)begin
      out_data_dis_temp <= sram_Q5;
    end else if(change_output==3'd4)begin
      out_data_dis_temp <= sram_Q4;
    end else if(change_output==3'd3)begin
      out_data_dis_temp <= sram_Q3;
    end else if(change_output==3'd2)begin
      out_data_dis_temp <= sram_Q2;
    end else if(change_output==3'd1)begin
      out_data_dis_temp <= sram_Q1;
    end else begin
      out_data_dis_temp <= sram_Q0;
    end
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      have_load <= 1'b0;
    end else if(state==WAIT)begin
      have_load <= 1'b1;
    end else begin
      have_load <= have_load;
    end
  end
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  /////////////////////////////////////////////////// output data /////////////////////////////////////////////////////////////////
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      out_data_reg <= 13'd0;
    end else begin
      out_data_reg <= (state==CONV && out_data_conv[3])?out_data_conv[16:4] + 13'd1:
                      (state==CONV)?out_data_conv[16:4]:
                      out_data_dis;
    end
  end
  
  ///////////////////////////////////////////////////////// controller ////////////////////////////////////////////////////////////
  
  //assign o_in_ready = (~i_rst_n)?1'b0:1'b1;
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      in_ready_reg <= 1'b0;
    end else begin
      in_ready_reg <= 1'b1;
    end
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      counter <= 9'd0;
    end else if(state!=n_state)begin
      counter <= 9'd0;
    end else begin
      if(state==LOAD && counter==9'd511 || state==DISPALY && counter[4:0]==5'd31)begin//if(state==LOAD && counter==10'd511 || state==DISPALY && counter==10'd31)begin
        counter <= 9'd0;
      end else if(state==CONV && counter[3:0]==4'd9)begin
        counter <= 9'd1;
      end else begin
        counter <= counter + 9'd1;
      end
    end
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      depth <= 4'b1100;
    end else if(i_op_valid && i_op_mode==4'b0101)begin
      depth <= (depth==4'b0011)?depth:depth >> 1;
    end else if(i_op_valid && i_op_mode==4'b0110)begin
      depth <= (depth==4'b1100)?depth:depth << 1;
    end else begin
      depth <= depth;
    end
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      row <= 3'd0;
      col <= 3'd0;
    end else if(i_op_valid && i_op_mode==4'b0001)begin
      row <= row;
      col <= (col==3'd6)?col:col + 3'd1;
    end else if(i_op_valid && i_op_mode==4'b0010)begin
      row <= row;
      col <= (col==3'd0)?col:col - 3'd1;
    end else if(i_op_valid && i_op_mode==4'b0011)begin
      row <= (row==3'd0)?row:row - 3'd1;
      col <= col;
    end else if(i_op_valid && i_op_mode==4'b0100)begin
      row <= (row==3'd6)?row:row + 3'd1;
      col <= col;
    end else begin
      row <= row;
      col <= col;
    end
  end
  
  always@(posedge i_clk)begin
    if(state<=GET)begin
      row_t <= row;
      col_t <= col;
    end else if(counter[2:0]==3'd7 && depth[3:2]==addr_incre)begin
      if(row_t==row && col_t==col)begin
        row_t <= row;
        col_t <= col + 3'd1;
      end else if(row_t==row && col_t==col+3'd1)begin
        row_t <= row + 3'd1;
        col_t <= col;
      end else if(row_t==row+3'd1 && col_t==col)begin
        row_t <= row + 3'd1;
        col_t <= col + 3'd1;
      end else begin
        row_t <= row;
        col_t <= col;
      end
    end else begin
      row_t <= row_t;
      col_t <= col_t;
    end
  end
  
  always@(posedge i_clk)begin
    if(state==GET && n_state==CONV)begin
      addr_incre <= 3'd0;
    end else if(counter[2:0]==3'd7)begin
      addr_incre <= (depth[3:2]==addr_incre)?3'd0:addr_incre + 3'd1;
    end else begin
      addr_incre <= addr_incre;
    end
  end
  /*
  wire [7:0] incre_addr = (addr_incre==2'd3)?8'd192:
                          (addr_incre==2'd2)?8'd128:
                          (addr_incre==2'd1)?8'd64:
                          8'd0;
  */
  
  wire [3:0] now_row = (state==GET && n_state==CONV)?             {1'b0, row_t} - 4'd1:
                       (counter[3:0]>=4'd2 && counter[3:0]<=4'd4)?{1'b0, row_t}       :
                       (counter[3:0]>=4'd5 && counter[3:0]<=4'd7)?{1'b0, row_t} + 4'd1:
                       {1'b0, row_t} - 4'd1;
  wire [3:0] now_col = (state==GET && n_state==CONV)?                                   {1'b0, col_t} - 4'd1:
                       (counter[3:0]==4'd1 || counter[3:0]==4'd4 || counter[3:0]==4'd7)?{1'b0, col_t} + 4'd1:
                       (counter[3:0]==4'd2 || counter[3:0]==4'd5 || counter[3:0]==4'd8)?{1'b0, col_t} - 4'd1:
                       {1'b0, col_t};
                       
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      addr_SRAM <= 8'd0;
    end else if(state==LOAD)begin
      if(addr_SRAM[5:0]==6'b111111 && counter!=9'd511)begin
        addr_SRAM <= addr_SRAM - 8'd63;
      end else begin
        addr_SRAM <= addr_SRAM + 8'd1;
      end
    end else if(state==GET && n_state==DISPALY)begin
      addr_SRAM <= {row, col};
    end else if(state==DISPALY)begin
      if(counter[4:0]==5'd31)begin
        addr_SRAM <= addr_SRAM + 8'd55;
      end else if(counter[0]==1'd0)begin//end else if(counter[1:0]==2'd0 || counter[1:0]==2'd2)begin
        addr_SRAM <= addr_SRAM + 8'd1;
      end else if(counter[1]==1'd0)begin//end else if(counter[1:0]==2'd1)begin
        addr_SRAM <= addr_SRAM + 8'd7;
      end else if(counter[1]==1'd1)begin//end else if(counter[1:0]==2'd3)begin
        addr_SRAM <= addr_SRAM - 8'd9;
      end else begin
        addr_SRAM <= addr_SRAM;
      end
    end else if(state==GET && n_state==CONV)begin
      addr_SRAM <= {now_row[2:0], now_col[2:0]};
    end else if(n_state==CONV)begin
      addr_SRAM <= {addr_incre, now_row[2:0], now_col[2:0]};
    end else begin
      addr_SRAM <= addr_SRAM;
    end
  end
  /*
  always@(*)begin
    if(~i_rst_n)begin
      outside = 1'b0;
    end else begin
      outside = (counter[3:0]==4'd1 && (row_t==3'd0 || col_t==3'd0))?1'b1:
                (counter[3:0]==4'd2 && (row_t==3'd0               ))?1'b1:
                (counter[3:0]==4'd3 && (row_t==3'd0 || col_t==3'd7))?1'b1:
                (counter[3:0]==4'd4 && (               col_t==3'd0))?1'b1:
                //(counter==9'd5 && (                          ))?1'b1:
                (counter[3:0]==4'd6 && (               col_t==3'd7))?1'b1:
                (counter[3:0]==4'd7 && (row_t==3'd7 || col_t==3'd0))?1'b1:
                (counter[3:0]==4'd8 && (row_t==3'd7               ))?1'b1:
                (counter[3:0]==4'd9 && (row_t==3'd7 || col_t==3'd7))?1'b1:
                1'b0;
    end
  end
  */
  always@(posedge i_clk)begin
    outside_pipeline_1 <= (now_row[3] || now_col[3])?1'b1:1'b0;
    outside            <= outside_pipeline_1;
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      change_output <= 3'd7;
    end else if(state==DISPALY && counter[1:0]==2'd0)begin
      change_output <= change_output + 3'd1;
    end else begin
      change_output <= change_output;
    end
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      o_out_valid_pipeline_1 <= 1'b0;
    end else if(state==DISPALY || state==CONV && counter[3:0]==4'd9 && addr_incre==2'd0)begin
      o_out_valid_pipeline_1 <= 1'b1;
    end else begin
      o_out_valid_pipeline_1 <= 1'b0;
    end
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      sram_wen <= 8'b1111_1111;
    end else if(state==GET && n_state==LOAD)begin
      sram_wen <= 8'b1111_1110;
    end else if(state==LOAD)begin
      sram_wen <= (counter[5:0]==6'd63)?{sram_wen[6:0], sram_wen[7]}:sram_wen;
    end else begin
      sram_wen <= 8'b1111_1111;
    end
  end
  
  always@(posedge i_clk or negedge i_rst_n)begin
    if(~i_rst_n)begin
      state <= RST;
    end else begin
      state <= n_state;
    end
  end
  /*
  reg [1:0] c;
  always@(posedge i_clk)begin
    if(state==GET && n_state==CONV)begin
      c <= 2'd0;
    end else if(o_out_valid_temp)begin
      c <= c + 2'd1;
    end else begin
      c <= c;
    end
  end
  */
  
  always@(*)begin
    case(state)
      RST:begin
        op_ready_reg = 1'b0;
        n_state = (~i_rst_n)?RST:READY;
      end
      WAIT:begin
        op_ready_reg = 1'b0;
        n_state = READY;
      end
      WAIT_3:begin
        op_ready_reg = 1'b0;
        n_state = (counter==9'd3)?READY:WAIT_3;
      end
      READY:begin
        op_ready_reg = 1'b1;
        n_state = GET;
      end
      GET:begin
        op_ready_reg = 1'b0;
        n_state = (i_op_valid && i_op_mode==4'b0000)?LOAD:
                  (i_op_valid && i_op_mode<=4'b0110)?WAIT:
                  (i_op_valid && i_op_mode==4'b1000)?DISPALY:
                  (i_op_valid && i_op_mode==4'b0111)?CONV:
                  RST;
      end
      LOAD:begin
        op_ready_reg = 1'b0;
        n_state = (counter==9'd511 && addr_SRAM==8'd255)?WAIT:LOAD;
      end
      CONV:begin
        op_ready_reg = 1'b0;
        n_state = (o_out_valid_pipeline_3 && row_t==row && col_t==col)?WAIT:CONV;
      end
      DISPALY:begin
        op_ready_reg = 1'b0;
        n_state = (counter[4:0]==5'd31 && (/*addr_SRAM>8'd0 && */depth[3:2]==2'd0 || addr_SRAM>'d64 && depth[3:2]==2'd1 || addr_SRAM>8'd192 && depth[3:2]==2'd3))?WAIT_3:DISPALY;
      end
      default:begin
        op_ready_reg = 1'b0;
        n_state = RST;
      end
    endcase
  end
  
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
