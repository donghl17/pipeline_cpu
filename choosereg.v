module choosereg(
input [1:0] testmode,//00,01,10,11分别代表4种频率，分别为3125，6250，50，12500Hz，使用SW1~SW0来控制
output reg[4:0]number//输出待测信号
);
//reg [4:0]number;
always@(*)
begin
case(testmode[1:0])
2'b00:number<=5'd4;//a0
2'b01:number<=5'd2;//v0
2'b10:number<=5'd29;//sp
2'b11:number<=5'd31;//ra
endcase
end

endmodule