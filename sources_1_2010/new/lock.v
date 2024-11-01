`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 11:27:32 AM
// Design Name: 
// Module Name: lock
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

module h_lock(
    input clk,
    input enb_lock, 
    input dis_lock,
    output reg enb_cnt
);

//simulation 
initial
begin
enb_cnt = 0;
end
//endsimulation

reg un_lock = 1'b1;

always @(posedge clk)
begin
    if (dis_lock == 0 && enb_lock == 1)
        un_lock <= 1'b0;
    else
        un_lock <= 1'b1;
end

always @(negedge un_lock)
begin
    enb_cnt <= ~enb_cnt;  
end
endmodule

