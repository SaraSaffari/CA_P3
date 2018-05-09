module ALU_TB();
	reg clk = 0;
	reg [7:0] A, B;
	wire [7:0] rslt;
	reg ci;
	reg [2:0] func;
	wire co;
	wire z;
	wire n;	

	initial repeat (10) #50 clk = ~clk;
	initial begin
		#10
		A = 8'b 00000001;
		B = 8'b 11111110;
		ci = 1;
		func = 2'b 00;
		#80
		A = 8'b 00001110;
		B = 8'b 11101110;
		func = 2'b 01;
		#80
		A = 8'b 00000001;
		B = 8'b 11000000;
		func = 2'b 10;
		#80 
		A = 8'b 00000001;
		B = 8'b 00011110;
		func = 2'b 00;
	end


	ALU X(
		.inputA(A),
		.inputB(B), 
		.carryIn(ci), 
		.func(func),
		.result(rslt), 
		.carryOut(co), 
		.zero(z),
		.negetive(n)
	);

endmodule
