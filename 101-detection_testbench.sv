module pattern_tb();
  reg clk,rst,in;
  wire out;
  pattern dut(clk,in,rst,out);
  initial begin
    clk=0;
    forever #10 clk=~clk;
  end
  initial begin
    #10;rst=1;in=1;
    #20;rst=0;in=0;#20;in=0;#20;in=0;#20;in=1;
    #20;in=0;#20;in=1;#20;in=1;#20;in=1;#20;in=0;
    #20;in=1;#20;in=0;#20;in=1;#20;in=1;#20;in=0;
    #20;in=0;#20;in=1;#20;in=0;#20;in=1;#20;in=0;
    #20;in=0;#20;in=0;#20;in=1;#20;in=1;#20;in=0;
    #20;in=0;#20;in=1;#20;in=0;#20;in=1;#20;in=0;
  end
  initial begin
    $monitor($time,"rst=%b,in=%b,out=%b",rst,in,out);
    $dumpfile("pattern.vcd");
    $dumpvars(1);
    #300;$finish;
  end
endmodule
