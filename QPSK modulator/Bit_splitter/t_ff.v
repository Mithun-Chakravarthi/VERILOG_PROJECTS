`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2024 14:36:31
// Design Name: 
// Module Name: t_ff
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


module t_ff(
input clk,reset,output reg tout);
//In this t ff generally one of the input t=1 always.
always@(posedge clk or posedge reset)//synchronous reset
begin

if(reset)
 begin
 tout<=0;
 end
 
else
    begin
    tout<=~tout;
    end
end
    
endmodule
