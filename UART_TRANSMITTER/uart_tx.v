`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2024 16:56:08
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
input clk,rst,
input [6:0]data_in_uart,
input load,output [9:0]data_out_uart,
output done_out);

    
    reg start_bit;
    reg stop_bit;
    reg parity;
    reg [6:0]payload;
    reg [9:0]data_out_uart_temp;
    
    reg [1:0]present_state,next_state;
    parameter idle=2'b00;
    parameter s1=2'b01;
    parameter s2=2'b10;
    parameter s3=2'b11;
    
    always@(posedge clk)
    begin
          if(rst)
            present_state<=idle;
          else
            present_state<=next_state;
     end
     
     always@(*)
     begin
             case(present_state)
                idle: 
                        begin
                        data_out_uart_temp=0;
                        start_bit=1;
                        stop_bit=0;
                        payload=0;
                        parity=1'bx;
                        
                        if(load)
                            next_state=s1;
                        else
                            next_state=idle;
                            
                        end
                   //////////////////////////////////////     
                   s1: begin
                        payload=data_in_uart;
                        start_bit=0; 
                        stop_bit=1;
                        parity=^data_in_uart;
                        
                        if(!load)
                            next_state=s2;
                        else
                          next_state=s1;
                           
                        end
                  ////////////////////////////////////////
                  s2: begin
                        data_out_uart_temp={start_bit,payload,parity,stop_bit};
                      end
                      
                  //////////////////////////////////////
                  default: begin
                  data_out_uart_temp=0;
                  end          
                              
           endcase
     
     end
     
     assign data_out_uart=data_out_uart_temp;
     
     
              
endmodule
