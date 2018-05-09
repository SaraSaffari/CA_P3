module ALU_TB();
	reg clk = 0;
	reg [7:0] A, B;
	wire [7:0] rslt;
	reg ci;
	reg [2:0] func;
	reg co;
	reg z ;
	reg n ;	

	initial repeat (10) #50 clk = ~clk;
	initial begin
		#10
		A = 8'b 011111001;
		B = 8'b 110000100;
		co = 0;
		n = 0 ;
		z = 0 ;
		ci = 1;
		func = 2'b 00;
		#80
		func = 2'b 10;
		#80
		func = 2'b 01;
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
