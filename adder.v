module adder #(parameter integer size = 8)(inputA, inputB, result);
	input [size - 1: 0] inputA, inputB;
	output reg [size - 1: 0] result;
	always @(*) begin
		result = inputA + inputB;
	end	
endmodule