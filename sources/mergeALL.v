`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2024 11:21:30 AM
// Design Name: 
// Module Name: mergeALL
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


module mergeALL(
    input btn0,
    input btn1,
    input [3:0]sw,
    input clk,
    output [15:0] led7_out,
    output [2:0] rgb,
    output lock_status
    ,output [15:0] value_16bit
    ,output [15:0] pw_16bit
    ,output gen_rst
    ,output [2:0] error_counter
    ,output [9:0] led_cnt
    ,output enb_inp
    ,output [3:0] count
    );
    wire enb_lock, gen_stop;
    wire [2:0] error_counter;
    wire [15:0] led_cnt16;
    wire [9:0] led_cnt;
    wire reset;
    wire [15:0] np_16bit;
    wire [15:0] value_16bit;
    wire [15:0] pw_16bit;
    wire [15:0] password;
    assign pw_16bit = (enb_lock == 1'b0) ? value_16bit : 'd0;
    assign np_16bit = (enb_lock == 1'b1) ? value_16bit : 'd0;
    l_seg_display L0(.clk_in (clk)
                    ,.confirm(btn0)
                    ,.reset(gen_rst)
                    ,.enb_count(enb_inp)
                    ,.led_cnt16(led_cnt16)
                    ,.value_4bit(sw)
                    ,.led7_out(led7_out)
                    ,.pw_16bit(value_16bit)
                    ,.enough(enough)
                    ,.count(count)
                    );
    
    a_main M1(
                .pw_16bit(pw_16bit)
                ,.password(password)
                ,.enough(enough)
                ,.reset(reset)                  //get from M2
                ,.rst_out(enb_inp)              //get from M2
                ,.clk(clk)
                ,.enb_lock(enb_lock)
                ,.gen_stop(gen_stop)
                ,.error_counter(error_counter)
                ,.gen_rst(gen_rst)
                );
                
    d_main M2 (
                .enb_lock(enb_lock)                         
                ,.disable_cnt(disable_cnt)                      
                ,.enb_cnt(lock_status)
                ,.ignore(enb_cmp)
                ,.gen_stop(gen_stop)
                ,.error_counter(error_counter)
                ,.clk_in(clk)                          
                ,.enb_set(enb_set)                         
                ,.enb_inp(enb_inp)                         
                ,.reset(reset)                           
                ,.led_cnt(led_cnt)
                ,.rgb_out(rgb)
                );    
                
    l_10_to_16bit L1(.led_cnt(led_cnt)
                    ,.led_cnt16(led_cnt16)
                    );   
    h_newlock_v2 H0(.enb_set(enb_set)
                    ,.exit_button(btn1)
                    ,.value_16bit(np_16bit)
                    ,.confirm_button(btn0)
                    ,.clk_in(clk)
                    ,.disable_cnt(disable_cnt)
                    ,.password(password)
                    );
    h_un_lock H1(.clk_in(clk)
                    ,.enb_lock(enb_lock)
                    ,.disable_cnt(disable_cnt)
                    ,.button(btn1_out)
                    ,.enb_cnt(lock_status)
                    );
endmodule
