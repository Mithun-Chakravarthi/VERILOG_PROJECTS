`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 00:08:27
// Design Name: 
// Module Name: Vote_logger
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


module Vote_logger(
input clock,
input mode,
input reset,
input candidate1_vote_valid,
input candidate2_vote_valid,
input candidate3_vote_valid,
input candidate4_vote_valid,
output reg [7:0] candidate1_vote_rcvd,    
output reg [7:0] candidate2_vote_rcvd,    
output reg [7:0] candidate3_vote_rcvd,    
output reg [7:0] candidate4_vote_rcvd);

always@(posedge clock)
begin
    if(reset)
    begin
    candidate1_vote_rcvd<=0;
    candidate2_vote_rcvd<=0;
    candidate3_vote_rcvd<=0;
    candidate4_vote_rcvd<=0;
    end    
    
    else
    begin
    if(candidate1_vote_valid & mode==0)
         candidate1_vote_rcvd<= candidate1_vote_rcvd+1;
         
    else if(candidate2_vote_valid & mode==0)
         candidate2_vote_rcvd<= candidate2_vote_rcvd+1;
         
    else if(candidate3_vote_valid & mode==0)
         candidate3_vote_rcvd<= candidate3_vote_rcvd+1;
         
    else if(candidate4_vote_valid & mode==0)
         candidate4_vote_rcvd<= candidate4_vote_rcvd+1;       
    end
    
end



endmodule
