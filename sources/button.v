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
    wire Q1,Q2,Q2_bar;
    clk_divider #(.DIV(28'd200)) button_clk_4hz (clk_in,'d0, clk_out); //DIV 4 // timer 20ms
    DFF d1(clk_out,button,Q1);
    DFF d2(clk_out,Q1,Q2,Q2_bar);
    assign out = Q1 & Q2_bar;           //3 times 20ms
endmodule

module button_press(
input clk_in,button,
output reg out
    );
    parameter HOLD_TIME = 28'd3;
    wire clk_out;
    reg [27:0] count=28'd0;
    reg [27:0] count_sig=28'd0;
    reg button_last;
    reg button_stable;
    reg out_active;
    
    clk_divider #(.DIV(28'd50)) clk_10ms(clk_in,'d0,clk_out);
    
    always@(posedge clk_out) begin
        button_last <= button;
        if(button == 1'd1 && button_last == 1'd1) begin
            if(count < HOLD_TIME*28'd50) count<= count + 1'd1;
            else begin
            count<=28'd0;
            count_sig<=28'd0;
            out_active<=1'd0;
            out<=1'd0;
            end
        end  
        if(out_active) begin
                if(count_sig < 28'd25) count_sig = count_sig +1'd1;
                else begin
                out<=1'd0;
                out_active<=1'd0;
                end
        end
        if (count >= HOLD_TIME*28'd50 && out_active==1'd0) begin
            out <= 1'b1; 
            out_active <= 1'b1; 
        end  
    end
    
endmodule
