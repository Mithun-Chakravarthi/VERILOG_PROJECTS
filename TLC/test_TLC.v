`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: BUNGATAVALA MITHUN CHAKRAVARTHI
// 
// Create Date: 25.02.2024 20:57:06
// Design Name: 
// Module Name: test_TLC
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


module test_TLC;
    reg clk,rst;
    wire [3:0]count;
    wire[1:0]ps_state;
    
 TLC dut(clk,rst,count,ps_state);
 initial begin
 clk=1; rst=1;
 #10 rst=0;
 end
 
 always #10 clk=~clk;
  
  initial begin
  #600 $stop;
  end

endmodule
