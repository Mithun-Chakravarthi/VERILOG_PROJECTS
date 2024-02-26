//////////////////////////////////////////////////////////////////////////////////
// Company: NACM
// Engineer: Bungatavala Mithun Chakravarthi
// 
// Create Date: 22.02.2024 09:12:32
// Design Name: 31 bit register file with both read and write operations
// Module Name: reg_file
// Project Name: 1 bit register file with both read and write operations
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

`timescale 1ns / 1ps
module reg_file
(ip_1,sel_i1,sel_o1,sel_o2,
clk,en,rd,rst,wr,
op_1,op_2);
    input [31:0]ip_1;
    input [3:0] sel_i1,sel_o1,sel_o2;
    input clk,en,rd,rst,wr;
    output reg [31:0]op_1;
    output reg [31:0]op_2;
    
    //Creation of 16 32 bit registers//
    reg [31:0]register [0:15];
    
    integer i;
    wire sen;
    
    assign sen= clk||rst;
    
    //device is active only if enable is 1
    
    always@(posedge sen)
    
    begin
    
    if(en==1)
    begin
    
    if(rst==1)
    begin 
    for(i=0;i<16;i=i+1)
    begin
    register[i]=32'h0; 
   end
    op_1=32'hx;
    op_2=32'hx;
    end
    
    else if(rst==0) //if not at reset
    begin
 //BEGINING OF CASE STATEMENT//   
    case({rd,wr})

    //no operation if both wr,rd are 0
    2'b00:begin 
    end
    
    //if write =1 data should be loaded to register
    2'b01: begin
    register[sel_i1]=ip_1; end
    
    //if read=1 data should be read from register files
    2'b10: begin
    op_1 = register[sel_o1];
    op_2 = register[sel_o2];
    end
    
    //if both read and write are 1
    2'b11: begin
    op_1 = register[sel_o1];
    op_2 = register[sel_o2];
    register[sel_i1]=ip_1;
    end
    endcase
//ENDING OF CASE STATEMENT//
    end
    
    else;
    end
    else;
        
    end
endmodule
