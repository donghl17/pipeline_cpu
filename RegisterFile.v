
module RegisterFile( reset, clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2);
	//input [4:0]number;
	input reset, clk;
	input RegWrite;
	input [4:0] Read_register1, Read_register2, Write_register;
	input [31:0] Write_data;
	output [31:0] Read_data1, Read_data2;
	//output reg [15:0] show_data;
	
	reg [31:0] RF_data[31:1];
	
	//always @(negedge clk)
	//begin
	assign Read_data1 = (Read_register1 == 5'b00000)? 32'h00000000: RF_data[Read_register1];
	assign Read_data2 = (Read_register2 == 5'b00000)? 32'h00000000: RF_data[Read_register2];
	//end
//	always @(*)
//	begin
//	   if(number==5'd2)  show_data<=RF_data[2][15:0];
//	   else if(number==5'd4) show_data<=RF_data[4][15:0];
//	   else if(number==5'd29) show_data<=RF_data[29][15:0];
//	   else if(number==5'd31) show_data<=RF_data[31][15:0];
//    end

	integer i;
	always @(posedge reset or negedge clk)
		if (reset)
			for (i = 1; i < 32; i = i + 1)
				RF_data[i] <= 32'h00000000;
		else if (RegWrite && (Write_register != 5'b00000))
			RF_data[Write_register] <= Write_data;

endmodule
			