//N12 Pradyumna
// 64 bit ram 
module ram(w,r,clk,rst,addr,data_in,data_out);
  input w,r,rst,clk;
  input [63:0]data_in;
  input [5:0]addr;
  output reg [63:0]data_out;
  
  reg [63:0] mem[63:0];  //allocating 64 bits of ram each of 64 bits
  
  always@(posedge clk or posedge rst)
    begin
      if(rst)
        data_out<=64'd0;       //reset
      else if(w)             //write operation
        mem[addr]<=data_in;
      else if(r)          //read operation
        data_out<=mem[addr];
      else                 //default value
        data_out<=64'd0;
    end
endmodule
