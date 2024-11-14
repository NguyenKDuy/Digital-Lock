`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 12:39:08 PM
// Design Name: 
// Module Name: tb_mergeALL
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


module tb_mergeALL(
    
    );
    reg btn0;
    reg btn1;
    reg [3:0]sw;
    reg clk;
    wire [15:0] led7_out;
    wire [2:0] rgb;
    wire lock_status;
    wire [15:0] value_16bit;
    wire [15:0] pw_16bit;
    wire gen_rst;
    wire [2:0] error_counter;
    wire [9:0] led_cnt;
    wire enb_inp;
    wire [3:0] count;

    mergeALL UUT (btn0, btn1, sw, clk, led7_out, rgb, lock_status
    ,value_16bit, pw_16bit, gen_rst, error_counter, led_cnt, enb_inp, count
    );
    initial begin
        clk <= 0;
        forever #4 clk <= ~clk;
    end
    reg catch;
    always @(posedge gen_rst) begin
        catch <= 1'b1;
    end
    
    initial begin
        btn0 = 0; btn1 = 0; sw= 'd0; 
        //First letter
        #20000 btn0 = 1; btn1 = 0; sw= 'd0; 
        #30000000  btn0 = 0; btn1 = 0; sw= 'd0; 
        //Second letter
        #300000000 btn0 = 1; btn1 = 0; sw= 'd0; 
        #30000000  btn0 = 0; btn1 = 0; sw= 'd0; 
        //Third letter
        #300000000  btn0 = 1; btn1 = 0; sw= 'd0; 
        #30000000  btn0 = 0; btn1 = 0; sw= 'd0; 
        //Fourth letter
        #300000000  btn0 = 1; btn1 = 0; sw= 'd0; 
        #30000000  btn0 = 0; btn1 = 0; sw= 'd0; 
        //Open
//        #30000000  btn0 = 0; btn1 = 0; sw= 'd0; 
//        #3000000  btn0 = 0; btn1 = 1; sw= 'd0; 
//        #30000000  btn0 = 0; btn1 = 0; sw= 'd0; 
//        #3000000  btn0 = 0; btn1 = 1; sw= 'd0; 
//        #30000000  btn0 = 0; btn1 = 0; sw= 'd0; 
    end
endmodule
