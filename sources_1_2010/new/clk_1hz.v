`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 04:33:10 PM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
input clk_ht, output reg clk_di);
reg [27:0] counter=28'd0;
localparam CLK = 28'd125_000_000;
parameter DIV = 28'd1;

always @(posedge clk_ht)
begin
counter <= counter + 28'd1;
if(counter >= CLK/DIV - 1) counter <= 28'd0;
clk_di <= (counter<CLK/(2*DIV))?1'b1:1'b0; 
end

 endmodule

