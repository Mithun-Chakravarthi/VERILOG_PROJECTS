module single_port_rom(
clk,rst,en,addr,outdata);

input clk,rst,en;
input [3:0]addr;
output reg [3:0]outdata;

reg [3:0]mem[15:0];

always@(posedge clk)
begin

if(rst)
	begin
	outdata<=4'b0;
	end
else
	begin
	
	if(en==1) 
		begin
		outdata<=mem[addr];
		end
	else
		begin
		outdata<=4'bx;
		end

end

end

//loading data to registers:

initial begin
mem[0]=4'b1111;
mem[1]=4'b0111;
mem[2]=4'b1011;
mem[3]=4'b1101;
mem[4]=4'b1001;
mem[5]=4'b0011;
mem[6]=4'b1100;
mem[7]=4'b0101;

mem[8]=4'b1111;
mem[9]=4'b0111;
mem[10]=4'b1011;
mem[11]=4'b1101;
mem[12]=4'b1001;
mem[13]=4'b0011;
mem[14]=4'b1100;
mem[15]=4'b0101;
end

endmodule
