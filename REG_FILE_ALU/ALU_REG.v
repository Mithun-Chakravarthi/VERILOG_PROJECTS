`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: BUNGATAVALA MTIHUN CHALRAVARTHI
// 
// Create Date: 22.02.2024 21:21:03
// Design Name: 
// Module Name: ALU_REG
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// THIS IS THE TOP MODULE WHICH DOE STHE FOLLOWING SPECIFICATIONS
// WHEN THE DATA IS WRITTEN INTO A REGISTER FILE WHICH HAS BEEN CREATED EARLIER.
// THEN THE DATA THAT HAS BEEN READ FROM THE REGISTER IS GIVEN AS INPUT THE ALU AND PERFORMS THE REQUIRED OPERATIONS.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_REG(
ip_1,sel_i1,sel_o1,sel_o2,
clk,en,rd,rst,wr,opcode,result,flagc,flagz);
    
    //inputs given to register file//
    input [31:0]ip_1;
    input [3:0] sel_i1,sel_o1,sel_o2;
    input clk,en,rd,rst,wr;
    
    //inputs given to alu
    
    input [2:0]opcode;
    
    //output of whole module
    output  [63:0]result;
    output flagc,flagz;


    // Now i want to output of reg file to be assigned to some variable.
    
    wire [31:0] reg_op1;
    wire [31:0] reg_op2;
    
    reg_file dut (ip_1,sel_i1,sel_o1,sel_o2,clk,en,rd,rst,wr,reg_op1,reg_op2);
    
    wire [31:0]a,b;
    assign a=reg_op1;
    assign b=reg_op2;
    
    ALU dut2(opcode,a,b,result,flagc,flagz);
    
endmodule
