`timescale 1ns/1ps

module tb_main();

    reg clk_in;      // Clock input (125 MHz)
    reg button;      // Button input
    wire led;        // Output LED

    // Instantiate the main module
    main uut (
        .clk(clk_in),
        .button(button),
        .led(led)
    );

    // Generate 125 MHz clock signal
    always begin
        #4 clk_in = ~clk_in;  // 8 ns period => 125 MHz clock
    end

    initial begin
        // Initialize inputs
        clk_in = 0;
        button = 0;

        // Wait for some time to start the simulation
        #100;

        // Monitor signals
        $monitor("Time: %t | button: %b | LED: %b", $time, button, led);

        // Simulate button press
        button = 1;
        #500000000; // Hold button for 1 us
        button = 0;

        // Wait to observe the LED change
        #500000000; // Wait 500 ms to see if LED toggles

        // Simulate another button press
        button = 1;
        #1000; // Hold button for 1 us
        button = 0;

        // Wait again to observe LED change
        #500000;

        // End simulation
        $stop;
    end

    // Monitor the button_out and clk_out from button_push
    initial begin
        $monitor("Time: %t | button_out: %b | LED: %b", $time, uut.button_out, led);
    end
endmodule