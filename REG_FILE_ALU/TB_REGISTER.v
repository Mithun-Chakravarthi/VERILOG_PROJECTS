`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: BUNGATAVALA MITHUN CHAKRAVARTHI
// 
// Create Date: 22.02.2024 09:58:48
// Design Name: 
// Module Name: TB_REGISTER
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

module TB_REGISTER();
    //inputs given to register file//
   reg [31:0]ip_1;
   reg [3:0] sel_i1,sel_o1,sel_o2;
   reg clk,en,rd,rst,wr;
    
    //inputs given to alu
    
   reg [2:0]opcode;
    
    //output of whole module
   wire  [63:0]result;
   wire flagc,flagz;
   
   ALU_REG DUT_3(ip_1,sel_i1,sel_o1,sel_o2,clk,en,rd,rst,wr,opcode,result,flagc,flagz);
   
    always begin
    #10 clk=~clk;
    end
   
   
   initial begin
   ip_1=32'b0; sel_i1=4'b0; sel_o1=4'b0; sel_o2=4'b0; rd=1'b0; wr=1'b0; rst=1'b1; en=1'b0; clk=1'b0;
 
    
 
   #100; rst=1'b0; en=1'b1;
   
   #20; wr=1'b1; rd=1'b0;ip_1=32'habcdefab;sel_i1=4'h3;
 
   #20; ip_1=32'h12345678; sel_i1=4'h1;
   #20; wr=1'b0; rd=1'b1; sel_o1=4'h1; sel_o2=4'h3;
   
   #10 opcode=3'b000;
   #10 opcode=3'b001;
   #10 opcode=3'b010;
   #10 opcode=3'b011;
   #10 opcode=3'b100;
   #10 opcode=3'b101;
   #10 opcode=3'b110;   
   #10 opcode=3'b111;

     
 
   end
 
   endmodule
