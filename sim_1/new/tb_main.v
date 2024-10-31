`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2024 09:17:22 AM
// Design Name: 
// Module Name: tb_main
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


module tb_main; // Testbench for main

    reg [15:0] pw_16bit;
    reg [15:0] password;
    reg enb_cmp;
    reg reset;
    reg rst_out;

    wire enb_lock;
    wire gen_stop;
    
    main uut (
        .pw_16bit(pw_16bit),
        .password(password),
        .enb_cmp(enb_cmp),
        .reset(reset),
        .rst_out(rst_out),
        .enb_lock(enb_lock),
        .gen_stop(gen_stop)
    );

    initial begin

        // Initialize signals
        pw_16bit = 16'h1234; // User input password
        password = 16'h0000; // Default password
        enb_cmp = 0;
        reset = 0;
        rst_out = 0;

        // Reset system
        #10 reset = 1; 
        #10 reset = 0; 
        #20;
//1
        // Assume incorrect input password
        #10 pw_16bit = 16'h1234; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end
//2
        // Assume incorrect input password
        #10 pw_16bit = 16'h1234; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end
//3
        // Assume incorrect input password
        #10 pw_16bit = 16'h1234; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end
        
        // Assum rst_out enable
        #10 rst_out = 1; 
        #10 rst_out = 0; 
        
//4
        // Assume incorrect input password
        #10 pw_16bit = 16'h0000; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end

//5
        // Assume incorrect input password
        #10 pw_16bit = 16'h1234; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end

//6
        // Assume incorrect input password
        #10 pw_16bit = 16'h1234; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end

//7
        // Assume incorrect input password
        #10 pw_16bit = 16'h1234; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end
        
//8
        // Assume incorrect input password
        #10 pw_16bit = 16'h0000; 
        repeat (4) begin
            #10 enb_cmp = 1; 
            #10 enb_cmp = 0;
        end        
        // Reset system
        #10 reset = 1; 
        #10 reset = 0; 
        #20;
        
        #100 $finish;   
    end
    initial begin
        $monitor("Time: %0d | pw_16bit: %h | password: %h | enb_cmp: %b | reset: %b | rst_out: %b | enb_lock: %b | gen_stop: %b | gen_rst: %b",
                 $time, pw_16bit, password, enb_cmp, reset, rst_out, enb_lock, gen_stop, uut.gen_rst);        
    end
endmodule

