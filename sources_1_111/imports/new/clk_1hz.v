

module clk_divider(
input clk_ht, output reg clk_di);
reg [27:0] counter=28'd0;
localparam CLK = 28'd125_000_000;
parameter DIV = 28'd1;

always @(posedge clk_ht)
begin
counter <= counter + 28'd1;
if(counter >= CLK/DIV - 1) counter <= 28'd0;
clk_di <= (counter<CLK/(2*DIV))?1'b1:1'b0; 
end
endmodule
