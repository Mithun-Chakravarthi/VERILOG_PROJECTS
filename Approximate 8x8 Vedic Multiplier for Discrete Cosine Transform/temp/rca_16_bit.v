module O_RCA_16_BIT(a,b,sum,cout);
input [15:0]a,b;
output [15:0]sum;
output cout;
wire [15:0]c;


OFA f1(a[0],b[0],1'b0,sum[0],c[0]);
OFA f2(a[1],b[1],c[0],sum[1],c[1]);
OFA f3(a[2],b[2],c[1],sum[2],c[2]);
OFA f4(a[3],b[3],c[2],sum[3],c[3]);
OFA f5(a[4],b[4],c[3],sum[4],c[4]);
OFA f6(a[5],b[5],c[4],sum[5],c[5]);
OFA f7(a[6],b[6],c[5],sum[6],c[6]);
OFA f8(a[7],b[7],c[6],sum[7],c[7]);
OFA f9(a[8],b[8],c[7],sum[8],c[8]);
OFA f10(a[9],b[9],c[8],sum[9],c[9]);
OFA f11(a[10],b[10],c[9],sum[10],c[10]);
OFA f12(a[11],b[11],c[10],sum[11],c[11]);
OFA f13(a[12],b[12],c[11],sum[12],c[12]);
OFA f14(a[13],b[13],c[12],sum[13],c[13]);
OFA f15(a[14],b[14],c[13],sum[14],c[14]);
OFA f16(a[15],b[15],c[14],sum[15],c[15]);

assign cout=c[15];

endmodule
