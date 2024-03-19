`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2024 23:58:18
// Design Name: 
// Module Name: button_control
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


module button_control(
input clock,
input reset,
input button,
output reg valid_vote);

reg[31:0] counter; ///to check whther someone has pushed a button for more than a sec

always@(posedge clock)
begin

if(reset)

counter<=0;

else begin
    if(button & counter<100000001)
            counter<=counter+1;
    else if(!button)
        counter<=0;
end
end


always@(posedge clock)
begin
    if(reset)
            valid_vote<=1'b0;
            else
            begin
                if(counter==100000000) 
                    valid_vote<=1'b1;
                else
                    valid_vote<=1'b0;
            end
 end
 
 
endmodule

