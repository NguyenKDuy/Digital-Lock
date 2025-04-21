`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 09:02:00 AM
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


module a_main(
    input [15:0] pw_16bit,
    input [15:0] password,
    input enough,
    input reset,
    input rst_out,
    input clk,
    output enb_lock,
    output gen_stop,
    output [2:0] error_counter,
    output gen_rst
    );
    
    
    a_checking_pass cp (
        .pw_16bit(pw_16bit),
        .password(password),
        .enough(enough),
        .reset(reset),
        .clk(clk),
        .enb_lock(enb_lock),
        .gen_rst(gen_rst)
    );
 
    a_error_processer ep (
        .gen_rst(gen_rst), 
        .rst_in(enb_lock),  
        .rst_out(rst_out), 
        .gen_stop(gen_stop),
        .error_counter(error_counter)
    );   
endmodule

