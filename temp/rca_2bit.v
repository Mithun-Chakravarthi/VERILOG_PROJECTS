module o_rca_2bit(a,b,sum,carry);
input [1:0]a;
input [1:0]b;
output [1:0]sum;
output carry;
wire [1:0]c;
OFA f1(a[0],b[0],1'b0,sum[0],c[0]);
OFA f2(a[1],b[1],c[0],sum[1],c[1]);
assign carry=c[1];
endmodule


module rca_2bit_tb();
reg [1:0]a;
reg [1:0]b;
wire [1:0]sum;
wire carry;
o_rca_2bit dut(a,b,sum,carry);
initial begin
a=2'b0;b=2'b0;
#10 a=2'b01; b=2'b11;
#10 a=2'b10;b=2'b11;
end
initial #40 $stop;
endmodule