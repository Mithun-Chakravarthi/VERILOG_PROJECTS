module AFA(a,b,cin,sum,cout);
input a,b,cin;
output sum,cout;
wire s1,c1,c2;
NHA dut1(a,b,s1,c1);
NHA dut2(s1,cin,sum,c2);
assign cout=(c1|c2);
endmodule

module tb_fa();
reg a,b,cin;
wire sum,cout;
integer i;
AFA dut(a,b,cin,sum,cout);

initial begin

for(i=0;i<8;i=i+1)
begin
{a,b,cin}=i;  #5;
$display("T=%2d,a=%b,b=%b,cin=%b,sum=%b,cout=%b",$time,a,b,cin,sum,cout);
end

#5 $finish;
end

endmodule
