module alu #(
    parameter INT_W  = 3,
    parameter FRAC_W = 5,
    parameter INST_W = 3,
    parameter DATA_W = INT_W + FRAC_W
)(
    input                     i_clk,
    input                     i_rst_n,
    input                     i_valid,
    input signed [DATA_W-1:0] i_data_a,
    input signed [DATA_W-1:0] i_data_b,
    input        [INST_W-1:0] i_inst,
    output                    o_valid,
    output       [DATA_W-1:0] o_data
);
    
  // ---------------------------------------------------------------------------
  // Wires and Registers
  // ---------------------------------------------------------------------------
  reg [DATA_W:0]     o_data_w, o_data_r;
  reg                o_valid_w, o_valid_r;
  // ---- Add your own wires and registers here if needed ---- //


  // ---------------------------------------------------------------------------
  // Continuous Assignment
  // ---------------------------------------------------------------------------
  assign o_valid = o_valid_r;
  assign o_data = o_data_r;
  // ---- Add your own wire data assignments here if needed ---- //


  // ---------------------------------------------------------------------------
  // Combinational Blocks
  // ---------------------------------------------------------------------------
  // ---- Write your combinational block design here ---- //
  wire signed [DATA_W:0] add_temp = i_data_a + i_data_b;
  wire signed [DATA_W:0] sub_temp = i_data_a - i_data_b;

  wire signed [2*DATA_W-1:0] multi_temp1 = i_data_a * i_data_b;
  wire signed [DATA_W:0] multi_temp2 = (multi_temp1[4])?{multi_temp1[15], multi_temp1[15], multi_temp1[11:5]} + $signed(9'd1):
                                                        {multi_temp1[15], multi_temp1[15], multi_temp1[11:5]};

  wire [2:0] shift_amount = i_data_b[2:0];

  always@(*) begin
    o_valid_w = (i_valid)?1'b1:1'b0;
    case(i_inst)
      3'b000:o_data_w = (add_temp>$signed(9'd127))?$signed(9'd127):
                        (add_temp<$signed(-9'd128))?$signed(-9'd128):
                        add_temp;
      3'b001:o_data_w = (sub_temp>$signed(9'd127))?$signed(9'd127):
                        (sub_temp<$signed(-9'd128))?$signed(-9'd128):
                        sub_temp;
      3'b010:o_data_w = (multi_temp1>$signed(16'd4095))?$signed(9'd127):
                        (multi_temp1<$signed(-16'd4096))?$signed(-9'd128):
                        multi_temp2;
      3'b011:o_data_w = ~(i_data_a & i_data_b);
      3'b100:o_data_w =  ~(i_data_a ^ i_data_b);
      3'b101:o_data_w = (i_data_a>=$signed(8'd64))?$signed(9'd32):
                        (i_data_a<=$signed(-8'd64))?$signed(9'd0):
                        {i_data_a[7], i_data_a>>>2} + $signed(9'd16);
      3'b110:o_data_w = (shift_amount==3'd0)?{i_data_a[7],                i_data_a[7:0]}:
                        (shift_amount==3'd1)?{i_data_a[0], i_data_a[0],   i_data_a[7:1]}:
                        (shift_amount==3'd2)?{i_data_a[1], i_data_a[1:0], i_data_a[7:2]}:
                        (shift_amount==3'd3)?{i_data_a[2], i_data_a[2:0], i_data_a[7:3]}:
                        (shift_amount==3'd4)?{i_data_a[3], i_data_a[3:0], i_data_a[7:4]}:
                        (shift_amount==3'd5)?{i_data_a[4], i_data_a[4:0], i_data_a[7:5]}:
                        (shift_amount==3'd6)?{i_data_a[5], i_data_a[5:0], i_data_a[7:6]}:
                        (shift_amount==3'd7)?{i_data_a[6], i_data_a[6:0], i_data_a[7]  }:
                        i_data_a;
      3'b111:o_data_w = (i_data_a<=i_data_b)?i_data_a:i_data_b;
      default:o_data_w = i_data_a;
    endcase
  end

  // ---------------------------------------------------------------------------
  // Sequential Block
  // ---------------------------------------------------------------------------
  // ---- Write your sequential block design here ---- //
  always@(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
      o_data_r  <= 8'd0;
      o_valid_r <= 1'b0;
    end else begin
      o_data_r  <= {o_data_w[8], o_data_w[6:0]};
      o_valid_r <= o_valid_w;
    end
  end

endmodule
