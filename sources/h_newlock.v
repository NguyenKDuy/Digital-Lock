`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2024 04:56:41 PM
// Design Name: 
// Module Name: h_newlock
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


module h_newlock(
    input enb_set,
          exit_button,
          exit_button_3s,
          [15:0] value_16bit,
          confirm_button,
          clk_in,
    output reg disable_cnt,
           reg [15:0] password = 16'd0
    );
    reg[3:0] three_time_counter=4'd0;
    reg[3:0] button_push_counter=4'd0;
      
    always@(negedge confirm_button)
    begin
        if(enb_set == 1'd1) begin
            if(disable_cnt == 1'd1) begin
            button_push_counter <= button_push_counter + 4'd1;
            end
            three_time_counter <= three_time_counter + 4'd1;
            if(three_time_counter >= 4'd2) begin
            disable_cnt <= 1'd1;
            three_time_counter <= 4'd0;
            end   
        end 
    end
    always@(negedge exit_button_3s)
    begin
        if(button_push_counter >= 4'd4) begin
        password <= value_16bit;
        disable_cnt <= 1'd0;
        three_time_counter <= 4'd0;
        button_push_counter <= 4'd0;
    end
    end
    always@(negedge exit_button)
    begin
        if( disable_cnt == 1'd1) begin
        disable_cnt <= 1'd0;
        three_time_counter <= 4'd0;
        button_push_counter <= 4'd0;
        end
    end
endmodule
