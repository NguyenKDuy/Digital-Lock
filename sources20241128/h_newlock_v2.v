`timescale 1ns / 1ps

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
           reg reset = 1'd0;
           reg[3:0] three_time_counter = 4'd0;
           wire button_push_exit, button_push_3s_exit;
           button_push_v2 B0(clk_in, confirm_button, button_push_confirm);
           button_push_v1 B1(clk_in,  exit_button, button_push_exit);
           button_press B2(clk_in, exit_button, button_push_3s_exit);
    
    always @(posedge clk_in) begin
        if (!disable_cnt) begin
             if (button_push_confirm && enb_inp && enb_set) begin
                disable_cnt <= 1'd1;
             end
        end
        else begin
            if (button_push_3s_exit && enough) begin
                password <= value_16bit;
                disable_cnt <= 1'd0;
            end
            else if (!button_push_exit) begin
                disable_cnt <= 1'd0;
            end
        end
    end
      
endmodule





