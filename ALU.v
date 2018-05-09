module ALU(inputA, inputB, carryIn, func, result, carryOut, zero, negetive);
	input [7:0] inputA, inputB;
	input carryIn;
	input [2:0] func;
	output reg [7:0] result;
	output reg carryOut, zero, negetive;

	always @(*) begin
		case(func)
		2'b 00: {carryOut, result} = inputA + inputB + carryIn;
		2'b 00: result = inputB & inputA;
		2'b 00: result = inputB | inputA;
		endcase
		zero = ~(|result);
		negetive = result[7];
	end

endmodule