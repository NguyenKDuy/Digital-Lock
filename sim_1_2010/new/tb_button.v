`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2024 05:59:37 PM
// Design Name: 
// Module Name: tb_button
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

module tb_button_press_3s;

    // Inputs
    reg clk_in;
    reg button;

    // Outputs
    wire out;
    wire [3:0] count;
    // Instantiate the module under test (MUT)
    button_press_3s uut (
        .clk_in(clk_in),
        .button(button),
        .out(out),
        .count(count)
    );

    // Clock generation (simulate a clock, assume clk_in is 50MHz)
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in; // 50MHz clock (period = 20ns)
    end

    // Testbench logic
    initial begin
        // Initialize inputs
        button = 0;

        // Wait for 100ns to stabilize
        #100;

        // Press button and hold for 3 seconds (12 cycles of the 4Hz clock)
        button = 1;
        #3000000; // 3 seconds in simulation time (assuming 1ns time units)

        // Release the button after 3 seconds
        button = 0;
        #1000000; // Wait for another 1 second

        // Press again to verify the behavior
        button = 1;
        #3000000; // Hold button for another 3 seconds
        button = 0;
        #1000000; // Wait for 1 second

        // End the simulation
        $stop;
    end

    // Monitor output
    initial begin
        $monitor("Time = %0t | button = %b | out = %b | counter = %d", $time, button, out, uut.counter);
    end

endmodule

