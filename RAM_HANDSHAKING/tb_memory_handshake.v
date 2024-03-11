module tb_memory_handshkae;
parameter addr_width=2;
parameter mem_width=4;
parameter mem_depth=4;
reg clk,rst,wr,valid;
wire ready;
reg [addr_width-1:0]addr;
reg [mem_width-1:0]indata;
wire [mem_width-1:0] outdata;
integer k;

memory_handshake dut(rst,clk,wr,valid,indata,addr,ready,outdata);

initial 
begin
	clk=0;
	forever #5 clk=!clk;
end

initial 
begin
	#150 $stop;
end

initial begin
rst=0;
end

initial begin

for(k=0;k<mem_depth;k=k+1)
	begin
	@(posedge clk);
	addr=k;
	wr=1;
	indata=$random;
	valid=1;
	wait(ready==1);
	end
	@(posedge clk);
	addr=0;
	wr=0;
	indata=0;
	valid=0;


for(k=0;k<mem_depth;k=k+1)
	begin
	@(posedge clk);
	addr=k;
	wr=0;
	//indata=$random;
	valid=1;
	wait(ready==1);
	end

	@(posedge clk);
	addr=0;
	wr=0;
	//indata=0;
	valid=0;

end

endmodule