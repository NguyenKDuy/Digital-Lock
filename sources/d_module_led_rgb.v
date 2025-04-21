`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2024 11:01:09 AM
// Design Name: 
// Module Name: d_module_led_rgb
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


module d_module_led_rgb(
    input rgb_toggle,
    input [2:0] led_rgb,
    input clk_in,
    output reg [2:0] rgb_out = 'd0
    );
        //LED RGB:
    localparam OFF = 3'b000;
    localparam RED = 3'b001;
    localparam GREEN = 3'b010;
    localparam YELLOW = 3'b011;
    localparam WHITE = 3'b111;
    localparam BLUE = 3'b100;
    
    reg pulse_enb = 1'b0;
    wire clk_1hz;
    always @(led_rgb) begin 
        pulse_enb = 1'b1;
    end
    
    always @(posedge clk_in) begin
        if (pulse_enb) pulse_enb <= 1'b0;
    end
    
    clk_divider #(.DIV(28'd1)) clock_1HZ (clk_in, pulse_enb, clk_1hz);
     
    always @(clk_1hz, led_rgb) begin 
        if (rgb_toggle == 1'b1) begin 
            if (clk_1hz) begin
                rgb_out = led_rgb;
            end
            else begin
                rgb_out = OFF;
            end
        end
    end
endmodule
