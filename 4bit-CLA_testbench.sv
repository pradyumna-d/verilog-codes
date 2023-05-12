// testbench 4-bit CLA
module Test_CLA_4bit;
    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;
    // Outputs
    wire [3:0] S;
    wire Cout;
    wire PG;
    wire GG;

  CLA_4bit dut(S,Cout,PG,GG,A,B,Cin);

    initial begin
    // Initialize Inputs
    A=0;B=0;Cin=0;
    // Wait 20 ns for global reset to finish
    #20;  
    //stimulus
    A=4'b0001;B=4'b0000;Cin=1'b0;
    #10;A=4'b100;B=4'b0011;Cin=1'b0;
    #10;A=4'b1101;B=4'b1010;Cin=1'b1;
    #10;A=4'b1110;B=4'b1001;Cin=1'b0;
    #10;A=4'b1111;B=4'b1010;Cin=1'b0;
    end 
    initial begin
      $dumpfile("CLA_4bit.vcd");
      $dumpvars(1);
      $monitor("time=",$time,, "A=%b B=%b Cin=%b : Sum=%b Cout=%b PG=%b GG=%b",A,B,Cin,S,Cout,PG,GG);
    end      
endmodule
