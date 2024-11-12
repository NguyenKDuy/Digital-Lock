`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: l_seg_display
//////////////////////////////////////////////////////////////////////////////////

module l_seg_display(
    input clk_in, confirm, reset, enb_count,
    input [15:0] led_cnt16,
    input [3:0] value_4bit,
    output reg [15:0] led7_out = 16'hFFFF, 
    output reg [15:0] pw_16bit
//    ,output reg [3:0] count = 4'd0 // để chạy mô phỏng
);
    reg [3:0] count = 4'd0;
    reg [27:0] blink_counter = 28'd0;
    reg [3:0] reg0 = 4'b1111;
    reg [3:0] reg1 = 4'b1111;
    reg [3:0] reg2 = 4'b1111;
    reg [3:0] reg3 = 4'b1111;
    reg toggle_display = 1'b0;

    //clock
    wire clk_1hz, clk_100hz, button;
    button_push bt(clk_in, confirm, button);
    clk_divider #(.DIV(28'd1)) clk_out(clk_in, clk_1hz);
    clk_divider #(.DIV(28'd100)) clk_out2(clk_in, clk_100hz);  // tren mạch thật
//    clk_divider #(.DIV(28'd31250000)) clk_out2(clk_in, clk_100hz); // để chạy mô phỏng

    // Register control and blink toggling
    always @(posedge clk_100hz ) begin
    //tín hiệu enb_count hiển thị đếm ngược
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
    always @(posedge clk_100hz or posedge reset) begin
        if (reset) begin
            reg3 <= 4'b1111;
            reg2 <= 4'b1111;
            reg1 <= 4'b1111;
            reg0 <= 4'b1111;
            count <= 0;
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
                end
            endcase
        end
    end
end

            
endmodule
