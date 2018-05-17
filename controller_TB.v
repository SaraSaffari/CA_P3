module CONTROLLER_TB();
	reg clk = 0;
	reg rst; 
	reg [3:0] upcode;
	wire pcWrite, memAddressSel, memRead, ACwrite, ACread, memWrite;
	wire [1:0] ACdataSel;
	wire [2:0] ALUcommand;
	wire IRwritePart1, IRwritePart2, DIwrite, ACaddressSel, ALUBinputSel, resultRegEn, dataRegEn, wordRegEn, 
		CEn, ZEn, NEn;



	controller c(
		.clk(clk), 
		.rst(rst), 
		.upcode(upcode), 
		.pcWrite(pcWrite), 
		.memAddressSel(memAddressSel), 
		.pcDataSel(pcDataSel), 
		.ACdataSel(ACdataSel), 
		.memRead(memRead), 
		.ACwrite(ACwrite), 
		.ACread(ACread), 
		.memWrite(memWrite), 
		.ALUcommand(ALUcommand),
		.IRwritePart1(IRwritePart1), 
		.IRwritePart2(IRwritePart2),
		.ALUBinputSel(ALUBinputSel), 
		.DIwrite(DIwrite), 
		.ACaddressSel(ACaddressSel), 
		.resultRegEn(resultRegEn), 
		.dataRegEn(dataRegEn), 
		.wordRegEn(wordRegEn), 
		.CEn(CEn), 
		.ZEn(ZEn), 
		.NEn(NEn)
		);

	initial repeat (100) #20 clk = ~clk;
	initial begin
		rst = 1;

		#22;
		rst	= 0; upcode = 3'b0000;
		#180;
		upcode = 4'b1011;
		#200
		upcode = 4'b1110;
		#100
		upcode = 4'b0100;
	end
endmodule

