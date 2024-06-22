`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2024 09:27:32
// Design Name: 
// Module Name: bitsplitter
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


module bitsplitter(
input [7:0]data,
input clk,ld,
output [3:0]sheve,
output [3:0]shodd,
output next1,next2);

wire outpiso,outtff,even,odd;

piso dut1(data,clk,ld,outpiso);

t_ff dut2(clk,ld,outtff);

mux evendut(outpiso,1'b0,outtff,even);

mux odddut (1'b0,outpiso,outtff,odd);

sipo dut3(even,odd,clk,outtff,ld,sheve,shodd,next1,next2);

endmodule
