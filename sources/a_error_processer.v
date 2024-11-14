`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 08:02:03 PM
// Design Name: 
// Module Name: error_processer
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


module a_error_processer(
input gen_rst,
input rst_in,
input rst_out,

output reg gen_stop = 1'd0,
output reg [2:0] error_counter = 'd0
);

    always @(posedge gen_rst) begin
        error_counter <= (error_counter + 1'b1 > 'd7)? 'd7 : (error_counter + 1'b1);
        if (error_counter >= 'd2) begin
            gen_stop <= 1'd1;
        end
        if (rst_in == 1) begin
            error_counter <= 'd0;
            gen_stop <= 1'd0;
        end
    end
    always @(posedge rst_out) begin
        gen_stop <= 1'd0;
    end
endmodule