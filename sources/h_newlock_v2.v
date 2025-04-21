`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 10:24:02 AM
// Design Name: 
// Module Name: h_newlock_v2
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


module h_newlock_v2(
        input 	enb_set,
          		exit_button,
          		[15:0] value_16bit,
          		confirm_button,
         		 clk_in,
    output 	reg disable_cnt = 'd0,
            reg [15:0] password = 16'd0
    );

           reg[3:0] three_time_counter=4'd0;
           reg[3:0] button_push_counter=4'd0;
           wire button_push_confirm, button_push_exit, button_push_3s_exit;
           button_push B0(clk_in, confirm_button,button_push_confirm);
           button_push B1(clk_in, exit_button,button_push_exit);
           button_press B2(clk_in, exit_button,button_push_3s_exit);

    always@(negedge button_push_confirm)
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
    always@(negedge button_push_3s_exit)
    begin
        if(button_push_counter >= 4'd4) begin
            password <= value_16bit;
            disable_cnt <= 1'd0;
            three_time_counter <= 4'd0;
            button_push_counter <= 4'd0;
        end
    end
    always@(negedge button_push_exit)
    begin
        if( disable_cnt == 1'd1) begin
        disable_cnt = 1'd0;
        three_time_counter <= 4'd0;
        button_push_counter <= 4'd0;
        end
    end
endmodule


