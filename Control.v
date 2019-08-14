
module Control(ILLOP,Stall,OpCode, Funct,
	PCSrc, Branch, RegWrite, RegDst, 
	MemRead, MemWrite, MemtoReg, 
	ALUSrc1, ALUSrc2, ExtOp, LuOp, ALUOp);
	input ILLOP;
	input Stall;
	input [5:0] OpCode;
	input [5:0] Funct;
	output [2:0] PCSrc;
	output Branch;
	output RegWrite;
	output [1:0] RegDst;
	output MemRead;
	output MemWrite;
	output [1:0] MemtoReg;
	output ALUSrc1;
	output ALUSrc2;
	output ExtOp;
	output LuOp;
	output [3:0] ALUOp;
	
	// Your code below

	assign PCSrc[2:0] = 
	    //(Stall)?2'b00:
		(OpCode == 6'h02)? 3'b001: 
		(OpCode == 6'h03)? 3'b001: 
		(Funct == 6'h08 && OpCode==6'h0)? 3'b010: 
		(Funct == 6'h09 && OpCode==6'h0)? 3'b010: 
		(OpCode!=6'h02 && OpCode!=6'h03 && OpCode!=6'h04 && OpCode!=6'h08 && OpCode!=6'h09 && OpCode!=6'h0a && OpCode!=6'h0b && OpCode!=6'h0c && OpCode!=6'h0f && OpCode!=6'h23 && OpCode!=6'h2b && OpCode!=6'h00) ? 3'b100:
		(ILLOP==1'b1)?3'b011:
		3'b000;
	assign Branch = 
	//(Stall)?1'b0:
		(OpCode == 6'h04)? 1'b1: 
		1'b0;	
	assign RegWrite = 
	    (Stall)?1'b0:
		(OpCode == 6'h2b)? 1'b0: 
		(OpCode == 6'h04)? 1'b0: 
		(OpCode == 6'h02)? 1'b0: 
		(Funct == 6'h08 && OpCode==6'h0)? 1'b0: 
		1'b1;	
	assign RegDst[1:0] = 
	    (Stall)?2'b00:
	    (OpCode == 6'h03)? 2'b10: 
		(OpCode == 6'h23)? 2'b00: 	
		(OpCode == 6'h0f)? 2'b00: 		
		(OpCode == 6'h08)? 2'b00: 	
		(OpCode == 6'h09)? 2'b00: 	
		(OpCode == 6'h0a)? 2'b00: 		
		(OpCode == 6'h0b)? 2'b00: 	
		(OpCode == 6'h0c)? 2'b00: 		
		2'b01;	
	assign MemRead = 
	    (Stall)?1'b0:
		(OpCode == 6'h23)? 1'b1: 
		1'b0;	
	assign MemWrite = 
	    (Stall)?1'b0:
		(OpCode == 6'h2b)? 1'b1: 
		1'b0;	
	assign MemtoReg[1:0] = 
	    (Stall)?2'b00:
	    (OpCode == 6'h03)? 2'b10: 
		(Funct == 6'h09 && OpCode==6'h0)? 2'b10: 	
		(OpCode == 6'h23)? 2'b01: 			
		2'b00;		
	assign ALUSrc1 = 
	    (Stall)?1'b0:
		(Funct== 6'h0 && OpCode==6'h0)? 1'b1: 
		(Funct== 6'h02 && OpCode==6'h0)? 1'b1: 
		(Funct== 6'h03 && OpCode==6'h0)? 1'b1:  
		1'b0;		
	assign ALUSrc2 = 
	    (Stall)?1'b0:
		(OpCode== 6'h23)? 1'b1: 
		(OpCode== 6'h2b)? 1'b1: 
		(OpCode== 6'h0f)? 1'b1:  
		(OpCode== 6'h08)? 1'b1: 
		(OpCode== 6'h09)? 1'b1: 
		(OpCode== 6'h0a)? 1'b1: 
		(OpCode== 6'h0b)? 1'b1: 
		(OpCode== 6'h0c)? 1'b1: 
		1'b0;		
	assign ExtOp = 
	    //(Stall)?1'b0:
		(OpCode == 6'h0c)? 1'b0: 
		1'b1;			
	assign LuOp = 
	    //(Stall)?1'b0:
		(OpCode == 6'h0f)? 1'b1: 
		1'b0;			
	// Your code above	
	assign ALUOp[2:0] = 
	    (Stall)?3'b000:
		(OpCode == 6'h00)? 3'b010: 
		(OpCode == 6'h04)? 3'b001: 
		(OpCode == 6'h0c)? 3'b100: 
		(OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
		3'b000;		
	assign ALUOp[3] = (Stall)?1'b0:OpCode[0];
	
endmodule