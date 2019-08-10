
module DataMemory(reset, clk, Address, Write_data, Read_data, MemRead, MemWrite);
	input reset, clk;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	output [31:0] Read_data;
	
	parameter RAM_SIZE = 256;
	parameter RAM_SIZE_BIT = 8;
	parameter N=100;
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	assign Read_data = MemRead? RAM_data[Address[RAM_SIZE_BIT + 1:2]]: 32'h00000000;
	
	integer i;
//	wire [31:0] _N;
//	assign _N=32'd100;
//	wire [31:0] _i;
//	assign _i=i;
	always @(posedge reset or posedge clk)
		if (reset)
			for (i = 0; i < RAM_SIZE; i = i + 1)
			begin
			if(i<N)begin RAM_data[i] <= N-i;end
			else begin RAM_data[i] <= 32'h00000000;end
			end
		else if (MemWrite)
			RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
			
endmodule
