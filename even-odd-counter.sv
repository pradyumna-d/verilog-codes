//N12 even-odd counter
module even_odd_count(clk,rst,up,q);
  input clk,rst,up;
  output reg [2:0]q;
  always@(posedge clk) begin
    if(rst) begin
      q=3'b000;
    end
    else if(up) begin
      q<=q+3'b001;
    end
    else 
      q<=q-3'b001;
  end
endmodule
