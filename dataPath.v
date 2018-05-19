module DataPath (clk, reset, pcEn, selAddress, mr, mw, wordRegEn, LSEn, RSEn, DIEn, selData, selALUsrc, selAddressAC, enb, dataRegEn, resultRegEn, CEn, ZEn, NEn, toCU, operation,selPC);
	input clk, reset, pcEn, selAddress, mr, mw, wordRegEn, LSEn, RSEn, DIEn, selALUsrc, enb, dataRegEn, resultRegEn, CEn, ZEn, NEn, selPC;
	input [1:0] selAddressAC, selData;
	input [2:0] operation;
	output [3:0] toCU;
	wire [12:0] pcInput, pcOutput, address, RIBits, toPC;
	wire [7:0] wordRegIn, wordRegOut, RSOut, LSOut, data, dataRegIn, dataRegOut, resultRegIn, resultRegOut, AlUsrc;
	wire [4:0] DIOut;
	wire [1:0] addressAC;
	wire CInput, COutput, ZInput, NInput;


	assign RIBits = {LSOut[4:0],RSOut[7:0]};
	assign toCU = wordRegIn[7:4];

	pcRegister #(.size(13)) pc(
		.clock(clk),
		.rst(reset),
		.enable(pcEn),
		.regIn(pcInput),
		.regOut(pcOutput)
	);

	register #(.size(1)) C(
		.clock(clk),
		.enable(CEn),
		.regIn(CInput),
		.regOut(COutput)
	);

	register #(.size(1)) Z(
		.clock(clk),
		.enable(ZEn),
		.regIn(ZInput),
		.regOut(ZOutput)
	);

	register #(.size(1)) N(
		.clock(clk),
		.enable(NEn),
		.regIn(NInput),
		.regOut(NOutput)
	);

	adder #(.size(13)) pcAdder(
		.inputA(pcOutput),
		.inputB(13'd1),
		.result(pcInput)
	);

	mux_2_input  #(.WORD_LENGTH (13)) mux1 (
		.in1(pcInput), 
		.in2(RIBits), 
		.sel(selPC), 
		.out(toPC)
	);

	mux_2_input  #(.WORD_LENGTH (13)) mux2 (
		.in1(pcOutput), 
		.in2(RIBits), 
		.sel(selAddress), 
		.out(address)
	);

	mux_3_input #(.WORD_LENGTH(2)) mux3(
		.in1(DIOut[4:3]), 
		.in2(LSOut[1:0]), 
		.in3(LSOut[3:2]), 
		.sel(selAddressAC), 
		.out(addressAC)
	);

	mux_3_input  #(.WORD_LENGTH (8)) mux4 (
		.in1(wordRegOut), 
		.in2(resultRegOut),
		.in3(dataRegOut),
		.sel(selData), 
		.out(data)
	);

	mux_2_input  #(.WORD_LENGTH (8)) mux5 (
		.in1(dataRegOut), 
		.in2(wordRegOut), 
		.sel(selALUsrc), 
		.out(AlUsrc)
	);

	ALU aluUnit (
		.inputA(dataRegIn),
		.inputB(AlUsrc),
		.carryIn(COutput),
		.func(operation),
		.result(resultRegIn), 
		.carryOut(CInput), 
		.zero(ZInput), 
		.negetive(NInput)
	);

	Accumulator ACUnit (
		.clock(clk), 
		.regWrite(enb), 
		.RegisterNumber(addressAC), 
		.writeData(data), 
		.readData(dataRegIn)
	);

	Memory memUnit (
		.clock(clk), 
		.memWrite(mw), 
		.memRead(mr), 
		.addressMem(address), 
		.dataMem(dataRegOut), 
		.memOut(wordRegIn)
	);

	register #(.size(8)) leftSideRI(
		.clock(clk),
		.enable(LSEn),
		.regIn(wordRegIn),
		.regOut(LSOut)
	);	

	register #(.size(8)) RightSideRI(
		.clock(clk),
		.enable(RSEn),
		.regIn(wordRegIn),
		.regOut(RSOut)
	);	

	register #(.size(8)) wordRegister(
		.clock(clk),
		.enable(wordRegEn),
		.regIn(wordRegIn),
		.regOut(wordRegOut)
	);	
	register #(.size(8)) dataRegister(
		.clock(clk),
		.enable(dataRegEn),
		.regIn(dataRegIn),
		.regOut(dataRegOut)
	);	

	register #(.size(8)) resultRegister(
		.clock(clk),
		.enable(resultRegEn),
		.regIn(resultRegIn),
		.regOut(resultRegOut)
	);	

	register #(.size(5)) DI(
		.clock(clk),
		.enable(DIEn),
		.regIn(LSOut[4:0]),
		.regOut(DIOut)
	);	
endmodule 