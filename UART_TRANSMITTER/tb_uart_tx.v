`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 12:33:16
// Design Name: 
// Module Name: tb_uart_tx
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


module tb_uart_tx();

reg clk,rst;
reg [6:0]data_in_uart;
reg load; 
wire [9:0]data_out_uart;
wire done_out;

uart_tx dut(clk,rst,data_in_uart,load,data_out_uart,done_out);

initial 
    begin
        {clk,rst,load,data_in_uart}=0;
    end

always #5 clk=~clk;

initial

begin
@(negedge clk)
    rst=1;
@(negedge clk)
    rst=0;
@(negedge clk)
    load=1;
@(negedge clk)
    data_in_uart=7'b0001111;
@(negedge clk)
    load=0;
end      


endmodule
