// pattern detection of 101
module pattern(clk,in,rst,out);
  input in,clk,rst;
  output out;
  
  reg [1:0]state,nxt_state;
  
  parameter [1:0]
  idle=2'b00,
  s1=2'b01,
  s10=2'b10,
  s10=2'b11;
  
  always@(posedge clk) begin
    if(rst)
      state<=idle;
    else
      state<=nxt_state;
  end
  
  always@(posedge clk) begin
    case(state)
      idle:begin
        if(in)
          nxt_state<=s1;
        else
          nxt_state<=idle;
      end
      s1:begin
        if(in)
          nxt_state<=idle;
        else
          nxt_state<=s10;
      end
      s10:begin
        if(in)
          nxt_state<=s101;
        else
          nxt_state<=idle;
      end
      s101:nxt_state<=idle;
    endcase
  end
endmodule
