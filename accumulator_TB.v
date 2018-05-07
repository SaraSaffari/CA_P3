module accumulator_TB();
  reg clk = 0, enb = 0;
  // reg [2:0] wRegister;
  reg [1:0] RegisterNumber;
  reg [7:0] wData;
  wire [7:0] rData;

  initial repeat (18) #50 clk = ~clk;
  
  initial begin
      // wRegister = 2;
      RegisterNumber = 1;
      wData = 3;
      // rRegister1 = 0;  
      // rRegister2 = 2;
      #40
      enb = 1;
      #20
      enb = 0;
      wData = 5;
      RegisterNumber = 4;
      #50
      enb = 1;
      #20
      enb = 0;
      
      // wData = 5;
      // wRegister = 7;
      // rRegister1 = 7;
      // #50
      // enb= 0;
      // wData= 4;
  end

  accumulator AC(
    .clock(clk),
    .regWrite(enb),
    .RegisterNumber(wRegister),
    .writeData(wData),
    .readData(rData)
  );

endmodule