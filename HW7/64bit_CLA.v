`timescale 1ns/1ps
module CLA_64bit(a,b,cin,sum,cout);
    input [63:0] a,b;
    input cin;
    output [63:0] sum;
    output cout;
    
    //---Write down your design here---//

	wire [63:0] g,p,c;
	wire [15:0]c4_c64,gG,gP;
	wire [2:0]c_temp;
	
	//generate g & p
    gp_generator gp_geneator1(a[3:0]  ,b[3:0]  ,g[3:0]  ,p[3:0]); 
    gp_generator gp_geneator2(a[7:4]  ,b[7:4]  ,g[7:4]  ,p[7:4]);
	gp_generator gp_geneator3(a[11:8] ,b[11:8] ,g[11:8] ,p[11:8]);
	gp_generator gp_geneator4(a[15:12],b[15:12],g[15:12],p[15:12]);
	gp_generator gp_geneator5(a[19:16],b[19:16],g[19:16],p[19:16]);
	gp_generator gp_geneator6(a[23:20],b[23:20],g[23:20],p[23:20]);
	gp_generator gp_geneator7(a[27:24],b[27:24],g[27:24],p[27:24]);
	gp_generator gp_geneator8(a[31:28],b[31:28],g[31:28],p[31:28]);
	gp_generator gp_geneator9(a[35:32],b[35:32],g[35:32],p[35:32]);
	gp_generator gp_geneator10(a[39:36],b[39:36],g[39:36],p[39:36]);
	gp_generator gp_geneator11(a[43:40],b[43:40],g[43:40],p[43:40]);
	gp_generator gp_geneator12(a[47:44],b[47:44],g[47:44],p[47:44]);
	gp_generator gp_geneator13(a[51:48],b[51:48],g[51:48],p[51:48]);
	gp_generator gp_geneator14(a[55:52],b[55:52],g[55:52],p[55:52]);
	gp_generator gp_geneator15(a[59:56],b[59:56],g[59:56],p[59:56]);
	gp_generator gp_geneator16(a[63:60],b[63:60],g[63:60],p[63:60]);
	
	// has bug
    //generate c0,c4,c8,c12,
    carry_generator carry_geneator_c0(g[3:0]   ,p[3:0]   ,c4_c64[0]  ,c[3:0]   ,gG[0],gP[0],);
	carry_generator carry_geneator_c4(g[7:4]   ,p[7:4]   ,c4_c64[1]  ,c[7:4]   ,gG[1],gP[1],);
	carry_generator carry_geneator_c8(g[11:8]  ,p[11:8]  ,c4_c64[2]  ,c[11:8]  ,gG[2],gP[2],);
	carry_generator carry_geneator_c12(g[15:12],p[15:12] ,c4_c64[3]  ,c[15:12] ,gG[3],gP[3],);
    
	//c16,c20,c24,c28
	carry_generator carry_geneator_c16(g[19:16],p[19:16] ,c4_c64[4],c[19:16] ,gG[4],gP[4],);
	carry_generator carry_geneator_c20(g[23:20],p[23:20] ,c4_c64[5],c[23:20] ,gG[5],gP[5],);
	carry_generator carry_geneator_c24(g[27:24],p[27:24] ,c4_c64[6],c[27:24] ,gG[6],gP[6],);
	carry_generator carry_geneator_c28(g[31:28],p[31:28] ,c4_c64[7],c[31:28] ,gG[7],gP[7],);
	
	//c32,c36,c40,c44
	carry_generator carry_geneator_c32(g[35:32],p[35:32] ,c4_c64[8] ,c[35:32] ,gG[8],gP[8],);
	carry_generator carry_geneator_c36(g[39:36],p[39:36] ,c4_c64[9] ,c[39:36] ,gG[9],gP[9],);
	carry_generator carry_geneator_c40(g[43:40],p[43:40] ,c4_c64[10],c[43:40] ,gG[10],gP[10],);
	carry_generator carry_geneator_c44(g[47:44],p[47:44] ,c4_c64[11],c[47:44] ,gG[11],gP[11],);


	//c48,c52,c56,c60
	carry_generator carry_geneator_c48(g[51:48],p[51:48] ,c4_c64[12],c[51:48] ,gG[12],gP[12],);
	carry_generator carry_geneator_c52(g[55:52],p[55:52] ,c4_c64[13],c[55:52] ,gG[13],gP[13],);
	carry_generator carry_geneator_c56(g[59:56],p[59:56] ,c4_c64[14],c[59:56] ,gG[14],gP[14],);
	carry_generator carry_geneator_c60(g[63:60],p[63:60] ,c4_c64[15],c[63:60] ,gG[15],gP[15],);	
	
	
	//generate c16,c32,c48,c64
	carry_generator carry_geneator_merge_c16(gG[3:0]   ,gP[3:0]   ,cin  ,c4_c64[3:0]  ,,,c_temp[0]);
	carry_generator carry_geneator_merge_c32(gG[7:4]   ,gP[7:4]   ,c_temp[0],c4_c64[7:4]  ,,,c_temp[1]);
	carry_generator carry_geneator_merge_c48(gG[11:8]  ,gP[11:8]  ,c_temp[1],c4_c64[11:8] ,,,c_temp[2]);
	carry_generator carry_geneator_merge_c64(gG[15:12] ,gP[15:12] ,c_temp[2],c4_c64[15:12],,,cout);
	
	
    //generate sum
    sum_geneator geneate_sum(a[63:0],b[63:0],c[63:0],sum[63:0]);  
	
    //---------------------------------//

endmodule


module gp_generator(a,b,g,p);

    input [3:0] a,b;
    output [3:0] g,p;
    
    // g = a x b && p = a + b
    assign g = a & b;
    assign p = a | b;

endmodule





module carry_generator(g,p,cin,c,gG,gP,cout);

    input [3:0] g,p;
    input cin;
    output gG,gP;
    output [3:0] c;
    output cout;

    //create gG and gP
    assign gG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
	assign gP = p[3] & p[2] & p[1] & p[0];
	
    assign c[0] = cin;
    //create carrys
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

    //cout
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

endmodule






module sum_geneator(a,b,c,sum);

    input [63:0] a,b;
    input [63:0] c;
    output [63:0] sum;

    //sum = a ^ b ^ c;
    assign sum = a ^ b ^ c;

endmodule
