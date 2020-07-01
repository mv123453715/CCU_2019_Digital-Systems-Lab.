module MPY(clk,a, b, p);
    input [31:0] a, b;
	input clk;
    output [63:0] p;
    wire [32:0] add[31:0] ;
    wire [63:0] add_ext[31:0];
	
    booth_add booth1(a, {b[0],1'b0}, add[0]);
    booth_add booth2(a, b[1:0], add[1]);
    booth_add booth3(a, b[2:1], add[2]);
    booth_add booth4(a, b[3:2], add[3]);
	booth_add booth5(a, b[4:3], add[4]);
	booth_add booth6(a, b[5:4], add[5]);
	booth_add booth7(a, b[6:5], add[6]);
	booth_add booth8(a, b[7:6], add[7]);
	booth_add booth9(a, b[8:7], add[8]);
	booth_add booth10(a, b[9:8], add[9]);
	booth_add booth11(a, b[10:9], add[10]);
	booth_add booth12(a, b[11:10], add[11]);
	booth_add booth13(a, b[12:11], add[12]);
	booth_add booth14(a, b[13:12], add[13]);
	booth_add booth15(a, b[14:13], add[14]);
	booth_add booth16(a, b[15:14], add[15]);
	booth_add booth17(a, b[16:15], add[16]);
	booth_add booth18(a, b[17:16], add[17]);
	booth_add booth19(a, b[18:17], add[18]);
	booth_add booth20(a, b[19:18], add[19]);
	booth_add booth21(a, b[20:19], add[20]);
	booth_add booth22(a, b[21:20], add[21]);
	booth_add booth23(a, b[22:21], add[22]);
	booth_add booth24(a, b[23:22], add[23]);
	booth_add booth25(a, b[24:23], add[24]);
	booth_add booth26(a, b[25:24], add[25]);
	booth_add booth27(a, b[26:25], add[26]);
	booth_add booth28(a, b[27:26], add[27]);
	booth_add booth29(a, b[28:27], add[28]);
	booth_add booth30(a, b[29:28], add[29]);
	booth_add booth31(a, b[30:29], add[30]);
	booth_add booth32(a, b[31:30], add[31]);
	
	/*
	always @(*) begin
		for(idx=1; idx <=31; idx = idx +1)begin
			add_ext[idx] <= {{(32-idx){add[idx][32]}}, add[idx], 1'b0};
		end
	end
	*/
	
	
    assign add_ext[0] = {{31{add[0][32]}}, add[0]};
    assign add_ext[1] = {{30{add[1][32]}}, add[1], 1'b0};
	assign add_ext[2] = {{29{add[2][32]}}, add[2], 2'b0};
	assign add_ext[3] = {{28{add[3][32]}}, add[3], 3'b0};
	assign add_ext[4] = {{27{add[4][32]}}, add[4], 4'b0};
	assign add_ext[5] = {{26{add[5][32]}}, add[5], 5'b0};
	assign add_ext[6] = {{25{add[6][32]}}, add[6], 6'b0};
	assign add_ext[7] = {{24{add[7][32]}}, add[7], 7'b0};
	assign add_ext[8] = {{23{add[8][32]}}, add[8], 8'b0};
	assign add_ext[9] = {{22{add[9][32]}}, add[9], 9'b0};
	assign add_ext[10] = {{21{add[10][32]}}, add[10], 10'b0};
	assign add_ext[11] = {{20{add[11][32]}}, add[11], 11'b0};
	assign add_ext[12] = {{19{add[12][32]}}, add[12], 12'b0};
	assign add_ext[13] = {{18{add[13][32]}}, add[13], 13'b0};
	assign add_ext[14] = {{17{add[14][32]}}, add[14], 14'b0};
	assign add_ext[15] = {{16{add[15][32]}}, add[15], 15'b0};
	assign add_ext[16] = {{15{add[16][32]}}, add[16], 16'b0};
	assign add_ext[17] = {{14{add[17][32]}}, add[17], 17'b0};
	assign add_ext[18] = {{13{add[18][32]}}, add[18], 18'b0};
	assign add_ext[19] = {{12{add[19][32]}}, add[19], 19'b0};
	assign add_ext[20] = {{11{add[20][32]}}, add[20], 20'b0};
	assign add_ext[21] = {{10{add[21][32]}}, add[21], 21'b0};
	assign add_ext[22] = {{9{add[22][32]}}, add[22], 22'b0};
	assign add_ext[23] = {{8{add[23][32]}}, add[23], 23'b0};
	assign add_ext[24] = {{7{add[24][32]}}, add[24], 24'b0};
	assign add_ext[25] = {{6{add[25][32]}}, add[25], 25'b0};
	assign add_ext[26] = {{5{add[26][32]}}, add[26], 26'b0};
	assign add_ext[27] = {{4{add[27][32]}}, add[27], 27'b0};
	assign add_ext[28] = {{3{add[28][32]}}, add[28], 28'b0};
	assign add_ext[29] = {{2{add[29][32]}}, add[29], 29'b0};
	assign add_ext[30] = {{1{add[30][32]}}, add[30], 30'b0};
	assign add_ext[31] = { add[31], 31'b0};
	
    assign p = add_ext[0] + add_ext[1] + add_ext[2] + add_ext[3] + add_ext[4] + add_ext[5] + add_ext[6] + add_ext[7] + add_ext[8] + add_ext[9] + add_ext[10] 
	+ add_ext[11] + add_ext[12] + add_ext[13] + add_ext[14] + add_ext[15] + add_ext[16] + add_ext[17] + add_ext[18] + add_ext[19] + add_ext[20] 
	+ add_ext[21] + add_ext[22] + add_ext[23] + add_ext[24] + add_ext[25] + add_ext[26] + add_ext[27] + add_ext[28] + add_ext[29] + add_ext[30] 
	+ add_ext[31];
endmodule

module booth_add(a, b, ab);
    input [31:0] a;
    input [1:0] b;
    wire signed [32:0] a_ext;
    output [32:0] ab;

    assign a_ext = {a[31],a};
    assign ab = (b==2'b01) ? a_ext:
                (b==2'b10) ? -a_ext:
                             33'b0;                                
endmodule