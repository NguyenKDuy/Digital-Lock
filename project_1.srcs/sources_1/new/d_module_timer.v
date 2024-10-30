`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2024 02:57:37 PM
// Design Name: 
// Module Name: d_module_timer
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


module d_module_timer(
    input enb_lock,                         
    input disable_cnt,                      
    input enb_cnt,
    input ignore,
    input gen_stop,
    input clk_in,                          //128Mhz
    output reg enb_set = 1'b0,                         
    output reg enb_inp = 1'b0,                         
    output reg reset = 1'b0,                           
    output reg [9:0] led_cnt,
    output reg [2:0] led_rgb,
    output reg rgb_toggle, //added
    output reg [2:0] state,
    output reg [4:0] co30,
    output reg [4:0] cl10,
    output reg [9:0] wrong_count,
    output reg eval
    );
    //States
    localparam IDLE = 3'b000;
    localparam WAIT = 3'b001;
    localparam OPEN = 3'b010;
    localparam CLOSE = 3'b011;
    localparam NEW = 3'b100;
    localparam EXIT = 3'b101;
    localparam WRONG = 3'b110;
    //LED RGB:
    localparam OFF = 3'b000;
    localparam RED = 3'b001;
    localparam GREEN = 3'b010;
    localparam YELLOW = 3'b011;
    localparam WHITE = 3'b100;
    localparam BLUE = 3'b101;
    
    
    reg evcp = 1'b0; 
    reg evop = 1'b0;
    reg eval = 1'b0; 
    reg exit = 1'b0;
    reg evig = 1'b0;
    //Timer
    reg [4:0] cw10 = 'd10;
    reg [4:0] cl10 = 'd10;
    reg [4:0] co30 = 'd30;
    reg [2:0] pre_state = OPEN;
    reg pulse_count;
    //Wrong case
    reg [2:0] wrong_count = 'd0;
    reg [9:0] wrong_timer = 'd0;
    
    always @(posedge enb_cnt) begin 
        if (enb_lock == 1'b1 && enb_cnt == 1'b1 && disable_cnt == 1'b0 && evop == 1'b0 && evcp == 1'b0) evop <= 1'b1;
    end
    
    always @(posedge disable_cnt) begin 
        if (enb_lock == 1'b1 && enb_cnt == 1'b0 && disable_cnt == 1'b1 && evop == 1'b0 && evcp == 1'b0) evcp <= 1'b1;
    end
    
    always @(negedge disable_cnt) begin
        if (enb_lock == 1'b1 && enb_cnt == 1'b0 && disable_cnt == 1'b0 && evop == 1'b0 && evcp == 1'b1) exit <= 1'b1;
    end  
    
    
    and A1 (clk_stop, gen_stop, !enb_lock); 
    and A2 (clk_corr, enb_lock, !gen_stop);
    
    always @(posedge clk_stop) begin 
        wrong_count <= wrong_count + 1'b1;
        wrong_timer <= (wrong_count*wrong_count + 1)*'d60;
    end

    always @(posedge clk_corr) begin 
        wrong_count <= 'd0;
        wrong_timer <= 'd0;          
    end
    //WRONG Case
    always @(clk_stop) begin 
        if (clk_stop == 1'b1) begin 
            state = WRONG;
            pulse_count = 1'b1; 
        end
        else begin 
            if (enb_lock) begin
                state = WAIT;           //Tuc la cho nay gap loi ve tin hieu, co rui ro
                pulse_count = 1'b1;
            end
            else state = IDLE;
        end
        
    end
    
    always @(posedge clk_in) begin 
        if (pulse_count) pulse_count <= 1'b0;
        if (reset) reset <=1'b0;
    end
    
    always @(clk_corr, evop, evcp, exit, enb_cnt) begin         //Avoid trung cho sai mk
        if (enb_lock == 1'b1) begin 
            if (!evop && !evcp && !exit) begin
                state = WAIT;
                pulse_count = 1'b1;
            end
            else if (!evop && evcp && !exit) begin 
                state = NEW;
            end
            else if (!evop && evcp && exit) begin 
                state = EXIT;
            end    
            else if (evop && !evcp && !exit) begin 
                if (enb_cnt == 1'b0) begin 
                    cl10 = 5'd10;
                    state = CLOSE;
                end
                else begin 
                    state = OPEN;
                end
                pulse_count = 1'b1;
            end
            
            else begin end //cannot happen.         
        end 
    end
    //TODO:
    h_clk_divider #(.DIV(28'd1)) clock_1hz (clk_in, pulse_count, clk_1hz);
    h_clk_divider #(.DIV(28'd1)) clock_1hz_ns (evop & clk_in, 1'b0, clk_1hz_ns); //non_stop
    
    
    always @(posedge clk_1hz_ns) begin 
        if (state == OPEN) begin 
            led_cnt <= co30;
        end
    end
    
    wire clocked_1hz;
    and A0 (clocked_1hz, clk_1hz_ns, !eval & !evig);
    always @(posedge clocked_1hz) begin
        if (co30 == 'd0 && state == OPEN) begin 
            eval <= 1'b1;
//            rgb_toggle <= 1'b0;                               not sure
        end
        else begin 
            co30 <= (co30 == 0) ? co30 : co30 - 1;       
        end
    end
    
    always @(posedge ignore) begin 
        if (co30 == 'd0 && state == OPEN) begin
            evig <= 1'b1;
            eval <= 1'b0;
        end
    end
    
    always @(posedge clk_1hz) begin //khong trung voi clk_1hz bi reset
        case(state)
            IDLE: begin 
                enb_set <= 0;
                enb_inp <= 0;
                led_rgb <= OFF;
                rgb_toggle <= 1'b0;
                evcp <= 1'b0; 
                evop <= 1'b0;
                eval <= 1'b0; 
                exit <= 1'b0;
                evig <= 1'b0;
                //Timer
                cw10 <= 'd10;
                cl10 <= 'd10;
                co30 <= 'd30;
                pre_state = OPEN;
            end
            WAIT: begin 
                enb_set <= 1'b1;
                enb_inp <= 1'b0;
                led_rgb <= GREEN;
                rgb_toggle <= 1'b0;
                //TODO:
                led_cnt <= cw10;
                cw10 <= cw10 - 1'b1;
                if (cw10 == 'd0) begin      
                    reset <= 1'b1;
                    pulse_count <= 1'b1;
                    state <= IDLE;
                end
            end
            OPEN: begin 
                enb_set <= 0;
                enb_inp <= 1;
                led_rgb <= YELLOW;
                rgb_toggle <= 1'b0;
                //TODO:
                if (pre_state == CLOSE && co30 == 'd0) begin 
                    eval <= 1'b1;
                    rgb_toggle <= 1'b0;
                end
                pre_state <= OPEN;
                
            end 
            CLOSE: begin 
                enb_set <= 0;
                enb_inp <= 1;
                led_rgb <= GREEN;
                rgb_toggle <= 1'b1;
                //TODO:
                if (pre_state == OPEN) begin 
                    pre_state <= CLOSE;
                    if (co30 == 'd0) begin 
                        eval <= 1'b0;
                        evig <= 1'b0;
                    end
                end
                else begin end
                led_cnt <= cl10;
                cl10 <= cl10 - 1'b1;
                if (cl10 == 'd0) begin      
                    reset <= 1'b1;
                    pulse_count <= 1'b1;
                    state <= IDLE;
                end
            end
            NEW: begin 
                enb_set <= 1;
                enb_inp <= 0;
                led_rgb <= WHITE;
                rgb_toggle <= 1'b0;
            end
            EXIT: begin 
                reset <= 1'b1;
                pulse_count <= 1'b1;
                state <= IDLE;
            end
            WRONG: begin            //Nho la neu reset cung van chua lai bien dem cua wrong_count
                enb_set <= 0;
                enb_inp <= 1;
                led_rgb <= BLUE;
                rgb_toggle <= 1'b1;
                //TODO:
                led_cnt <= wrong_timer;
                wrong_timer <= wrong_timer - 1'b1;
                if (wrong_timer == 'd0) begin      
                    reset <= 1'b1;
                    pulse_count <= 1'b1;
                    state <= IDLE;
                end
            end
        endcase
    end
    //Handle after open    
    
endmodule


module h_clk_divider(
    input clk_ht, 
    input reset,
    output reg clk_di);
    reg [27:0] counter = 28'd0;
    localparam CLK = 28'd10; //1250000000
    parameter DIV = 28'd1;
    
    always @(posedge clk_ht)
    begin
        counter <= counter + 28'd1;
        if(counter >= CLK/DIV - 1) counter <= 28'd0;
        clk_di <= (counter<CLK/(2*DIV))?1'b1:1'b0; 
    end
    
    always @(posedge reset) begin 
        clk_di <= 1'b0;
        counter <= 28'd0;
end

endmodule
