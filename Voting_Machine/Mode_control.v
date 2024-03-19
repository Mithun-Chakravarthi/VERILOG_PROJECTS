`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 01:43:20
// Design Name: 
// Module Name: Mode_control
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


module Mode_control(
input clock,
input reset,
input mode,
input valid_vote_casted,
input [7:0] candidate1_vote,
input [7:0] candidate2_vote,
input [7:0] candidate3_vote,
input [7:0] candidate4_vote,
input cadidate1_button_press,
input cadidate2_button_press,
input cadidate3_button_press,
input cadidate4_button_press,
output reg[7:0]leds
);


reg [30:0] counter;

always@(posedge clock)
begin
    if(reset)
        counter<=0;// whenever reset is pressed, counter started from 0
    else if(valid_vote_casted) //if valid vote is casted counter becomes 1
        counter<=counter+1;
    else if(counter!=0 & counter<100000000)//if counter is not 0 increment it
        counter<=counter+1;
        else //once counter becomes 100000000, reset it to 0
        counter<=0;
end
////////////////////////////////////////////////////
always@(posedge clock)
begin
    if(reset)
            leds<=0;
    else
    begin
        if(mode===0 & counter >0) //mode0 voting,mode1 ==result mode
            leds<=8'hFF;
         else if(mode==0)
            leds<=8'h00;
         else if(mode==1) //result mode
         begin
            if(cadidate1_button_press)
                leds<=candidate1_vote;
            else if(cadidate2_button_press)
                leds<=candidate2_vote;
            else if(cadidate3_button_press)
                leds<=candidate3_vote;
            else if(cadidate4_button_press)
                leds<=candidate4_vote;
         
         end        
    end
end

endmodule
