`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: l_seg_display
//////////////////////////////////////////////////////////////////////////////////

module l_seg_display(
    input clk_in, confirm, reset, enb_count,
    input [15:0] led_cnt16,
    input [3:0] value_4bit,
    output reg [15:0] led7_out = 16'hFFFF, 
    output reg [15:0] pw_16bit,
    output reg enough = 1'b0
    ,output reg [3:0] count = 4'd0 // ð? ch?y mô ph?ng
);
    reg [3:0] count = 4'd0;
    reg [27:0] blink_counter = 28'd0;
    reg [3:0] reg0 = 4'b1111;
    reg [3:0] reg1 = 4'b1111;
    reg [3:0] reg2 = 4'b1111;
    reg [3:0] reg3 = 4'b1111;
    reg toggle_display = 1'b0;

    //clock
    wire clk_100hz, button;
    button_push bt(clk_in, confirm, button);
    clk_divider_v1 #(.DIV(28'd100)) clk_out2(clk_in, clk_100hz);  // tren m?ch th?t
//    clk_divider #(.DIV(28'd31250000)) clk_out2(clk_in, clk_100hz); // ð? ch?y mô ph?ng

    // Register control and blink toggling
    always @(posedge clk_100hz ) begin
    //tín hi?u enb_count hi?n th? ð?m ngý?c
            if (enb_count) begin
            led7_out <= led_cnt16;
            end else begin
            blink_counter <= blink_counter + 1;
            if (blink_counter == 28'd50) begin 
                toggle_display <= ~toggle_display;
                blink_counter <= 28'd0;
            end

            // Toggle display between showing reg3 and hiding it
            if (toggle_display == 1'b0 && count <= 4'd3)
                led7_out <= {reg0, reg1, reg2, 4'b1111};  
            else
                led7_out <= {reg0, reg1, reg2, reg3}; 
            end
        end
 

    // Register shift control on button
    always @(negedge clk_100hz or posedge reset) begin
        if (reset) begin
            reg3 <= 4'b1111;
            reg2 <= 4'b1111;
            reg1 <= 4'b1111;
            reg0 <= 4'b1111;
            count <= 0;
            enough <= 1'b0;
        end else begin
            reg3 <= value_4bit;

        // Button edge detection
        if (button) begin
            case (count)
                4'd0: begin
                    reg2 <= reg3;
                    reg1 <= 4'b1111;
                    reg0 <= 4'b1111;
                    count <= count + 4'd1;
                end
                4'd1: begin
                    reg2 <= reg3;
                    reg1 <= reg2;
                    reg0 <= 4'b1111;
                    count <= count + 4'd1;
                end
                4'd2: begin
                    reg2 <= reg3;
                    reg1 <= reg2;
                    reg0 <= reg1;
                    count <= count + 4'd1;
                end
                4'd3: begin
                    count <= count + 4'd1;
                    pw_16bit <= {reg0, reg1, reg2, reg3};
                    enough <= 1'b1;
                end
            endcase
        end
    end
end

            
endmodule


module clk_divider_v1(
input clk_ht, output reg clk_di);
reg [27:0] counter=28'd0;
localparam CLK = 28'd125_000_000;
parameter DIV = 28'd1;

always @(posedge clk_ht)
begin
counter <= counter + 28'd1;
if(counter >= CLK/DIV - 1) counter <= 28'd0;
clk_di <= (counter<CLK/(2*DIV))?1'b1:1'b0; 
end
endmodule