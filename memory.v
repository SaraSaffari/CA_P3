module dataMemory(clock, memWrite, memRead, addressMem, dataMem, wordRegIn);
	input clock, memWrite, memRead;
	input[7:0] addressMem, dataMem;
	output reg[7:0] wordRegIn;
	reg[7:0] word[8191:0];
	
	always @(posedge clock) begin
		if (memWrite)begin
			word[addressMem] <= dataMem;
		end
	end
	always @(memRead , addressMem) begin
		if (memRead)begin
			wordRegIn <= word[addressMem];
		end
	end
endmodule 