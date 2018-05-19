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
		word[0] = 8'd1;
		word[1] = 8'd2;
		word[2] = 8'd3;
		word[3] = 8'd4;
		// word[1] <= 8'b11100000;
		// word[7] <= 8'd7;
		// word[2] <= {3'b000, 5'b00000};
		// word[3] <= 8'd7;
	end
endmodule 