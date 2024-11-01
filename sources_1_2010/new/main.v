`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2024 04:09:58 PM
// Design Name: 
// Module Name: main
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


module main( input clk,input button,output reg led );
    wire button_out;   
    initial begin
    led = 0;
    end  
    button_push bp(
        .clk_in(clk),
        .button(button),
        .out(button_out)
    );
    
    always @(posedge button_out) begin
        if (button_out) begin
            led <= ~led;   
        end
    end
endmodule


