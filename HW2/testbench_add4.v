`timescale 1ns / 1ps
module testbench_add4;

reg [3:0] a, b,c ,d;
wire [3:0] sum;
wire ov;
reg clk;
reg	rst;
reg [3:0] correct_sum;
reg [32:0] test_num;
reg s4;
reg s5;
reg correct_ov;

always #5 clk = ~clk;
always #5 rst = ~rst;

add4 DUT(a, b,c,d, sum, ov);

initial
begin
	clk <= 0;
	rst <= 0;
	a <= 0; 
	b <= 0;
	c <= 0;
	d <= 0;
	test_num <= 0;
	$dumpfile("add4.vcd");
	$dumpvars;
end

always@(posedge clk or negedge rst)
begin
	if(rst)begin
		if(a <= 15) begin 
			a <= a + 1;
			test_num <= test_num + 1;
		end 
		if(a ==15) begin
			a <= 0;
			b <= b + 1;
		end
		if(b == 15 && a == 15) begin
			a <= 0;
			b <= 0;
			c <= c + 1;
		end
		if(b == 15 && a == 15&&c ==15) begin
			a <= 0;
			b <= 0;
			c <= 0;
			d <= d + 1;		
		end
		//d <= {$random} % 16;
	end
	else begin
		{s4,s5, correct_sum} = a + b+c+d;
		correct_ov = s4 || s5;
		if({ov, sum} == {correct_ov, correct_sum}) begin
			$display ("Test %d ", test_num);
			$display ("OK!");
			$display ("%d + %d + %d + %d = ?", a, b,c,d);
			$display ("your answer: ov = %d, sum = %d", ov, sum);
			$display ("correct answer: ov = %d, sum = %d", ov, sum);
			$display ("\n");
		end
		else begin
			$display ("Test %d ", test_num);
			$display ("/////////////////////");
			$display ("////////Fail!////////");
			$display ("/////////////////////");
			$display ("%d + %d + %d + %d = ?", a, b,c,d);
			$display ("your answer: ov = %d, sum = %d", ov, sum);
			$display ("correct answer: ov = %d, sum = %d", correct_ov, correct_sum);
			$display ("\n");
		end
	end
end
initial #205 $finish;
endmodule



