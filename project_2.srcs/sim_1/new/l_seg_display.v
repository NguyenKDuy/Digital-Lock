`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2024 12:07:24 AM
// Design Name: 
// Module Name: l_seg_display
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


module l_seg_display(
input clk_in, confirm, reset, enb_count,
input [3:0] value_4bit,
input [15:0] led_cnt16,
output clk_1hz,
output reg [2:0] count = 3'd0,
output reg [15:0] pw_16bit,
output reg [15:0] led7_out
);
    

    reg [3:0] reg0 = 4'b1111;
    reg [3:0] reg1 = 4'b1111;
    reg [3:0] reg2 = 4'b1111;
    reg [3:0] reg3 = 4'b1111;

   //nháy reg3 ngoài cùng 
    clk_divider #(.DIV(28'd62500000)) clk_out(clk_in, clk_1hz); //DIV 1
    reg [2:0] counter_toggle = 2'd0;   
    always@(posedge clk_1hz)
    begin
    if (counter_toggle == 2'd0) 
    begin
        led7_out <= {reg0, reg1, reg2, 4'b1111};
        counter_toggle <= 2'd1;
    end else begin
        led7_out <= {reg0, reg1, reg2, reg3};
        counter_toggle <= 2'd0;
    end  
    end

    //khi nhận tín hiệu reset
    always@(posedge reset) begin
    count <= 3'd5;
    reg0 <= 4'b1111; 
            reg1 <= 4'b1111;
            reg2 <= 4'b1111;
            reg3 <= 4'b1111; 
            pw_16bit <= 16'b0; 
            count <= 3'd0;
    end 

    //d?ch trái các thanh ghi
    always@(negedge confirm) begin
    case(count)
    3'd0: begin
        reg3 <= value_4bit;
        reg2 <= 4'b1111;
        reg1 <= 4'b1111;
        reg0 <= 4'b1111;
        led7_out <= {reg0, reg1, reg2, reg3};
        count <= 3'd1;
    end
    
    3'd1: begin
        reg3 <= value_4bit;
        reg2 <= reg3;
        reg1 <= 4'b1111;
        reg0 <= 4'b1111;
        led7_out <= {reg0, reg1, reg2, reg3};
        count <= 3'd2;
    end
    
    3'd2: begin
        reg1 <= reg2;
        reg2 <= reg3;
        reg3 <= value_4bit;  
        reg0 <= 4'b1111;
        led7_out <= {reg0, reg1, reg2, reg3};
        count <= 3'd3;
    end
    
    3'd3: begin
        reg0 <= reg1;
        reg1 <= reg2;
        reg2 <= reg3;
        reg3 <= value_4bit;
        led7_out <= {reg0, reg1, reg2, reg3};
        count <= 3'd0;
    end
    
    default:
    begin
            reg0 <= 4'b1111; 
            reg1 <= 4'b1111;
            reg2 <= 4'b1111;
            reg3 <= 4'b1111; 
            pw_16bit <= 16'b0; 
            count <= 3'd0; 
    end
    endcase
    end
    
    //sau 4 lần confirm -> pw_16bit nhận giá trị 
    always@(posedge clk_1hz) begin
    if (reg0 != 4'b1111 && reg1 != 4'b1111 && reg2 != 4'b1111 && reg3 != 4'b1111) begin
        pw_16bit <= {reg0, reg1, reg2, reg3};
    end
    end
    
    //khi nhận tín hiệu enb_count
    always@(posedge enb_count) begin
    led7_out <= led_cnt16;
    end
      
endmodule
