`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2024 09:36:55 PM
// Design Name: 
// Module Name: l_10_to_16bit
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
module l_10_to_16bit(
    input [9:0] led_cnt,  
    output reg [3:0] reg0,   
    output reg [3:0] reg1,   
    output reg [3:0] reg2,   
    output reg [3:0] reg3,
    output reg [15:0] led_cnt16    
);

    integer temp;  
    always @(*) begin
        // Kh?i t?o giá tr? ban ??u c?a các thanh ghi
        reg0 = 4'd0;
        reg1 = 4'd0;
        reg2 = 4'd0;
        reg3 = 4'd0;

        // Gán giá tr? ??u vào vào bi?n t?m ?? chia
        temp = led_cnt;

        // L?y ch? s? hàng nghìn
        if (temp >= 1000) begin
            reg0 = temp / 1000;
            temp = temp % 1000;
        end

        // L?y ch? s? hàng tr?m
        if (temp >= 100) begin
            reg1 = temp / 100;
            temp = temp % 100;
        end

        // L?y ch? s? hàng ch?c
        if (temp >= 10) begin
            reg2 = temp / 10;
            temp = temp % 10;
        end

        // L?y ch? s? hàng ??n v?
        reg3 = temp;    
        
        // Gán giá tr? vào led_cnt16
        led_cnt16 = {reg0, reg1, reg2, reg3};
    end

endmodule
