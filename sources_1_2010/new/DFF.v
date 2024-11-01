`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2024 10:15:35 AM
// Design Name: 
// Module Name: DFF
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


module DFF(
input clk,
input D,
output reg Q,
output reg Qbar
    );
    initial 
    begin
    Q = 0;
    Qbar = 1;
    end
always@(posedge clk)
begin
Q<=D;
Qbar<=!Q;    
end
endmodule
