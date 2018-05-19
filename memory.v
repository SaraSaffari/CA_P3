module Memory(clock, memWrite, memRead, addressMem, dataMem, memOut);
	input clock, memWrite, memRead;
	input[12:0] addressMem;
	input[7:0] dataMem;
	output reg[7:0] memOut;
	reg[7:0] word[8191:0];
	
	always @(addressMem, memWrite) begin
		if (memWrite)begin
			word[addressMem] <= dataMem;
		end
	end
	always @(posedge clock) begin
		if (memRead)begin
			memOut <= word[addressMem];
		end
	end

	always @(posedge clock ) begin
		word[0] = 8'b11110000;
		word[1] = 8'b00000011;
		word[2] = 8'b11100111;
		///
		word[3] = 8'b11101000;
		word[4] = 8'b00000011;
		word[5] = 8'b11100111;
		///
		word[6] = 8'b11100000;
		word[7] = 8'b00000011;
		word[8] = 8'b11101000;   ///write 10 in ac0
		///
		word[9] = 8'b01000011;
		word[10] = 8'b11101001;
		///
		word[11] = 8'b10010110;
		///
		word[12] = 8'b01000011;
		word[13] = 8'b11101010;
		///
		word[14] = 8'b10010110;
		///
		word[15] = 8'b01000011;
		word[16] = 8'b11101011;
		///
		word[17] = 8'b10010110;
		///
		word[18] = 8'b01000011;
		word[19] = 8'b11101100;
		///
		word[20] = 8'b10010110;
		///
		word[21] = 8'b01000011;
		word[22] = 8'b11101101;
		//
		word[23] = 8'b10010110;
		//
		word[24] = 8'b01000011;
		word[25] = 8'b11101110;
		//
		word[26] = 8'b10010110;
		word[27] = 8'b01000011;
		word[28] = 8'b11101111;
		word[29] = 8'b10010110;
		word[30] = 8'b01000011;
		word[31] = 8'b11110000;
		word[32] = 8'b10010110;
		word[33] = 8'b01000011;
		word[34] = 8'b11110001;
		word[35] = 8'b10010110;
		word[36] = 8'b11101000;

		//
		word[37] = 8'b00100111;
		word[38] = 8'b11010000;
		//
		word[39] = 8'b11100000;
		//
		word[40] = 8'b00100111;
		word[41] = 8'b11010001;
		///
		word[999] = 8'b00000000;

		word[1000] <= 8'd40;
		word[1001] <= 8'd41;
		word[1002] <= 8'd42;
		word[1003] <= 8'd43;
		word[1004] <= 8'd44;
		word[1005] <= 8'd45;
		word[1006] <= 8'd46;
		word[1007] <= 8'd47;
		word[1008] <= 8'd48;
		word[1009] <= 8'd49;
	end
endmodule 