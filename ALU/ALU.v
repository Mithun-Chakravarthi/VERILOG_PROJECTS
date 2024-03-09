`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: BUNGATAVALA MITHUN CHAKRAVARTHI
// Create Date: 22.02.2024 20:33:38
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ALU
(opcode,operand1,operand2,result,flagc,flagz);

input [2:0]opcode;
input [31:0]operand1;
input [31:0]operand2;
output reg [63:0]result=64'b0;
output reg flagc=1'b0,flagz=1'b0;

parameter [2:0] ADD=3'b000,
SUB=3'b001,
MUL=3'b010,
AND=3'b011,
OR=3'b100,
NAND=3'b101,
NOR=3'b110,
XOR=3'b111;

always @(opcode or operand1 or operand2)
begin

case(opcode)

ADD:begin
result =operand1+operand2;
flagc=result[32];
flagz=(result==16'b0);
end

SUB:begin
result =operand1-operand2;
flagc=result[32];
flagz=(result==16'b0);
end


MUL:begin
result =operand1*operand2;
flagz=(result==16'b0);
end
    
      
AND:begin
result =operand1&operand2;
flagz=(result==16'b0);
end

OR:begin
result =operand1|operand2;
flagz=(result==16'b0);
end


NAND:begin
result =~(operand1&operand2);
flagz=(result==16'b0);
end


NOR:begin
result =~(operand1|operand2);
flagz=(result==16'b0);
end


XOR:begin
result =operand1^operand2;
flagz=(result==16'b0);
end

default:begin
result=64'b0;
flagc=1'b0;
flagz=1'b0;
end
endcase
end

    
endmodule