module APB_V2(prst,pclk,pwrite,penable,pwdata,paddr,pready,prdata,psel);
parameter addr_width=2;
parameter mem_width=4;
parameter mem_depth=4;
input pclk,prst,pwrite,penable,psel;
output reg pready;
input [addr_width-1:0]paddr;
input [mem_width-1:0]pwdata;
output reg [mem_width-1:0]prdata;
reg [mem_width-1:0] mem [mem_depth-1:0];

integer d;
 
always @(posedge pclk) 

begin
	if(prst)
		begin
		pready=0;
		prdata=0;
		for(d=0;d<mem_depth;d=d+1)
			begin
			mem[d]=0;
			end
		end
	else 
		begin
		if(penable==1 && psel==1)
			begin
			pready=1;
		if(pwrite)
			begin
			mem[paddr]=pwdata;
			end
		else
			begin
			prdata=mem[paddr];
			end
		end
	else //for valid=0
		begin
		pready=0;
		end

		end
		end

endmodule
