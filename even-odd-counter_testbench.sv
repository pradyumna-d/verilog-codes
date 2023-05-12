//N12 even-odd counter
module even_odd_count_tb();
  reg clk,rst,up;
  wire [2:0]q;
  even_odd_count dut(clk,rst,up,q);
  initial begin
    clk=1'b0;
    forever #10 clk=~clk;
  end
  initial begin
    rst=1'b1;up=0;#10;up=1;
    #20;rst=1'b0;up=1;#60;rst=1'b0;up=1;#60;rst=1'b0;up=1;
    #60;rst=1'b0;up=0;#60;rst=1'b0;up=0;#60;rst=1'b0;up=0;
    #100;rst=1'b0;up=1;
  end
  initial begin
    $monitor("T=%t,rst=%b,up=%b,q=%b",$time,rst,up,q);
    $dumpfile("even_odd_count.vcd");
    $dumpvars(1);
    #600;$finish;
  end
endmodule
