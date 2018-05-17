module Memory(clock, memWrite, memRead, addressMem, dataMem, memOut);
	input clock, memWrite, memRead;
	input[12:0] addressMem;
	input[7:0] dataMem;
	output reg[7:0] memOut;
	reg[7:0] word[8191:0];
	
	always @(posedge clock) begin
		if (memWrite)begin
			word[addressMem] <= dataMem;
		end
	end
	always @(memRead , addressMem) begin
		if (memRead)begin
			memOut <= word[addressMem];
		end
	end

	always @(posedge clock ) begin
		word[0] <= 8'd7
		word[1] <= {010, 00000};
		word[2] <= 8'd0;
	end
endmodule 