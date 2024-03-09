`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: BUNGATAVALA MITHUN CHAKRAVARTHI
// Create Date: 23.02.2024 19:06:34
// Design Name: SINGLE_PORT_RAM_OF_64_BIT_DEPTH  
// Module Name: s_port_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module s_port_ram(
clk,rst,en,wr,addr,indata,outdata
    );
input clk,rst,en,wr;
input [7:0]indata;
output reg [7:0]outdata;
input [5:0]addr;

reg [7:0]mem[63:0]; //creates 64 bit memories

always @(posedge clk)
begin
if(rst)
begin outdata<=8'b0; end

else //if reset=0 i should write and read from memory based on en and wr signal

begin
if(en==1 && wr==1) //perform write operation
        begin
        mem[addr]<=indata;
        end
else if(en==1 && wr==0)
        begin
        outdata<=mem[addr]; 
        end
        
else begin
outdata<=8'bxxxxxxxx;
 end
 
end
end
endmodule
