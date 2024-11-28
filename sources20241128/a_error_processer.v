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

    always @(posedge gen_rst, posedge rst_out, posedge rst_in) begin
        if (rst_in) begin 
            gen_stop <= 1'd0;
            error_counter <= 'd0;
        end
        else begin 
            if (rst_out == 1'b1) begin
                gen_stop <= 1'd0;
            end
            else begin
                error_counter <= (error_counter + 1'b1 > 'd7)? 'd7 : (error_counter + 1'b1);
                gen_stop <= 1'd1;
            end
        end
    end
    
endmodule