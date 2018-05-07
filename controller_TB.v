module CONTROLLER_TB();
	reg clk = 0;
	reg rst; 
	reg [3:0] upcode;
	wire pcWrite, memAddressSel, ACdataSel, IRwriteSel, memRead, irWrite, ACwrite, ACread, memWrite;
	wire [2:0] ALUcommand;
	controller c(clk, rst, upcode, pcWrite, memAddressSel, ACdataSel, IRwriteSel, memRead, irWrite, ACwrite, ACread, memWrite, ALUcommand);

	initial repeat (47) #20 clk = ~clk;
	initial begin
		rst = 1;

		#22;
		rst	= 0;upcode = 3'b000;
		#198
		upcode = 3'b001;
		#220
		upcode = 3'b010;
		#240
		upcode = 3'b011;
	end
endmodule

