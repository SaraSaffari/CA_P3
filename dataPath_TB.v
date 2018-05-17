module dataPath_TB ();
	
	reg clk = 0;
	reg pc_En, sel_address, memread, memwrite, word_En, LS_En, RS_En, DIEn, sel_ALUsrc, enb, data_En, result_En, CEn, ZEn, NEn, rst;
	reg [1:0] sel_addressAC, sel_data;
	wire out;

	reg [2:0]op;
	initial repeat (100) #50 clk = ~clk;

	initial begin		
		rst <= 1;
		#30
		rst <= 0;
		memread <= 1;
		pc_En <= 1;
		sel_address <= 0;
		LS_En <= 1;
	end

   

	DataPath DP(
		.clk(clk),
		.reset(rst),
		.pcEn(pc_En), 
		.selAddress(sel_address), 
		.mr(memread), 
		.mw(memwrite), 
		.wordRegEn(word_En), 
		.LSEn(LS_En), 
		.RSEn(RS_En), 
		.DIEn(DI_En), 
		.selData(sel_data),
		.selAddressAC(sel_addressAC),
		.selALUsrc(sel_ALUsrc), 
		.enb(enb), 
		.dataRegEn(data_En), 
		.resultRegEn(result_En), 
		.CEn(CEn), 
		.ZEn(ZEn), 
		.NEn(NEn),
		.toCU(out),
		.operation(op)
	);
endmodule 