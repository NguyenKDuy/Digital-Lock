`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 02:04:43 PM
// Design Name: 
// Module Name: checking_pass
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


module a_checking_pass(
    input [15:0] pw_16bit,
    input [15:0] password,
    input disable_cnt,
    input enough,
    input reset, 
//    input clk,
    output reg enb_lock = 1'd0,
    output reg gen_rst = 1'd0
   
);  
    wire d_enb_cmp;
    wire clk_100hz;   
    always @(enough, reset) begin
        if (reset) begin 
            enb_lock = 1'd0;
            gen_rst = 1'd0;
        end
        else begin
            if (enough & !disable_cnt == 1'b1) begin
                if(pw_16bit == password)
                    enb_lock = 1'd1;
                else
                    enb_lock = 1'd0;
                gen_rst = 1'b1;
            end
            else begin 
                gen_rst = 1'b0;
            end
        end     
    end
    
endmodule