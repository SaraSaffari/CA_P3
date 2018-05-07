module ALU_TB();
	reg [7:0] A, B;
	wire [7:0] rslt;
	reg ci;
	wire co, z, n;	
	reg clk = 0;

	initial repeat (10) #50 clk = ~clk;
	initial begin
		#10
		A = 8'b 011111001;
		B = 8'b 110000100;
		ci = 1;
	end

	ALU X(
		.inputA(A),
		.inputB(B), 
		.carryIn(ci),  
		.result(rslt), 
		.carryOut(co), 
		.zero(z),
		.negetive(n)
	);

endmodule
