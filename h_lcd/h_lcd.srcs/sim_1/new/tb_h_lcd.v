
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 12:35:44 AM
// Design Name: 
// Module Name: tb_h_lcd
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for h_lcd
//////////////////////////////////////////////////////////////////////////////////

module tb_h_lcd;

    // Inputs
    reg clk_in;

    // Outputs
    wire rs, e;
    wire [7:0] data;

    // Clock divider
    wire clk_1ms;

    // Instantiate the Unit Under Test (UUT)
    h_lcd uut (
        .clk_in(clk_in),
        .rs(rs),
        .e(e),
        .data(data)
    );

    // Clock generation for 125 MHz
    initial begin
        clk_in = 0;
        forever #4 clk_in = ~clk_in; // Period = 8 ns, frequency = 125 MHz
    end

    // Stimulus generation
    initial begin
        // Initialize the clock and other signals
        #5;
        
        // Add stimulus here
        
        // Wait for a few clock cycles
        #10000; // Wait 10 ms (example) for observing the results
        $finish;
    end

endmodule

