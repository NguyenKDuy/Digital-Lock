`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2024 10:40:56 AM
// Design Name: 
// Module Name: h_un_lock
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


module h_un_lock(
    input clk_in,
          enb_lock,
          disable_cnt,
          button,
    output reg enb_cnt =1'd0
    );
    
    button_push B1 (clk_in, button, d_button);

    
    always @(negedge d_button) begin
        if (enb_lock && !disable_cnt) begin
            enb_cnt <= ~enb_cnt;  
        end
    end
    
endmodule
