module AAAAAmips_TB();
	reg clk = 0;
	reg rst; 
	wire [3:0] upcode;
	wire pcWrite, memAddressSel, memRead, ACwrite, ACread, memWrite;
	wire [1:0] ACdataSel, ACaddressSel, jmpCond;
	wire [2:0] ALUcommand;
	wire IRwritePart1, IRwritePart2, DIwrite, ALUBinputSel, resultRegEn, dataRegEn, wordRegEn, 
		CEn, ZEn, NEn;
	wire pcDataSel, C, Z, N;


DataPath D(
	.clk(clk), 
	.reset(rst), 
	.pcEn(pcWrite), 
	.selAddress(memAddressSel), 
	.mr(memRead),
	.mw(memWrite),
	.wordRegEn(wordRegEn),
	.LSEn(IRwritePart1),
	.RSEn(IRwritePart2),
	.DIEn(DIwrite),
	.selData(ACdataSel),
	.selALUsrc(ALUBinputSel),
	.selAddressAC(ACaddressSel),
	.enb(ACwrite),
	.dataRegEn(dataRegEn),
	.resultRegEn(resultRegEn),
	.CEn(CEn),
	.ZEn(ZEn),
	.NEn(NEn),
	.CC(C),
	.ZZ(Z),
	.NN(N),
	.toCU(upcode),
	.operation(ALUcommand),
	.selPC(pcDataSel),
	.jmpCond(jmpCond)
	);

	controller c(
		.clk(clk), 
		.rst(rst), 
		.Dupcode(upcode), 
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
		.NEn(NEn),
		.C(C),
		.Z(Z),
		.N(N),
		.jmpCond(jmpCond)
		);

	initial repeat (400) #20 clk = ~clk;
	initial begin
		rst = 1;

		#22;
		rst = 0;

	end

endmodule