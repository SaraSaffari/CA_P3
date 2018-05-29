// resultRegEn      dataRegEn      wordRegEn   
// CEn   ZEn    NEn



module controller(clk, rst, Dupcode, pcWrite, memAddressSel, pcDataSel, ACdataSel, memRead, ACwrite, ACread, memWrite, ALUcommand,
				 IRwritePart1, IRwritePart2,
				ALUBinputSel, DIwrite, ACaddressSel, 
				resultRegEn, dataRegEn, wordRegEn, CEn, ZEn, NEn, C, Z, N, jmpCond);
	
	input clk, rst;
	input [3:0] Dupcode;
	input [1:0] jmpCond;
	reg [3:0] upcode;
	output reg pcWrite, memAddressSel, pcDataSel, memRead, ACwrite, ACread, memWrite, IRwritePart1, IRwritePart2, DIwrite;
	output resultRegEn, dataRegEn, wordRegEn;
	output reg CEn, ZEn, NEn;
	assign resultRegEn = 1, dataRegEn = 1, wordRegEn = 1; 
	input C, Z, N;
	output reg [1:0] ACdataSel;
	output reg [1:0] ACaddressSel;
	output reg ALUBinputSel;
	output reg [2:0] ALUcommand;
	parameter [4:0] fakeState = 5'd20, fakeState2 = 5'd21, s1 = 5'd1, s2 = 5'd2, sAddress = 5'd3, sLDA1 = 5'd4, sLDA2 = 5'd5, sSTA1 = 5'd6, 
		sSTA2 = 5'd7, sA = 5'd8, sADA = 5'd9, sANA = 5'd10, SAA = 5'd11, sACCUMULATOR = 5'd12, sMVR = 5'd13, 
		sADR = 5'd14, sANR = 5'd15, sORR = 5'd16, sOAA = 5'd17, sLDI = 5'd18, sJMP = 5'd19;

		//sA is the first state of ADA/ANA branch and SAA is the last state of this branch
		//sOAA is the last state of OOR/ANR/ADR branch
		

	reg [4:0] ps = 0, ns;
	always @(ps) begin
		{pcWrite, memRead, ACwrite, ACread, memWrite, IRwritePart1, IRwritePart2, DIwrite, CEn, ZEn, NEn} <= 20'b0;
		case(ps)
			s1: begin pcWrite <= 1; memRead <= 1 ; pcDataSel <= 0; memAddressSel <= 0; end
			s2: begin IRwritePart1 <= 1; upcode <= Dupcode; end
			fakeState: begin IRwritePart2 <= 1; memRead <= 1; end
			sAddress: begin pcWrite <= 1; memRead <= 1; pcDataSel <= 0; memAddressSel <= 0; end
			fakeState2: begin memRead <= 1; pcDataSel <= 0; memAddressSel <= 0; IRwritePart2 <= 1; end
			sLDA1: begin memAddressSel <= 1; memRead <= 1; end
			sLDA2: begin ACdataSel <= 0; ACwrite <= 1; ACaddressSel <= 0; end
			sSTA1: begin ACaddressSel <= 0; ACread <= 1; end
			sSTA2: begin  memWrite<= 1; memAddressSel <= 1; end
			sA: begin ACaddressSel<= 0; ACread <= 1; memRead <= 1; memAddressSel <= 1; end
			sADA: begin ALUBinputSel <= 1; ALUcommand <= 0; CEn <= 1; ZEn <= 1; NEn <= 1; end  //ADD C
			sANA: begin ALUBinputSel <= 1; ALUcommand <= 1; CEn <= 1; ZEn <= 1; NEn <= 1; end  //&
			SAA: begin ACwrite <= 1; ACdataSel <= 1; ACaddressSel <= 0; end
			
			// ACCUMULATOR INSTRUCTIONS

			sACCUMULATOR: begin ACaddressSel <= 1; ACread <= 1; end
			sMVR: begin ACaddressSel <= 2; ACdataSel <= 2; ACwrite <= 1; end
			sADR: begin ALUBinputSel <= 0; ACread <= 1; ACaddressSel <= 2; ALUcommand <= 0; CEn <= 1; ZEn <= 1; NEn <= 1; end 
			sANR: begin ALUBinputSel <= 0; ACread <= 1; ACaddressSel <= 2; ALUcommand <= 1; CEn <= 1; ZEn <= 1; NEn <= 1; end
			sORR: begin ALUBinputSel <= 0; ACread <= 1; ACaddressSel <= 2; ALUcommand <= 2; CEn <= 1; ZEn <= 1; NEn <= 1; end
			sOAA: begin ACwrite <= 1; ACaddressSel <= 2; ACdataSel <= 1; end

			sLDI: begin DIwrite <= 1; end
			sJMP: begin pcDataSel <= 1; 
				if( jmpCond == 2'b00) pcWrite <= 1;
				else if(jmpCond == 2'b01 && C == 1) pcWrite <= 1;
				else if(jmpCond == 2'b10 && Z == 1 ) pcWrite <= 1;
				else if(jmpCond == 2'b11 && N == 1) pcWrite <= 1;
				else pcWrite <=0;
			end
				
			default: ps <= ps;
		endcase		
	end
	
	always @(ps) begin
		case(ps)
			s1: ns <= s2;
			s2: ns <= fakeState;
			fakeState: begin
				if(upcode[3:1] == 3'b000 || upcode[3:1] == 3'b001 || 
				   upcode[3:1] == 3'b010 || upcode[3:1] == 3'b011) ns <= sAddress;
				else if(upcode[3:0] == 4'b1000 || upcode[3:0] == 4'b1001 || 
					upcode[3:0] == 4'b1010 || upcode[3:0] == 4'b1011 ) ns <= sACCUMULATOR;
				else if(upcode[3:1] == 3'b110) ns <= sJMP;
				else ns <= sLDI;
			end
			sAddress: ns <= fakeState2;
			fakeState2: begin
				if (upcode[3:1] == 3'b000) ns <= sLDA1;
				else if( upcode[3:1] == 3'b001) ns <= sSTA1;
				else if( upcode[3:1] == 3'b010 || upcode[3:1] == 3'b011) ns <= sA;
				else ns <= ns;
			end
			sLDA1: ns <= sLDA2;
			sLDA2: ns <= s1;
			sSTA1: ns <= sSTA2;
			sSTA2: ns <= s1;
			sA: begin
				if( upcode[3:1] == 3'b010) ns <= sADA;
				else if (upcode[3:1] == 3'b011) ns <= sANA;
				else ns <= ns;
			end
			sADA: ns <= SAA;
			sANA: ns <= SAA;
			SAA: ns <= s1;

			sACCUMULATOR: begin
				if (upcode[3:0] == 4'b1000) ns <= sMVR;
				else if (upcode[3:0] == 4'b1001) ns	<= sADR;
				else if(upcode[3:0] == 4'b1010) ns <= sANR;
				else if(upcode[3:0] == 4'b1011) ns <= sORR;
				else ns <= ns;
			end

			sMVR: ns <= s1;
			sADR: ns <= sOAA;
			sANR: ns <= sOAA;
			sORR: ns <= sOAA;
			sOAA: ns <= s1;
			sLDI: ns <= s1;
			sJMP: ns <= s1;
			default: ns <= ns;
		endcase		
	end
	always @(posedge clk or posedge rst) begin
		if (rst) begin 
			ps <= s1;
			{pcWrite, memRead, ACwrite, ACread, memWrite, IRwritePart1, IRwritePart2, DIwrite, CEn, ZEn, NEn} <= 20'b0;
		end
		else ps <= ns;
	end


endmodule
