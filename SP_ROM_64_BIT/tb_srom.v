module tb_rom;

reg clk,rst,en;
reg [3:0]addr;
wire [3:0]outdata;

single_port_rom dut(clk,rst,en,addr,outdata);


initial begin
en=1'b0;clk=1'b0;
#10; en=1'b1; 
addr=4'b1010;
#10; addr=4'b1011;
#10; addr=4'b1001;
#10; en=1'b0;addr=4'b1111;
#10; en=1'b1; addr=4'b1000;
#10; addr=4'b0000;
#10; addr=4'bxxxx;
end

always #10 clk=~clk;

initial begin
rst=0;
#10; rst=1;
#10; rst=0;
end




initial begin
#100 $stop;
end

  

endmodule


