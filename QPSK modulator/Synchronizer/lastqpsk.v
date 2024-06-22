`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2024 12:29:03
// Design Name: 
// Module Name: lastqpsk
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


module lastqpsk(
    input clk,dataeve,dataodd,reset,next1,next2,
    output reg [7:0]avgout
    );
    wire [7:0]sineout,cosout;
    sinewave Seve(clk,dataeve,reset,next1,next2,sineout);
    coswave Codd(clk,dataodd,reset,next1,next2,cosout);
    always @(posedge clk)
    begin
        avgout=(sineout+cosout);
    end
endmodule