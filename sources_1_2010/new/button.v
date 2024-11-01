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
    clk_divider #(.DIV(28'd4)) button_clk_4hz(clk_in,clk_out);
    DFF d1(clk_out,button,Q1);
    DFF d2(clk_out,Q1,Q2,Q2_bar);
    assign out = Q1 & Q2_bar;
endmodule

module button_press(
input clk_in,button,
output out
    );
    wire clk_out;
    wire Q1,Q2;
    clk_divider #(.DIV(4)) button_clk_4hz(clk_in,clk_out);
    DFF d1(clk_out,button,Q1);
    DFF d2(clk_out,Q1,Q2);
    assign out = Q1 & Q2;
endmodule

module button_press_3s(
input clk_in,button,
output reg out,
output reg [3:0] count);

wire button_out,clk_out;
reg [3:0] counter=4'd0;

button_press b1(.clk_in(clk_in),.button(button),.out(button_out));
clk_divider #(.DIV(4)) button_clk_4hz(clk_in,clk_out);

always@(posedge clk_out)
    begin
      if(button_out == 1'd1) begin 
            if(count < 14) begin
             count <= count + 1; 
            end
            else begin
            out<= 1'd1;
            end
        end
        else begin
        count <= 4'd0;
        out<=1'd0;
        end
    end
endmodule
