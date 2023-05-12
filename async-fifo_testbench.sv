module async_fifo_tb();
  reg [7:0] d_in;
  reg r_en,w_en,r_clk,w_clk;
  reg reset;
  wire [7:0] d_out;
  wire f_full_flag;
  wire f_half_full_flag;
  wire f_empty_flag;
  wire f_almost_full_flag;
  wire f_almost_empty_flag;
  
  async_fifo dut(
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
  
  initial begin
    w_clk=0;
    forever #10 w_clk=~w_clk;
  end
  initial begin
    r_clk=0;
    forever #20 r_clk=~r_clk;
  end
  initial begin
    reset=1;
  end
  initial begin
    $monitor($time," empty flag=%d",f_empty_flag);
    #20;$finish;
  end
endmodule
