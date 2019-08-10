module Newclk(
input sysclk,
output reg clk,
output reg ledclk

);

//reg clk;
//reg ledclk;
reg [31:0] state1;
reg [31:0] state2;
parameter [31:0] divide1=32'd100000000;
parameter [31:0] divide2=32'd100000;
always @(posedge sysclk)
begin
if(state1==0)
clk<=~clk;
state1<=state1+32'd2;
if(state1>=divide1)
state1<=32'd0;
end

always @(posedge sysclk )
begin
if(state2==0)
ledclk<=~ledclk;
state2<=state2+32'd2;
if(state2>=divide2)
state2<=32'd0;
end


endmodule