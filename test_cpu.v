
module test_cpu();
	
	reg reset;
	reg sysclk;
	//reg [1:0]testmode;
//	reg clk;
//	reg ledclk;
	CPU cpu1(reset, sysclk);
	
	initial begin
		reset = 1;
		sysclk = 1;
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
