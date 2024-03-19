`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2024 01:15:01
// Design Name: 
// Module Name: Voting_Machine
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


module Voting_Machine(
input clock,
input reset,
input mode,
input button1,
input button2,
input button3,
input button4,
output [7:0]led);

wire valid_vote_1;
wire valid_vote_2;
wire valid_vote_3;
wire valid_vote_4;
wire [7:0] candidate1_vote_rcvd;
wire [7:0] candidate2_vote_rcvd;
wire [7:0] candidate3_vote_rcvd;
wire [7:0] candidate4_vote_rcvd;
wire anyValidVote;
assign anyValidVote=valid_vote_1|valid_vote_2|valid_vote_3|valid_vote_4;


button_control bc1( .clock(clock),.reset(reset),.button(button1),.valid_vote(valid_vote_1));
button_control bc2( .clock(clock),.reset(reset),.button(button2),.valid_vote(valid_vote_2));
button_control bc3( .clock(clock),.reset(reset),.button(button3),.valid_vote(valid_vote_3));
button_control bc4( .clock(clock),.reset(reset),.button(button4),.valid_vote(valid_vote_4));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
Vote_logger VL(
.clock(clock),
.reset(reset),
.mode(mode),
.candidate1_vote_valid(valid_vote_1),
.candidate2_vote_valid(valid_vote_2),
.candidate3_vote_valid(valid_vote_3),
.candidate4_vote_valid(valid_vote_4),
.candidate1_vote_rcvd(candidate1_vote_rcvd),    
.candidate2_vote_rcvd(candidate2_vote_rcvd),    
.candidate3_vote_rcvd(candidate3_vote_rcvd),    
.candidate4_vote_rcvd(candidate4_vote_rcvd));


///////////////////////////////////////////////////////////////////////////////////////////////////////////////
Mode_control(
.clock(clock),
.reset(reset),
.mode(mode),
.valid_vote_casted(anyValidVote),
.candidate1_vote(candidate1_vote_rcvd),
.candidate2_vote(candidate2_vote_rcvd),
.candidate3_vote(candidate3_vote_rcvd),
.candidate4_vote(candidate4_vote_rcvd),
.cadidate1_button_press(valid_vote_1),
.cadidate2_button_press(valid_vote_2),
.cadidate3_button_press(valid_vote_3),
.cadidate4_button_press(valid_vote_4),
.leds(led)
);



    
endmodule
