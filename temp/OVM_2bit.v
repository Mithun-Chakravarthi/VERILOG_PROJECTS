module OVM_2bit(a,b,s);
input [1:0]a;
input [1:0]b;
output [3:0]s;

wire c;
wire [3:1]w;
assign w[1]=(a[0]&b[1]);
assign w[2]=(a[1]&b[0]);
assign w[3]=(a[1]&b[1]);
assign s[0]=(a[0]&b[0]);
OHA dut1(w[2],w[1],s[1],c);
OHA dut2(w[3],c,s[2],s[3]);
endmodule


module  OVM_2bit_tb();
reg [1:0]a;
reg [1:0]b;
wire [3:0]s;

OVM_2bit dut3(a,b,s);

initial begin
a=2'b00;b=2'b00;
#10 b=2'b01;
#10 b=2'b10;
#10 b=2'b11;

#10 a=2'b01;b=2'b00;
#10 b=2'b01;
#10 b=2'b10;
#10 b=2'b11;

#10 a=2'b10;b=2'b00;
#11 b=2'b01;
#12 b=2'b10;
#13 b=2'b11;

#10 a=2'b11;b=2'b00;
#10 b=2'b01;
#10 b=2'b10;
#10 b=2'b11;
end

initial 
begin
$monitor("a = %b, b = %b ,  sum = %b ",a,b,s);
end

initial #300 $stop;
endmodule

