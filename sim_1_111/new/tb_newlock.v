`timescale 1ns / 1ps

module h_newlock_tb;

    reg enb_set;
    reg exit_button;
    reg exit_button_3s;
    reg [15:0] value_16bit;
    reg confirm_button;
    reg clk_in;
    wire disable_cnt;
    wire [15:0] password;
    wire [3:0] counter1;
    wire [3:0] counter2;
    // Instantiate the h_newlock module
    h_newlock uut (
        .enb_set(enb_set),
        .exit_button(exit_button),
        .exit_button_3s(exit_button_3s),
        .value_16bit(value_16bit),
        .confirm_button(confirm_button),
        .clk_in(clk_in),
        .disable_cnt(disable_cnt),
        .password(password),.three_time_counter(counter1),.button_push_counter(counter2)
    );

    // Clock generation
    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        enb_set = 0;
        exit_button = 0;
        exit_button_3s = 0;
        confirm_button = 0;
        value_16bit = 16'hA5A5;

        // B?t ??u ch? ?? ??t m?t kh?u
        #10 enb_set = 1;

        // B??c 1: Xác nh?n 3 l?n ?? kích ho?t disable_cnt
        repeat(3) begin
            #10 confirm_button = 1;
            #10 confirm_button = 0;
        end

        // Ki?m tra n?u disable_cnt ???c b?t
        #10;
        $display("Step 1: disable_cnt = %b (expect 1)", disable_cnt);

        // B??c 2: Nh?p m?t kh?u b?ng cách nh?n confirm_button 4 l?n
        repeat(2) begin
            #10 confirm_button = 1;
            #10 confirm_button = 0;
        end
        
        #10 exit_button_3s = 1;
        #30 exit_button_3s = 0; // Gi? trong 3 chu k?
        repeat(2) begin
            #10 confirm_button = 1;
            #10 confirm_button = 0;
        end
        // Gi? exit_button_3s ?? l?u m?t kh?u và thoát
        #10 exit_button_3s = 1;
        #30 exit_button_3s = 0; // Gi? trong 3 chu k?

        // Ki?m tra m?t kh?u ?ã ???c l?u và disable_cnt ?ã t?t
        #10;
        $display("Step 2: Password = %h (expect A5A5), disable_cnt = %b (expect 0)", password, disable_cnt);
        #100;
        // B??c 3: Ki?m tra reset khi nh?n exit_button gi?a ch?ng
        value_16bit = 16'h1234;
        repeat(3) begin
            #10 confirm_button = 1;
            #10 confirm_button = 0;
        end
        repeat(2) begin
            #10 confirm_button = 1;
            #10 confirm_button = 0;
        end
        #10 exit_button = 1;
        #30 exit_button = 0; // Gi? trong 3 chu k?
        repeat(7) begin
            #10 confirm_button = 1;
            #10 confirm_button = 0;
        end
        #30;
        #10 exit_button_3s = 1;
        #30 exit_button_3s = 0; // Gi? trong 3 chu k?
        // Ki?m tra tr?ng thái ?ã reset
        #10;
        $display("Step 3: disable_cnt = %b (expect 0), Password = %h (expect unchanged)", disable_cnt, password);

        #10 $finish; // K?t thúc mô ph?ng
    end

endmodule
