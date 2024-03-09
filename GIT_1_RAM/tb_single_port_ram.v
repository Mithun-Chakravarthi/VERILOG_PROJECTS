`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2024 19:20:48
// Design Name: 
// Module Name: tb_single_port_ram
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


module tb_single_port_ram( );
reg clk,rst,en,wr;
reg [7:0]indata;
reg [5:0]addr;
wire [7:0]outdata;

s_port_ram dut(clk,rst,en,wr,addr,indata,outdata);

always #10 clk=~clk;
initial 

begin
rst=1'b1;clk=1'b0;en=0;wr=0;indata=8'hAA;addr=6'h0A;
#10 rst=0;
#10 en=1;wr=1;
#10 indata=8'hAB;addr=6'h0C;
#10 en=1;wr=1;
#10 en=1;wr=0;
#10 addr=6'h0A;
#10 addr=6'h0C;
end
initial #200 $stop;

endmodule
