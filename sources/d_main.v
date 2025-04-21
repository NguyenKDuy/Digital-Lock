`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2024 08:54:33 PM
// Design Name: 
// Module Name: d_main
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


module d_main(
    input enb_lock,                         
    input disable_cnt,                      
    input enb_cnt,
    input ignore,
    input gen_stop,
    input [2:0] error_counter,
    input clk_in,                          //128Mhz
    output  enb_set,                         
    output  enb_inp,                         
    output  reset,                           
    output  [9:0] led_cnt,
    output  [2:0] rgb_out
    );
    
    wire [2:0] led_rgb;
    wire rgb_toggle;
    d_module_timer D1 (
    .enb_lock(enb_lock)                         
    ,.disable_cnt(disable_cnt)                      
    ,.enb_cnt(enb_cnt)
    ,.ignore(ignore)
    ,.gen_stop(gen_stop)
    ,.error_counter(error_counter)
    ,.clk_in(clk_in)                          //125mhz
    ,.enb_set(enb_set)                         
    ,.enb_inp(enb_inp)                         
    ,.reset(reset)                           
    ,.led_cnt(led_cnt)
    ,.led_rgb(led_rgb)
    ,.rgb_toggle(rgb_toggle));    
    
    d_module_led_rgb D2 (
    .rgb_toggle(rgb_toggle)
    ,.led_rgb(led_rgb)
    ,.clk_in(clk_in)                    //125mhz
    ,.rgb_out(rgb_out));
endmodule
