//N12 testbench
module sync_fifo_tb();
 // Inputs
  reg clk;
  reg rst;
  reg pop;
  reg push;
  reg [7:0] data_in;
 // Outputs
  wire empty;
  wire full;
  wire [7:0] data_out;

 // Instantiate the Unit Under Test (UUT)
  sync_fifo uut (
    .clk(clk), 
    .rst(rst), 
    .pop(pop), 
    .push(push), 
    .empty(empty), 
    .full(full), 
    .data_in(data_in), 
    .data_out(data_out)
 );

  always #5 clk = ~clk;
 
  task reset();
    begin
      clk = 1'b1;
      rst = 1'b1;
      pop = 1'b0;
      push = 1'b0;
      data_in = 8'd0;
      #20; rst = 1'b0;
    end
  endtask
  task read();
    begin
      pop = 1'b1;
      #10;
      pop = 1'b0;
    end
  endtask  
  task write([7:0]data_in_tb);
    begin
      push = 1'b1;
      data_in = data_in_tb;
      #10 push = 1'b0;
    end
  endtask
 // Main code
  initial
    begin
      reset();
      #10;
      repeat(2)
        begin
          write(8'h11);
          #10;
          write(8'h22);
          #10;
          write(8'h33);
          #10;
          write(8'h44);
          #10;
        end
      #10;
      repeat(2)
        begin
          read();
          #10;
          read();
          #10;
          read();
          #10;
          read();
          #10;
        end
      #500;$finish;
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end  
endmodule
