`timescale 1ns / 1ps

module tb_l_seg_display;

// Inputs
reg clk_in;
reg confirm;
reg reset;
reg enb_count;
reg [3:0] value_4bit;
reg [15:0] led_cnt;

// Outputs
wire clk_1hz;
wire [2:0] count;
wire [15:0] pw_16bit;
wire [15:0] led7_out;

// Instantiate the module under test
l_seg_display uut (
    .clk_in(clk_in),
    .confirm(confirm),
    .reset(reset),
    .enb_count(enb_count),
    .value_4bit(value_4bit),
    .led_cnt(led_cnt),
    .clk_1hz(clk_1hz),
    .count(count),
    .pw_16bit(pw_16bit),
    .led7_out(led7_out)
);

// Clock generation
initial begin
    clk_in = 0;
    forever #5 clk_in = ~clk_in;  // 10ns period clock
end

initial begin
// kh?i t?o giá tr? ban ??u
reset = 0;
enb_count = 0;
led_cnt = 16'b0101011001111000;

//test nh?n value_4bit và nh?n confirm
    value_4bit = 4'b0001; #10 
    confirm = 1; #40 
    confirm = 0; #10 
    
    value_4bit = 4'b0010; #40 
    confirm = 1; #40 
    confirm = 0; #10 
    
    value_4bit = 4'b0011; #40 
    confirm = 1; #40 
    confirm = 0; #10
    
    value_4bit = 4'b0100; #40 
    confirm = 1; #40 
    confirm = 0; 

//// test tín hi?u reset
//    reset = 1; #40
//    reset = 0; #40 
    
//// test tín hi?u enb_count
//    enb_count = 1; #40
//    enb_count = 0;

// Test tín hi?u reset
    #50;
    reset = 1; #40
    reset = 0; #40 
    
    // Test tín hi?u enb_count
    #50;
    enb_count = 1; #40
    enb_count = 0;
end

// Giám sát ??u ra
    initial begin
        $monitor("Time: %0t | clk_1hz: %b | count: %b | pw_16bit: %b | led7_out: %b",
                 $time, clk_1hz, count, pw_16bit, led7_out);
    end

endmodule
