`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: BUNGATAVALA MITHUN CHAKRAVARTHI
// 
// Create Date: 25.02.2024 20:41:01
// Design Name: 
// Module Name: TLC
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


module TLC(clk,rst,count,ps_state);
    
    input clk,rst;
    output reg [3:0]count=0;
    output reg [1:0]ps_state;
    
    parameter red=2'b00;
    parameter yellow=2'b01;
    parameter green=2'b11;
    
    always@(posedge clk)
    
    begin
    
    if(rst==1)
    begin
    ps_state<=red;
    end
    
    else if(ps_state==red)
        begin
            count<=count+1;
                if(count==5)
                     begin
                        ps_state<=green;
                     end
        end
        
    else if(ps_state==green)
    begin
            count<=count+1;
                if(count==10)
                     begin
                        ps_state<=yellow;
                     end
        end
    
    else if(ps_state==yellow)
        begin
                count<=count+1;
                    if(count==15)
                         begin
                            ps_state<=red;
                         end
            end
            
            end
 
endmodule
