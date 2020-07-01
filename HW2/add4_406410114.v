module add4(a, b, c,d, sum, ov);

	input [3:0] a, b, c,d;
	output [3:0] sum;
	output ov;
	wire s5, s4;
	wire [3:0] sum0;

	add3 d0(a,b,c,sum0,s4);
	add3 d1(sum0,0,d,sum,s5);
	assign ov = s5 || s4;
			
endmodule

module add3(a, b, c, sum, ov);

	input [3:0] a, b, c;
	output [3:0] sum;
	output ov;

	assign {ov , sum} = a + b + c;
			
endmodule