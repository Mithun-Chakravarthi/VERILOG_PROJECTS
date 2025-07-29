module NVM_4bit(a,b,s);
input [3:0]a;
input [3:0]b;
output [7:0]s;

wire [3:0]w1,w2,w3,w4;
wire [3:0]rca1_sum,rca2_sum,rca3_sum;
wire [3:1]rca_ca;
wire w5,w6;
wire [1:0]rca_out;
wire carry;

OVM_2bit uut1(a[1:0],b[1:0],w1);
OVM_2bit uut2(a[3:2],b[1:0],w2);
OVM_2bit uut3(a[1:0],b[3:2],w3);
OVM_2bit uut4(a[3:2],b[3:2],w4);



o_rca_4bit uut5(w3,w2,rca1_sum,rca_ca[1]);

o_rca_4bit uut6(rca1_sum,{w4[1:0],w1[3:2]},rca2_sum,rca_ca[2]);

OHA uut7(rca_ca[1],rca_ca[2],w5,w6);
 
o_rca_2bit uut8(w4[3:2],{w6,w5},rca_out,carry);

assign s={rca_out,rca2_sum,w1[1:0]};

endmodule
///////////TEST BENCH////////////////////////

module tb_nvm_4_bit();
reg [3:0]a;
reg [3:0]b;
wire [7:0]s;

integer i,j;
NVM_4bit test(a,b,s);
initial begin
for(i=0;i<16;i=i+1)
begin
	assign a=i;
	for(j=0;j<=16;j=j+1)
		begin
		assign b=j;
		#5;	
		end
#5;
end
end

initial begin
$monitor("a = %b, b = %b ,  sum = %b ",a,b,s);
end

initial #2000 $stop;
endmodule

