`timescale 1ns/10ps
module IOTDF( clk, rst, in_en, iot_in, fn_sel, busy, valid, iot_out);
  
  input          clk;
  input          rst;
  input          in_en;
  input  [7:0]   iot_in;
  input  [2:0]   fn_sel;
  output reg     busy;
  output reg     valid;
  output reg[127:0] iot_out;
  
  parameter RST     = 3'b000,
            GET     = 3'b001,
            MAX_MIN = 3'b010,
            WAIT    = 3'b011,
            COMP    = 3'b100,
            AVG     = 3'b101,
            EXTRACT = 3'b110,
            EXCLUDE = 3'b111;
  
  reg [2:0] state;
  reg [2:0] n_state;
  reg [3:0] counter;
  
  reg [7:0] REG0 [0:15];
  reg [7:0] REG1 [0:15];
  reg [2:0] CARRY;
  
  reg target;
  reg [3:0] index;
  reg [3:0] num_of_data;
  
  wire REG0_equal = REG0[index]==REG1[index];
  wire REG0_big = REG0[index] > REG1[index];
  wire REG0_sma = REG0[index] < REG1[index];
  wire max_op = (fn_sel==3'd1||fn_sel==3'd6);
  wire min_op = (fn_sel==3'd2||fn_sel==3'd7);
  wire max_min_op = max_op || min_op;
  
  always@(posedge clk)begin
    if((state==MAX_MIN) && &counter[3:1] || state==COMP && REG0_equal)begin
      busy <= 1'b1;
    end else begin
      busy <= 1'b0;
    end
  end
  
  always@(posedge clk or posedge rst)begin
    if(rst)begin
      state <= RST;
    end else begin
      state <= n_state;
    end
  end
  
  always@(posedge clk)begin
    if(state!=n_state)begin
      counter <= 4'd0;
    //end else if((state==AVG||state==EXTRACT||state==EXCLUDE) && counter==5'd15)begin
    //  counter <= 5'd0;
    end else begin
      counter <= counter + 4'd1;
    end
  end
  
  always@(posedge clk)begin
    if(state!=COMP && n_state==COMP)begin
      index <= 4'd15;
    end else if(state==COMP)begin
      index <= index - 4'd1;
    end
  end
  
  reg have_find_peak;
  always@(posedge clk or posedge rst)begin
    if(rst)begin
      have_find_peak <= 1'b0;
    end else if(valid)begin
      have_find_peak <= 1'b1;
    end
  end
  
  always@(posedge clk)begin
    if(n_state==GET)begin
      target <= 1'b0;
    end else if(state==GET && (n_state==MAX_MIN/*&&fn_sel==3'd1*/ /*&&fn_sel==3'd2*/))begin
      target <= 1'b1;
    end else if(state==COMP && n_state==WAIT && (max_min_op))begin
      if(max_op)target <= (REG0_big)?1'b1:1'b0;
      else if(min_op)target <= (REG0_sma)?1'b1:1'b0;
    end
  end
  
  integer i;
  reg carry;
  wire [10:0] add1 = (state==AVG && &counter)?{CARRY, REG0[15]}:
                     (state==AVG)?REG0[counter]:
                     11'd0;
  wire [7:0] add2 = (state==AVG)?iot_in:8'd0;
  wire add_carry = (~|counter || state!=AVG)?1'b0:carry;
  wire [10:0] ans = add1 + add2 + add_carry;
  always@(posedge clk)begin
    if(in_en)begin
      if(state==AVG&&counter==4'd0&&(num_of_data==4'd8||num_of_data==4'd0))begin
        REG0[0] <= iot_in;
        carry <= 1'b0;
        CARRY <= 3'd0;
        for(i=1;i<=15;i=i+1)begin
          REG0[i] <= 8'd0;
        end
      end else if(state==AVG)begin
        if     (~|counter) {carry, REG0[ 0]}      <= ans;
        else if(&counter){CARRY, REG0[15]}      <= ans;
        else                   {carry, REG0[counter]} <= ans;
      end else if(state==GET || state==EXTRACT || state==EXCLUDE)begin
        REG0[counter] <= iot_in;
      end else begin
        if(target==1'b0)begin
          REG0[counter] <= iot_in;
        end else begin
          REG1[counter] <= iot_in;
        end
      end
    end
  end
  
  always@(posedge clk)begin
    if(state==RST)begin
      num_of_data <= 4'd0;
    end else if(num_of_data==4'd8 && (fn_sel==3'd6||fn_sel==3'd7))begin
      num_of_data <= num_of_data;
    end else if(state==GET && (n_state==MAX_MIN) || (state==MAX_MIN) && n_state==COMP)begin
      num_of_data <= num_of_data + 4'd1;
    end else if((state==AVG||state==EXTRACT||state==EXCLUDE) && &counter)begin
      if(num_of_data==4'd8)begin
        num_of_data <= 4'd1;
      end else begin
        num_of_data <= num_of_data + 4'd1;
      end
    end
  end
  
  reg all_f;
  always@(posedge clk)begin
    if(in_en && (state==EXCLUDE||state==EXTRACT))begin
      if(~|counter)begin
        all_f <= 1'b1;
      end else if(~&iot_in)begin
        all_f <= 1'b0;
      end
    end
  end
  
  wire should_output = ((state==COMP && (~REG0_equal && (fn_sel!=3'd6&&fn_sel!=3'd7||(!have_find_peak&&(fn_sel==3'd6||fn_sel==3'd7))) || fn_sel==3'd6&&target==1'b1&&REG0_sma || fn_sel==3'd6&&target==1'b0&&REG0_big || fn_sel==3'd7&&target==1'b1&&REG0_big || fn_sel==3'd7&&target==1'b0&&REG0_sma) || state==AVG&&counter==5'd0) && num_of_data==4'd8 || (state==EXTRACT && REG0[15]>8'h6f && (REG0[15]<8'hAF||REG0[15]==8'hAF&&!all_f) || state==EXCLUDE && (REG0[15]<8'h7f || REG0[15]==8'h7f&&!all_f || REG0[15]>8'hBF)) && counter==5'd0 && num_of_data!=4'd0);
  
  wire [127:0] out_temp0 = {REG0[15], REG0[14], REG0[13], REG0[12], REG0[11], REG0[10], REG0[9], REG0[8], REG0[7], REG0[6], REG0[5], REG0[4], REG0[3], REG0[2], REG0[1], REG0[0]};
  wire [127:0] out_temp1 = {REG1[15], REG1[14], REG1[13], REG1[12], REG1[11], REG1[10], REG1[9], REG1[8], REG1[7], REG1[6], REG1[5], REG1[4], REG1[3], REG1[2], REG1[1], REG1[0]};
  always@(posedge clk or posedge rst)begin
    if(rst)begin
      iot_out <= 128'd0;
    end else if(should_output)begin
      if(state==COMP)begin
        if(REG0_big && max_op || REG0_sma && min_op)begin
          iot_out <= out_temp0;
        end else /*if(REG0_sma && max_op || REG0_big && min_op)*/begin
          iot_out <= out_temp1;
        end
      end else if(state==AVG && ~|counter && num_of_data==4'd8)begin
        iot_out <= {CARRY, out_temp0[127:3]};
      end else if(state==EXTRACT || state==EXCLUDE)begin
        iot_out <= out_temp0;
      end
    end
  end
  
  always@(posedge clk)begin
    if(should_output)begin
    //if(state==COMP && (fn_sel==3'd1||fn_sel==3'd2) && REG0[index] != REG1[index] && num_of_data==4'd8)begin
      valid <= 1'b1;
    /*end else if(state==AVG && num_of_data==4'd8 && counter==4'd0)begin
      valid <= 1'b1;
    end else if((state==EXTRACT && REG0[15]>8'h6f && (REG0[15]<8'hAF || REG0[15]==8'hAF&&!all_f) || state==EXCLUDE && (REG0[15]<8'h7f || REG0[15]==8'h7f&&!all_f || REG0[15]>8'hBF)) && counter==5'd0 && num_of_data!=4'd0)begin
      valid <= 1'b1;
    end else if((state==COMP && fn_sel==3'd6 && (REG0[index] != REG1[index] && !have_find_peak || target==1'b1&&REG1[index]>REG0[index] || target==1'b0&&REG0[index]>REG1[index])) && num_of_data==4'd8)begin
    //end else if(state==COMP && fn_sel==3'd6 && (target==1'b1&&REG1[index]>REG0[index] || target==1'b0&&REG0[index]>REG1[index]) && !have_find_peak && counter==4'd0)begin
      valid <= 1'b1;
    //end else if((state==COMP && fn_sel==3'd7 && (REG0[index] != REG1[index] && !have_find_peak || target==1'b1&&REG1[index]<REG0[index] || target==1'b0&&REG0[index]<REG1[index])) && num_of_data==4'd8 && counter==5'd0)begin
    end else if((state==COMP && fn_sel==3'd7 && (REG0[index] != REG1[index] && !have_find_peak || target==1'b1&&REG1[index]<REG0[index] || target==1'b0&&REG0[index]<REG1[index])) && num_of_data==4'd8)begin
      valid <= 1'b1;
    */end else begin
      valid <= 1'b0;
    end
  end
  
  always@(*)begin
    case(state)
      RST:begin
        n_state = (!rst && fn_sel==3'd3)?AVG:
                  (!rst && fn_sel==3'd4)?EXTRACT:
                  (!rst && fn_sel==3'd5)?EXCLUDE:
                  (!rst)?GET:RST;
      end
      GET:begin
        n_state = (&counter && (max_min_op))?MAX_MIN:
                  //(counter==4'd15 && min_op)?MIN:
                  GET;
      end
      MAX_MIN:begin
        n_state = (&counter)?COMP:MAX_MIN;
      end/*
      MIN:begin
        n_state = (counter==4'd15)?COMP:MIN;
      end*/
      AVG:begin
        n_state = AVG;
      end
      COMP:begin
        n_state = (~REG0_equal && num_of_data==4'd8 && (fn_sel==3'd6||fn_sel==3'd7))?WAIT:
                  (~REG0_equal && num_of_data==4'd8)?RST:
                  (~REG0_equal)?WAIT:COMP;
      end
      WAIT:begin
        n_state = (max_min_op)?MAX_MIN:RST;
      end
      EXTRACT:begin
        n_state = EXTRACT;
      end
      EXCLUDE:begin
        n_state = EXCLUDE;
      end
      default:begin
        n_state = RST;
      end
    endcase
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
endmodule
