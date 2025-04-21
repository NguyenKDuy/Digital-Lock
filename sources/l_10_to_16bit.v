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
    output reg [15:0] led_cnt16    
);
    reg [3:0] reg0;
    reg [3:0] reg1;   
    reg [3:0] reg2;   
    reg [3:0] reg3;
    integer temp;  
    always @(*) begin
        // Kh?i t?o giá tr? ban ??u c?a các thanh ghi
        reg0 = 'd0;
        reg1 = 'd0;   
        reg2 = 'd0;   
        reg3 = 'd0;
        // Gán giá tr? ??u vào vào bi?n t?m ?? chia
        temp = led_cnt;             //9

        // L?y ch? s? hàng nghìn
        if (temp >= 1000) begin
            reg0 = temp / 1000;     //0
            temp = temp % 1000;     //9
        end

        // L?y ch? s? hàng tr?m
        if (temp >= 100) begin      
            reg1 = temp / 100;      //0
            temp = temp % 100;      //9
        end

        // L?y ch? s? hàng ch?c
        if (temp >= 10) begin       
            reg2 = temp / 10;       //1
            temp = temp % 10;       //0
        end

        // L?y ch? s? hàng ??n v?
        reg3 = temp;    
        
        // Gán giá tr? vào led_cnt16
        led_cnt16 = {reg0, reg1, reg2, reg3};
    end

endmodule
