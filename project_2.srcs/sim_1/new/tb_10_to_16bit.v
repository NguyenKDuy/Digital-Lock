`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2024 12:07:24 AM
// Design Name: 
// Module Name: tb_l_10_to_16bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Testbench for l_10_to_16bit module
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_l_10_to_16bit;
    // Khai báo tín hi?u ?? k?t n?i v?i module c?n ki?m tra
    reg [9:0] led_cnt;          // ??u vào
    wire [3:0] reg0;             // ??u ra - hàng nghìn
    wire [3:0] reg1;             // ??u ra - hàng tr?m
    wire [3:0] reg2;             // ??u ra - hàng ch?c
    wire [3:0] reg3;             // ??u ra - hàng ??n v?
    wire [15:0] led_cnt16;       // ??u ra - s? 16-bit k?t h?p

    // Kh?i t?o module l_10_to_16bit ?? ki?m tra
    l_10_to_16bit uut (
        .led_cnt(led_cnt),
        .reg0(reg0),
        .reg1(reg1),
        .reg2(reg2),
        .reg3(reg3),
        .led_cnt16(led_cnt16)
    );

    // Kh?i ki?m tra
    initial begin
        // Dùng $monitor ?? theo dõi các thay ??i trong các tín hi?u và hi?n th? k?t qu?
        $monitor("led_cnt = %d, reg0 = %d, reg1 = %d, reg2 = %d, reg3 = %d, led_cnt16 = %b", 
                  led_cnt, reg0, reg1, reg2, reg3, led_cnt16);

        // Ki?m tra v?i m?t s? giá tr? c?a led_cnt
        led_cnt = 10'd0;    // Test case 1: led_cnt = 0
        #10;                // ??i 10 ??n v? th?i gian

        led_cnt = 10'd5;    // Test case 2: led_cnt = 5
        #10;

        led_cnt = 10'd45;   // Test case 3: led_cnt = 45
        #10;

        led_cnt = 10'd123;  // Test case 4: led_cnt = 123
        #10;

        led_cnt = 10'd999;  // Test case 5: led_cnt = 999
        #10;

        led_cnt = 10'd1023; // Test case 6: led_cnt = 1023
        #10;

        // K?t thúc mô ph?ng
        $finish;
    end
endmodule

