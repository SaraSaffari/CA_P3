module controller(clk, rst, upcode, pcWrite, memAddressSel, ACdataSel, IRwriteSel, memRead, irWrite, ACwrite, ACread, memWrite, ALUcommand);
	input clk, rst;
	input [3:0] upcode;
	output reg pcWrite, memAddressSel, ACdataSel, IRwriteSel, memRead, irWrite, ACwrite, ACread, memWrite;
	output reg [2:0] ALUcommand;
	parameter [3:0] s1 = 4'd1, s2 = 4'd2, sAddress = 4'd3, sLDA1 = 4'd4, sLDA2 = 4'd5, sSTA1 = 4'd6, 
		sSTA2 = 4'd7, sA = 4'd8, sADA = 4'd9, sANA = 4'd10, SAA = 4'd11;
		//sA is the first state of ADA/ANA branch and SAA is the last state of this branch
	reg [3:0] ps, ns;
	always @(ps) begin
		{pcWrite, memAddressSel, ACdataSel, IRwriteSel, memRead, irWrite, ACwrite, ACread, memWrite} = 0;
		case(ps)
			s1: begin memRead <= 1 ;  irWrite <= 1 ; pcWrite <= 1 ; memAddressSel <= 0; 
				IRwriteSel <= 0; end
			s2: begin end
			sAddress: begin memRead <= 1 ;  irWrite <= 1 ; pcWrite <= 1 ; memAddressSel <= 0; 
				IRwriteSel <= 1; end
			sLDA1: begin memRead <= 1; memAddressSel <= 1;end
			sLDA2: begin ACwrite <= 1; ACdataSel <= 0; end
			sSTA1: begin ACread <= 1;  end
			sSTA2: begin  memWrite<= 1; memAddressSel <= 1; end
			sA: begin ACread <= 1; memRead <= 1; memAddressSel <= 1; end
			sADA: begin ALUcommand <= 0; end  //ADD C
			sANA: begin ALUcommand <= 1; end  //&
			SAA: begin ACwrite <= 1; ACdataSel <= 1; end
			default: ps <= ps;
		endcase		
	end
	always @(ps) begin
		case(ps)
			s1: ns <= s2;
			s2: begin
				if(upcode[3:1] == 3'b000 || upcode[3:1] == 3'b001 || 
				   upcode[3:1] == 3'b010 || upcode[3:1] == 3'b011) ns <= sAddress;
			end
			sAddress: begin
				if (upcode[3:1] == 3'b000) ns <= sLDA1;
				else if( upcode[3:1] == 3'b001) ns <= sSTA1;
				else if( upcode[3:1] == 3'b010 || upcode[3:1] == 3'b011) ns <= sA;
			end
			sLDA1: ns <= sLDA2;
			sLDA2: ns <= s1;
			sSTA1: ns <= sSTA2;
			sSTA2: ns <= s1;
			sA: begin
				if( upcode[3:1] == 3'b010) ns <= sADA;
				else if (upcode[3:1] == 3'b011) ns <= sANA;
			end
			sADA: ns <= SAA;
			sANA: ns <= SAA;
			SAA: ns <= s1;
			default: ps <= ps;
		endcase		
	end
	// always @(posedge clk or posedge rst) begin
	// 	if (rst) ps <= s1;
	// 	else ps <= ns;
	// end


endmodule
