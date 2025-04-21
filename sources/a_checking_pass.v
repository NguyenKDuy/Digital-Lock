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
    input enough,
    input reset, 
    input clk,
    output reg enb_lock = 1'd0,
    output reg gen_rst = 1'd0
   
);  
    wire d_enb_cmp;
    wire clk_100hz;
    reg [1:0] cnt = 0;
    clk_divider #(.DIV(28'd100)) clk_out_3(clk_in,'d0, clk_100hz);  // tren mạch thật
    
    always @(posedge clk_100hz) begin
        if (reset) begin 
            enb_lock <= 1'd0;
            gen_rst <= 1'd0;
        end
        else begin
            if (enough == 1'b1) begin
                gen_rst <= 1'b1;
                cnt <= cnt + 1'b1;
                if (cnt == 'd3) begin
                    cnt <= 'd0;
                    gen_rst <= 1'b0;
                end
                if(pw_16bit == password)
                    enb_lock <= 1'd1;
                else
                    enb_lock <= 1'd0;
            end
        end     
    end
    
endmodule