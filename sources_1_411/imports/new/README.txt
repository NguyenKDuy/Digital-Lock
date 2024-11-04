OVERRIDE CLK DIVIDER:
clk_divider #(.DIV(28'd1)) clk(clk_in,clk_out) // chia tan 1HZ
clk_divider #(.DIV(28'd5)) clk(clk_in,clk_out) // chia tan 5HZ
default: chia tan 1HZ

OVERRIDE BUTTON HOLD:
button_press #(.HOLD_TIME(28'd1)) button(clk_in,button,out) //hold 1s
button_press #(.HOLD_TIME(28'd5)) button(clk_in,button,out) //hold 5s
default: chia tan 5HZ