`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 04:35:40 PM
// Design Name: 
// Module Name: h_newpass
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


module h_newpass(
input   clk_in,                //clk
        confirm_button,        //button confirm
        enb_set,               //enable set new password
        value_4bit,            //input new password
output reg disable_cnt, 
       reg [15:0] password     //output newpass
    );
    reg [2:0] counter= 3'd0;
    reg [3:0] reg1,reg2,reg3,reg4;
  
    wire confirm_sig_3s,confirm_sig; //signal output if press 3s or just only push
    
    button_press_3s bp3(.clk_in(clk_in), .button(confirm_button), .out(confirm_sig_3s));
    button_push bp1(.clk_in(clk_in), .button(confirm_button), .out(confirm_sig));
    
    always@(clk_in)
    begin
    if( enb_set == 1 && confirm_sig_3s == 1 && counter == 1'd0) begin
        counter <= 1'd1;
        disable_cnt <= 1'd1;
        end
    end
    
    always@(negedge confirm_sig)
    begin    
    case(counter)
    1'd1: begin
        reg1 <= value_4bit;
        reg2 <= 4'b1111;
        reg3 <= 4'b1111;
        reg4 <= 4'b1111;
        l_7seg(reg4,reg3,reg2,reg1, 7_seg_out);
        counter <= 1'd2;
    end
    1'd2: begin
        reg2 <= reg1;
        reg1 <= value_4bit;
        reg3 <= 4'b1111;
        reg4 <= 4'b1111;
        l_7seg(reg4,reg3,reg2,reg1,7_seg_out);
        counter <= 1'd3;
    end
    1'd3:  begin
        reg3 <= reg2;
        reg2 <= reg1;
        reg1 <= value_4bit;
        reg4 <= 4'b1111;
        l_7seg(reg4,reg3,reg2,reg1,7_seg_out);
        counter <= 1'd4;
    end
    1'd4:   begin
        reg4 <= reg3;
        reg3 <= reg2;
        reg2 <= reg1;
        reg1 <= value_4bit;
        l_7seg(reg4,reg3,reg2,reg1,7_seg_out);
        end
    endcase
    end
   
    always@(clk_in)
    begin
    if( counter == 1'd4 && confirm_sig_3s == 1'd1) begin
        disable_cnt <= 1'd0;
        counter <= 1'd0;
        password <= {reg1,reg2,reg3,reg4};
        end
    end 
   
endmodule
