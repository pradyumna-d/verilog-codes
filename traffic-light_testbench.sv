// N12 Pradyumna
// traffic light testbench
module traffic_light_tb();
  reg clk,rst,s;
  wire [1:0]light;
  
  traffic_light dut(clk,rst,s,light);
  
  initial
    begin
      clk=0;
      forever #10 clk=~clk;
    end
  initial
    begin
      rst=1;#10;s=0;//#10;s=0;#10;s=0;
      #10;rst=1;#10;s=0;#10;s=1;
      #200;
    end
  initial
    begin
      $dumpfile("traffic_light.vcd");
      $dumpvars(1);
      $monitor($time,"%d,%d,%d,%d",clk,rst,s,light);
      #200;
      $finish;
    end
endmodule
