`timescale 1ns / 1ps

module tb_h_un_lock;

    // Inputs
    reg clk_in;
    reg enb_lock;
    reg disable_cnt;
    reg button;

    // Output
    wire enb_cnt;

    // Instantiate the module
    h_un_lock uut (
        .clk_in(clk_in),
        .enb_lock(enb_lock),
        .disable_cnt(disable_cnt),
        .button(button),
        .enb_cnt(enb_cnt)
    );

    // Clock generation (125 MHz)
    initial begin
        clk_in = 0;
        forever #4 clk_in = ~clk_in;  // 125 MHz clock (period = 8 ns)
    end

    // Test sequence
    initial begin
        // Initialize signals
        enb_lock = 0;
        disable_cnt = 0;
        button = 0;

        // Wait for global reset
        #20;

        // Test Case 1: Enable lock and press button
        enb_lock = 1;
        #10;
        button = 1; // Press button
        #8;
        button = 0; // Release button
        #20;

        // Test Case 2: Disable opening and press button
        disable_cnt = 1;
        #10;
        button = 1;
        #8;
        button = 0;
        #20;

        // Test Case 3: Enable lock, allow opening, and press button again
        disable_cnt = 0;
        #10;
        button = 1;
        #8;
        button = 0;
        #20;

        // Test Case 4: Toggle multiple times
        repeat (2) begin
            button = 1;
            #8;
            button = 0;
            #20;
        end
        enb_lock =0;
        repeat (2) begin
            button = 1;
            #8;
            button = 0;
            #20;
        end

        // Finish simulation
        #50;
        $finish;
    end

endmodule
