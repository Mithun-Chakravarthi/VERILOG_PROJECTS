module comrpessor_32(a,b,c,s,cout);
input a,b,c;
output s,cout;
assign s=a^b^c;
assign cout=b;
endmodule

module tb_compressor();
reg a,b,c;
wire s,cout;
integer i;

comrpessor_32 dut(a,b,c,s,cout);

initial begin
for(i=0;i<8;i=i+1)
	begin
	assign {a,b,c}=i;
	#5;
	end

end

initial begin
$monitor("a = %b, b = %b ,  c = %b,  s = %b ,  cout = %b  ",a,b,c,s,cout);
end
initial #100 $stop;

endmodule