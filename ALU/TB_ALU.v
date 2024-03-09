`timescale 1ns / 1ps
module tb_alu;


reg [2:0]opcode;
reg [31:0]operand1;
reg [31:0]operand2;
wire[63:0]result;
wire flagc;
wire flagz;

//instantiation of dut

ALU dut(opcode,operand1,operand2,result,flagc,flagz);

integer i;

initial begin

operand1=32'd2;
operand2=32'd3;



for(i=0;i<8;i=i+1) begin

opcode=i;
#10;
end

#100 $stop;

end


endmodule




















