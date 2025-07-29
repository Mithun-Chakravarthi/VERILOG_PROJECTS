module a_rca_4bit(a,b,sum,carry);
input [3:0]a;
input [3:0]b;
output [3:0]sum;
output carry;
wire [3:0]c;
AFA f1(a[0],b[0],1'b0,sum[0],c[0]);
AFA f2(a[1],b[1],c[0],sum[1],c[1]);
AFA f3(a[2],b[2],c[1],sum[2],c[2]);
AFA f4(a[3],b[3],c[2],sum[3],c[3]);
assign carry=c[3];
endmodule


module a_rca_4bit_tb();
reg [3:0]a;
reg [3:0]b;
wire [3:0]sum;
wire carry;
a_rca_4bit dut(a,b,sum,carry);
initial begin
a=4'b0;b=4'b0;
#10 a=4'b1010; b=4'b1101;
#10 a=4'b0101;b=4'b1011;
end
initial #40 $stop;
endmodule
