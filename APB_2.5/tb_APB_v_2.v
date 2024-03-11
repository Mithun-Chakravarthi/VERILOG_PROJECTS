module tb_m;
parameter addr_width=2;
parameter mem_width=4;
parameter mem_depth=4;
reg pclk,prst,pwrite,penable,psel;
wire pready;
reg [addr_width-1:0]paddr;
reg [mem_width-1:0]pwdata;
wire [mem_width-1:0]prdata;
integer k;

APB_V2 dut(prst,pclk,pwrite,penable,pwdata,paddr,pready,prdata,psel);

initial 
begin
	pclk=0;
	forever #5 pclk=~pclk;
end

initial 
begin
	#150 $stop;
end

initial begin
prst=0;
end

initial begin

for(k=0;k<mem_depth;k=k+1)
	begin
	@(posedge pclk);
	paddr=k;
	pwrite=1;
	pwdata=$random;
	penable=1;
	psel=1;
	wait(pready==1);
	end
	@(posedge pclk);
	paddr=0;
	pwrite=0;
	pwdata=0;
	penable=0;
	psel=0;


for(k=0;k<mem_depth;k=k+1)
	begin
	@(posedge pclk);
	paddr=k;
	pwrite=0;
	//indata=$random;
	penable=1;
	psel=1;
	wait(pready==1);
	end

	@(posedge pclk);
	paddr=0;
	pwrite=0;
	//indata=0;
	penable=0;
	psel=0;

end

endmodule