`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 10:19:27 AM
// Design Name: 
// Module Name: tb_d_module_timer
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


module tb_d_module_timer;

    reg enb_lock;                         
    reg disable_cnt;                     
    reg enb_cnt;
    reg ignore;
    reg gen_stop;
    reg clk_in;                          
    wire  enb_set;                         
    wire  enb_inp;                        
    wire  reset;                           
    wire  [9:0] led_cnt;
    wire  [2:0] led_rgb;
    wire  rgb_toggle;
    wire [2:0] state;
    wire [4:0] co30;
    wire [4:0] cl10;
    wire [9:0] wrong_count;
    wire eval;
    d_module_timer DUT (enb_lock, disable_cnt, enb_cnt, ignore, gen_stop, clk_in,
                        enb_set, enb_inp, reset, led_cnt, led_rgb, rgb_toggle, state,  co30, cl10,wrong_count, eval);
                        
    initial begin 
        clk_in = 'd0;
        forever #4 clk_in = ~clk_in;
    end                 
    initial begin
        enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
        #5 enb_lock = 1; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #5 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #5 enb_lock = 1; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #85 enb_lock = 1; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #25 enb_lock = 1; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 1; ignore = 0; gen_stop = 0; 
//        #5 enb_lock = 1; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 1; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 1; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 1; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 1; ignore = 1; gen_stop = 0; 
//        #5 enb_lock = 1; disable_cnt = 0; enb_cnt = 1; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 0; 
//        #500 enb_lock = 1; disable_cnt = 0; enb_cnt = 1; ignore = 0; gen_stop = 0; 
           #5 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 
           #500 enb_lock = 0; disable_cnt = 0; enb_cnt = 0; ignore = 0; gen_stop = 1; 


        #1000 $finish;
    end
    reg grst = 1'b0;
    always @(posedge reset) begin 
        grst <= 1'b1;
    end
endmodule
