module dataPath_TB ();
	reg clk, pcEn, selAddress, mr, mw, wordRegEn, LSEn, RSEn, DIEn, selData, selALUsrc, selAddressAC, enb, dataRegEn, resultRegEn, CEn, ZEn, NEn;
	// reg [12:0] pcInput, pcOutput, address, RIBits;
	// reg [7:0] wordRegIn, wordRegOut, RSOut, LSOut, data, dataRegIn, dataRegOut, resultRegIn, resultRegOut;
	// reg [4:0] DIOut;
	// reg CInput, COutput, ZInput, NInput;
	wire toCU;

	initial repeat (15) #50 clk = ~clk;

	initial begin
		#40
				
	end

   














	dataPath DP(
		.clk(clk),
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
		.NEn(NEn)
		.toCU(out)
	);
endmodule 