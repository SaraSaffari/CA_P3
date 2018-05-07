module Accumulator(clock, regWrite, RegisterNumber, writeData, readData);
  input clock, regWrite;
  input [1:0] RegisterNumber;
  input [7:0] writeData;
  output [7:0] readData;

  reg[7:0] registers[3:0]; 
  assign readData = registers[RegisterNumber];

  always @(posedge clock) begin
    if (regWrite)begin
      registers[RegisterNumber] <= writeData;
    end
  end
endmodule