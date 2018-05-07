module regTB();
  parameter integer regSize = 8;
  reg clk = 0;
  reg enb = 0;
  reg [regSize - 1: 0] in = 97;
  wire [regSize - 1: 0] outp;
  
  
  initial repeat (15) #50 clk = ~clk;
  
  initial begin
    #100
    enb = 1;
    #60
    enb = 0;
    in = 0;
  end
  
  register #(.size(regSize)) R1 (
    .clock(clk),
    .enable(enb),
    .regIn(in),
    .regOut(outp)
  );
    
  
endmodule