`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2024 09:27:18 AM
// Design Name: 
// Module Name: test
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


module test(
input clk_in,
      button_push,
      button_press,
output wire clk_out,
       wire led_push,
       wire led_press 
    );
    clk_divider #(.DIV(28'd1)) clk1(clk_in,clk_out);
    button_push b1(clk_in,button_push,led_push);
    button_press #(.HOLD_TIME(28'd1)) b2(clk_in,button_press,led_press);
    
endmodule
