`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2024 10:10:43 AM
// Design Name: 
// Module Name: button
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

module button_push(
input clk_in,button,
output out
    );
    wire clk_out;
    wire Q1,Q1_bar,Q2,Q2_bar;
    clk_divider #(.DIV(28'd200  )) clk_4hz(clk_in,clk_out);  //trên mạch thật
//    clk_divider #(.DIV(28'd62500000  )) clk_4hz(clk_in,clk_out); //để chạy mô phỏng
    DFF d1(clk_out,button,Q1);
    DFF d2(clk_out,Q1,Q2,Q2_bar);
    assign out = Q1 & Q2_bar;
endmodule

