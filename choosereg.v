module choosereg(
input [1:0] testmode,//00,01,10,11�ֱ����4��Ƶ�ʣ��ֱ�Ϊ3125��6250��50��12500Hz��ʹ��SW1~SW0������
output reg[4:0]number//��������ź�
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