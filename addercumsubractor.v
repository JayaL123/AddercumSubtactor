`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2025 15:21:51
// Design Name: 
// Module Name: addercumsubractor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module addercumsubractor(input [3:0]a,b,input cntr_in,output cy,output [3:0]f);
wire cy1;
wire [3:0]s,S;
wire [3:0]B;
wire cin,n;
assign B[3]=b[3]^cntr_in;
assign B[2]=b[2]^cntr_in;
assign B[1]=b[1]^cntr_in;
assign B[0]=b[0]^cntr_in;
RCA  a1(a,B,cntr_in,cy1,s);
assign cin=cntr_in&(~cy1);
assign S[3]=s[3]^cin;
assign S[2]=s[2]^cin;
assign S[1]=s[1]^cin;
assign S[0]=s[0]^cin;
RCA  a2(4'b0000,S,cin,n,f);
assign cy=cntr_in^cy1;
endmodule

module tb_adcumsub();
reg [3:0]a,b;
reg cntr_in;
wire cy;
wire [3:0]f;
addercumsubractor     dut(a,b,cntr_in,cy,f);
initial begin
$monitor("  cntr_in=%b   a=%d  b=%d     cy=%b    sum=%b",cntr_in,a,b,cy,f);
end
initial begin
cntr_in=1'b0;a=4'b1010;b=4'b0101;
#5 cntr_in=1'b1;a=4'b1010;b=4'b0101;
#5 cntr_in=1'b1;a=4'b0101;b=4'b1010;
#5 cntr_in=1'b0;a=4'b0011;b=4'b0100;
#5 cntr_in=1'b1;a=4'b1111;b=4'b1010;
#5 $finish;
end
endmodule
