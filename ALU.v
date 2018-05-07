module ALU(inputA, inputB, carryIn, result, carryOut, zero, negetive);
	input [7:0] inputA, inputB;
	input carryIn;
	output reg [7:0] result;
	output reg carryOut, zero, negetive;

	always @(*) begin
		{carryOut, result} = inputA + inputB;
		zero = ~(|result);
		negetive = result[7];
	end

endmodule