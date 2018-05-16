module controller(clk, rst, upcode, pcWrite, memAddressSel, ACdataSel, memRead, ACwrite, ACread, memWrite, ALUcommand, IRwritePart1, IRwritePart2);
	input clk, rst;
	input [3:0] upcode;
	output reg pcWrite, memAddressSel, memRead, ACwrite, ACread, memWrite, IRwritePart1, IRwritePart2;
	output reg [1:0] ACdataSel;
	output reg ACaddressSel, ALUBinputSel;
	output reg [2:0] ALUcommand;
	parameter [4:0] s1 = 5'd1, s2 = 5'd2, sAddress = 5'd3, sLDA1 = 5'd4, sLDA2 = 5'd5, sSTA1 = 5'd6, 
		sSTA2 = 5'd7, sA = 5'd8, sADA = 5'd9, sANA = 5'd10, SAA = 5'd11;
		//sA is the first state of ADA/ANA branch and SAA is the last state of this branch

		//ACCUMULATOR STATES:
	parameter [4:0] sACCUMULATOR = 5'd12, sMVR = 5`d13, sADR = 5'd14, sANR = 5'd15, sORR = 5'd16,
		sACCUMULATORfinish = 5'd17;

	reg [4:0] ps = 0, ns;
	always @(ps) begin
		{pcWrite, memAddressSel, ACdataSel, memRead, ACwrite, ACread, memWrite, IRwritePart1, IRwritePart2} <= 20'b0;
		case(ps)
			s1: begin memRead <= 1 ;  IRwritePart1 <= 1 ; pcWrite <= 1 ; memAddressSel <= 0; end
			s2: begin end
			sAddress: begin memRead <= 1 ;  IRwritePart2 <= 1 ; pcWrite <= 1 ; memAddressSel <= 0; end
			sLDA1: begin memRead <= 1; memAddressSel <= 1;end
			sLDA2: begin ACwrite <= 1; ACdataSel <= 0; ACaddressSel <= 0; end
			sSTA1: begin ACread <= 1; ACaddressSel <= 0;  end
			sSTA2: begin  memWrite<= 1; memAddressSel <= 1; end
			sA: begin ACread <= 1; memRead <= 1; memAddressSel <= 1; end
			sADA: begin ALUcommand <= 0; end  //ADD C
			sANA: begin ALUcommand <= 1; end  //&
			SAA: begin ACwrite <= 1; ACdataSel <= 1; end
			
			// ACCUMULATOR INSTRUCTIONS

			sACCUMULATOR:
			sMVR:
			sADR:
			sANR:
			sORR:
			sACCUMULATORfinish:

			default: ps <= ps;
		endcase		
	end
	always @(ps) begin
		case(ps)
			s1: ns <= s2;
			s2: begin
				if(upcode[2:0] == 3'b000 || upcode[2:0] == 3'b001 || 
				   upcode[2:0] == 3'b010 || upcode[2:0] == 3'b011) ns <= sAddress;
			end
			sAddress: begin
				if (upcode[2:0] == 3'b000) ns <= sLDA1;
				else if( upcode[2:0] == 3'b001) ns <= sSTA1;
				else if( upcode[2:0] == 3'b010 || upcode[2:0] == 3'b011) ns <= sA;
			end
			sLDA1: ns <= sLDA2;
			sLDA2: ns <= s1;
			sSTA1: ns <= sSTA2;
			sSTA2: ns <= s1;
			sA: begin
				if( upcode[2:0] == 3'b010) ns <= sADA;
				else if (upcode[2:0] == 3'b011) ns <= sANA;
			end
			sADA: ns <= SAA;
			sANA: ns <= SAA;
			SAA: ns <= s1;
			default: ps <= ps;
		endcase		
	end
	always @(posedge clk or posedge rst) begin
		if (rst) begin 
			ps <= s1;
			{pcWrite, memAddressSel, ACdataSel, memRead, ACwrite, ACread, memWrite, IRwritePart1, IRwritePart2} = 20'b0;
		end
		else ps <= ns;
	end


endmodule
