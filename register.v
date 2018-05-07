module register  #(parameter integer size = 32)(clock, enable, regIn, regOut);
    input clock , enable;
    input [size - 1:0] regIn;
    output reg [size - 1: 0] regOut;
    
    always @(posedge clock) begin
      if ( enable) regOut <= regIn;        
    end
endmodule