//N12 Pradyumna async fifo
module async_fifo(
  d_in,
  r_en,
  w_en,
  r_clk,
  w_clk,
  reset,
  d_out,
  f_full_flag,
  f_half_full_flag,
  f_empty_flag,
  f_almost_full_flag,
  f_almost_empty_flag
);
  parameter f_width=8; //FIFO width
  parameter f_depth=16; //FIFO depth
  parameter f_ptr_width=4; //because depth =16;
  parameter f_half_full_value=8;
  parameter f_almost_full_value=14;
  parameter f_almost_empty_value=2;
//port declaration
  input [f_width-1:0] d_in;
  input r_en,w_en,r_clk,w_clk;
  input reset;
  output reg [f_width-1:0] d_out;
  output f_full_flag;
  output f_half_full_flag;
  output f_empty_flag;
  output f_almost_full_flag;
  output f_almost_empty_flag;

//internal registers,wires
  wire [f_ptr_width-1:0] r_ptr,w_ptr;
  reg r_next_en,w_next_en;
  reg [f_ptr_width-1:0] ptr_diff;
  reg [f_width-1:0] f_memory[f_depth-1:0];
//flag assignments  
  assign f_full_flag=(ptr_diff==(f_depth-1)); //assign FIFO status
  assign f_empty_flag=(ptr_diff==0);
  assign f_half_full_flag=(ptr_diff==f_half_full_value);
  assign f_almost_full_flag=(ptr_diff==f_almost_full_value);
  assign f_almost_empty_flag=(ptr_diff==f_almost_empty_value);
  //---------------------------------------------------------
  always @(posedge w_clk) //write to memory
    begin
      if(w_en) begin
        if(!f_full_flag)
          f_memory[w_ptr]<=d_in; end
    end
//---------------------------------------------------------
  always @(posedge r_clk) //read from memory
    begin
      if(reset)
        d_out<=0; //f_memory[r_ptr];
      else if(r_en) begin
        if(!f_empty_flag)
          d_out<=f_memory[r_ptr]; end
      else d_out<=0;
    end
//---------------------------------------------------------
  always @(*) //ptr_diff changes as read or write clock change
    begin
      if(w_ptr>r_ptr)
        ptr_diff<=w_ptr-r_ptr;
      else if(w_ptr)
        begin
          ptr_diff<=((f_depth-r_ptr)+w_ptr);
        end 
      else ptr_diff<=0; 
    end
//---------------------------------------------------------
        
  always @(*) //if empty flaged read counter should not increment;
    begin if(r_en && (!f_empty_flag))
      r_next_en=1;
      else r_next_en=0;
    end
//--------------------------------------------------------
        
  always @(*) //if full flaged write counter should not increment;
    begin if(w_en && (!f_full_flag))
      w_next_en=1;
      else w_next_en=0;
    end
//----------------------------------------------------------------  
  //binary counters instantiation
  b_counter r_b_counter(.c_out(r_ptr),.c_reset(reset),.c_clk(r_clk),.en(r_next_en));
  b_counter w_b_counter(.c_out(w_ptr),.c_reset(reset),.c_clk(w_clk),.en(w_next_en));
endmodule

module b_counter(c_out,c_reset,c_clk,en);
  parameter c_width=4; //counter width
  input c_reset,c_clk,en;
  output [c_width-1:0] c_out; reg [c_width-1:0] c_out;
  always @(posedge c_clk or posedge c_reset)
    if (c_reset)
      c_out <= 0;
  else if(en)
    c_out <= c_out + 1;
endmodule
