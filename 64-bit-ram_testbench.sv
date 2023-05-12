//N12 Pradyumna
// 64 bit ram testbench
module ram_tb();
  reg w,r,rst,clk;
  reg [63:0]data_in;
  reg [5:0]addr;
  wire [63:0]data_out;  
  ram dut(w,r,clk,rst,addr,data_in,data_out);
  initial begin
      clk=0;
      forever #10 clk=~clk;
    end
  initial begin
      rst=1;w=0;r=0;addr=6'd0;data_in=64'd0;
      #30;rst=0;w=1;r=0;addr=6'd1;data_in=64'd10;
      #20;rst=0;w=0;r=1;
      #20;rst=0;w=1;r=0;addr=6'd2;data_in=64'd20;
      #20;rst=0;w=0;r=1;
      #20;rst=0;w=1;r=0;addr=6'd3;data_in=64'd30;
      #20;rst=0;w=0;r=1;
      #20;rst=0;w=1;r=0;addr=6'd4;data_in=64'd40;
      #20;rst=0;w=0;r=1;
      #20;rst=0;w=1;r=0;addr=6'd5;data_in=64'd50;
      #20;rst=0;w=0;r=1;
    end
    initial begin
      $dumpfile("ram.vcd");
      $dumpvars(1);            
    $monitor($time,"rst=%d,w=%d,r=%d,clk=%d,addr=%d,data_in=%d,data_out=%d",rst,w,r,clk,addr,data_in,data_out);
      #200;
      $finish;
    end
endmodule
