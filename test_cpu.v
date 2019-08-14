
module test_cpu();
	
	reg reset;
	reg sysclk;
	wire [6:0] cathodes;
	wire [3:0] AN;
	//reg [6:0]testmode;
	//reg AN;
//	reg ledclk;
	CPU cpu1(reset, sysclk,cathodes,AN);
	
	initial begin
		reset = 1;
		sysclk = 1;
		//cpu1.IF_ID_Instruction=32'b0;
		//cpu1.show_data=12'b0000000000000;
		//testmode=2'b00;
//	    cpu1.newclk.clk=0;
//		cpu1.newclk.ledclk=0;
//		cpu1.newclk.state1=32'b0;
//		cpu1.newclk.state2=32'b0;
//		cpu1.showaddr.cnt=2'b00;
		#100 reset = 0;

	end
	
	always #5 sysclk = ~sysclk;
		
endmodule
