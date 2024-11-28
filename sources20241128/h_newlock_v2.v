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
        input 	enb_inp,
                enb_set,
          		exit_button,
          		enough,
          		[15:0] value_16bit,
          		confirm_button,
         		clk_in,
        output 	reg disable_cnt = 'd0,
                reg [15:0] password = 16'd0
    );

           reg[3:0] three_time_counter=4'd0;
           wire button_push_confirm, button_push_exit, button_push_3s_exit;
           button_push B0(clk_in, enb_inp & confirm_button, button_push_confirm);
           button_push_v1 B1(clk_in,  exit_button,button_push_exit);
           button_press B2(clk_in, exit_button,button_push_3s_exit);
    
    
    always @(posedge button_push_confirm or posedge button_push_3s_exit or negedge button_push_exit)
    begin
        if (button_push_confirm && !disable_cnt && enb_set) begin
             three_time_counter <= three_time_counter + 4'd1;
            if(three_time_counter >= 4'd2) begin
                disable_cnt <= 1'd1;
            end   
        end
        
        else if(disable_cnt == 1'd1) begin
            if(button_push_3s_exit && enough) begin
                password <= value_16bit;
                disable_cnt <= 1'd0;
                three_time_counter <= 4'd0;
            end
    
            else if(!button_push_exit) begin
                disable_cnt <= 1'd0;
                three_time_counter <= 4'd0; 
            end
        end 
    end
  
endmodule





