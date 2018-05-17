module register  #(parameter integer size = 32)(clock, enable, regIn, regOut);
    input clock , enable;
    input [size - 1:0] regIn;
    output reg [size - 1: 0] regOut;
    
    always @(posedge clock) begin
      if ( enable) regOut <= regIn;        
    end
endmodule

module pcRegister  #(parameter integer size = 32)(clock, rst, enable, regIn, regOut);
    input clock, rst, enable;
    input [size - 1:0] regIn;
    output reg [size - 1: 0] regOut;
    
    always @(posedge clock, posedge rst) begin
    	if (rst) regOut <= 0;
    	else if ( enable) regOut <= regIn;        
    end
endmodule