// N12 Pradyumna
// Traffic light
module traffic_light(clk,rst,s,light);
  input clk,rst,s;
  output reg [1:0]light;
  
  parameter [1:0]
  red=2'b00,
  yellow=2'b01,
  green=2'b10;
  
  reg [1:0] state,nxt_state;
  
  always@(posedge clk)
  begin
    if(rst)
      state<=red;
    else
      state<=nxt_state;
  end
  always@(posedge clk)
    case(state)
      red:
        if(s) 
          begin
            nxt_state<=red;
            light=2'b00;
          end
        else 
          begin
            nxt_state<=yellow;
            light=2'b01;
          end
      yellow:
        if(s)
          begin
            nxt_state<=red;
            light=2'b00;
          end
        else 
          begin
            nxt_state<=green;
            light=2'b01;
          end
      green:
        if(s)
          begin
            nxt_state<=yellow;
            light=2'b01;
          end
        else
          begin
            nxt_state<=green;
            light=2'b10;
          end
      
    endcase
endmodule
