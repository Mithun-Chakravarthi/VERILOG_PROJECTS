module O_RCA_8_BIT(a,b,sum,cout);
input [7:0]a,b;
output [7:0]sum;
output cout;
wire [7:0]c;


OFA f1(a[0],b[0],1'b0,sum[0],c[0]);
OFA f2(a[1],b[1],c[0],sum[1],c[1]);
OFA f3(a[2],b[2],c[1],sum[2],c[2]);
OFA f4(a[3],b[3],c[2],sum[3],c[3]);
OFA f5(a[4],b[4],c[3],sum[4],c[4]);
OFA f6(a[5],b[5],c[4],sum[5],c[5]);
OFA f7(a[6],b[6],c[5],sum[6],c[6]);
OFA f8(a[7],b[7],c[6],sum[7],c[7]);

assign cout=c[7];

endmodule

module tb_RCA_8_bit();
reg [7:0]a,b;
wire [7:0]sum;
wire cout;
O_RCA_8_BIT dut(a,b,sum,cout);

initial begin
a=8'b10110101;
b=8'b11101101;
#10 b=8'b10100111;
#10 a=8'b00101101;
end

initial begin
$monitor("T=%2d,a=%b,b=%b,sum=%b,cout=%b",$time,a,b,sum,cout);
end

initial #40 $stop;
endmodule

