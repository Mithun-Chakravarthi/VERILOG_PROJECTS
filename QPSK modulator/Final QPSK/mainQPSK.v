`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2024 12:29:03
// Design Name: 
// Module Name: mainQPSK
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


module mainQPSK(
 input [7:0]data,
    input clk,ld,
    output [7:0]qpskout
    );
    wire [3:0]Sheve,Shodd;
    wire even,odd;
    bitsplitter BS(data,clk,ld,Sheve,Shodd,next1,next2);
    Synchronizer QP(Sheve,Shodd,clk,ld,next1,next2,even,odd);
    lastqpsk qpsk(clk,even,odd,ld,next1,next2,qpskout); 
endmodule
