module memory_handshake(rst,clk,wr,valid,indata,addr,ready,outdata);
parameter addr_width=2;
parameter mem_width=4;
parameter mem_depth=4;
input clk,rst,wr,valid;
output reg ready;
input [addr_width-1:0]addr;
input [mem_width-1:0]indata;
output reg [mem_width-1:0] outdata;
reg [mem_width-1:0] mem [mem_depth-1:0];

integer d;
always @(posedge clk) 

begin
	if(rst)
		begin
		ready=0;
		outdata=0;
		for(d=0;d<mem_depth;d=d+1)
			begin
			mem[d]=0;
			end
		end
	else 
		begin
		if(valid)
			begin
			ready=1;
		if(wr)
			begin
			mem[addr]=indata;
			end
		else
			begin
			outdata=mem[addr];
			end
		end
	else //for valid=0
		begin
		ready=0;
		end

		end
		end

endmodule
