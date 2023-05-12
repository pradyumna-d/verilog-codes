//N12 Pradyumna 
module sync_fifo(
 clk,
 rst,
 pop,
 push,
 empty,
 full,
 data_in,
 data_out
    );

  parameter pointer_width = 3;
  parameter data_width = 8;
  parameter depth = 8;
  //port declaration
  input clk;
  input rst;
  input pop;
  input push;
  input [data_width-1:0]data_in;
  output [data_width-1:0]data_out;
  output empty;
  output full;
  //internal variables
  reg [data_width-1:0] fifo[depth-1:0];
  reg [pointer_width-1:0]rd_pointer, nxt_rd_pointer;
  reg [pointer_width-1:0]wr_pointer, nxt_wr_pointer;
  reg [data_width-1:0] data_out, nxt_data_out;
  reg empty, nxt_empty;
  reg full, nxt_full;
  //flag asssignment
  assign fullchk = push && !(|(wr_pointer^(rd_pointer-1'b1)));
  assign emptychk = pop && !(|(rd_pointer^(wr_pointer-1'b1)));
  //fifo code start
  always @ (posedge clk) //Sequential block
   begin
     if(rst)
       begin
         data_out <= 8'd0;
         empty <= 1'b1;
         full <= 1'b0;
         rd_pointer <= 1'b0;
         wr_pointer <= 1'b0;
       end
     else
       begin
         data_out <= nxt_data_out;
         empty <= nxt_empty;
         full <= nxt_full; 
         rd_pointer <= nxt_rd_pointer;
         wr_pointer <= nxt_wr_pointer;
       end
   end
  always @ (*) //Combinational control logic
    begin
      nxt_data_out = data_out;
      nxt_empty = emptychk ? 1'b1 : push ? 1'b0 : empty;
      nxt_full  = fullchk ? 1'b1 : pop ? 1'b0 : full;
      nxt_rd_pointer = rd_pointer;
      nxt_wr_pointer = wr_pointer;
      if(push)  //write operation
        begin
          fifo[wr_pointer] = data_in;
          nxt_wr_pointer = wr_pointer+1;   //write pointer increment
        end
      else if(pop)  //read operation
        begin
          nxt_data_out = fifo[rd_pointer];
          nxt_rd_pointer = rd_pointer+1;   //read pointer increment
        end
      else
        begin
          nxt_data_out = data_out;
          nxt_rd_pointer = rd_pointer;
          nxt_wr_pointer = wr_pointer;
        end 
    end
endmodule
