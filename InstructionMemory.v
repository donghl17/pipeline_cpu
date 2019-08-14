
//module InstructionMemory(Address, Instruction);
//	input [31:0] Address;
//	output reg [31:0] Instruction;
	
//	always @(*)
//		case (Address[9:2])
//			// addi $a0, $zero, 12345 #(0x3039)
//			8'd0:    Instruction <= {6'h08, 5'd0 , 5'd4 , 16'h3039};
//			// addiu $a1, $zero, -11215 #(0xd431)
//			8'd1:    Instruction <= {6'h09, 5'd0 , 5'd5 , 16'hd431};
//			// sll $a2, $a1, 16
//			8'd2:    Instruction <= {6'h00, 5'd0 , 5'd5 , 5'd6 , 5'd16 , 6'h00};
//			// sra $a3, $a2, 16
//			8'd3:    Instruction <= {6'h00, 5'd0 , 5'd6 , 5'd7 , 5'd16 , 6'h03};
//			// beq $a3, $a1, L1
//			8'd4:    Instruction <= {6'h04, 5'd7 , 5'd5 , 16'h0001};
//			// lui $a0, -11111 #(0xd499)
//			8'd5:    Instruction <= {6'h0f, 5'd0 , 5'd4 , 16'hd499};
//			// L1:
//			// add $t0, $a2, $a0
//			8'd6:    Instruction <= {6'h00, 5'd6 , 5'd4 , 5'd8 , 5'd0 , 6'h20};
//			// sra $t1, $t0, 8
//			8'd7:    Instruction <= {6'h00, 5'd0 , 5'd8 , 5'd9 , 5'd8 , 6'h03};
//			// addi $t2, $zero, -12345 #(0xcfc7)
//			8'd8:    Instruction <= {6'h08, 5'd0 , 5'd10, 16'hcfc7};
//			// slt $v0, $a0, $t2
//			8'd9:    Instruction <= {6'h00, 5'd4 , 5'd10 , 5'd2 , 5'd0 , 6'h2a};
//			// sltu $v1, $a0, $t2
//			8'd10:   Instruction <= {6'h00, 5'd4 , 5'd10 , 5'd3 , 5'd0 , 6'h2b};
//			// Loop:
//			// j Loop
//			8'd11:   Instruction <= {6'h02, 26'd11};
			
//			default: Instruction <= 32'h00000000;
//		endcase
		
//endmodule

module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)
		case (Address[9:2])
		    8'd0:    Instruction <= 32'h08000003;
			8'd1:    Instruction <=32'h08000037;
			8'd2:    Instruction <= 32'h08000040;
			8'd3:    Instruction <= 32'h20130064;
			8'd4:    Instruction <= 32'h00009020;
			8'd5:    Instruction <= 32'h00008020;
			8'd6:    Instruction <=32'h0213402a;
			8'd7:    Instruction <= 32'h11000023;
			8'd8:    Instruction <= 32'h2211ffff;
			8'd9:    Instruction <= 32'h2a280000;
			8'd10:   Instruction <= 32'h11000002;
			8'd11:   Instruction <= 32'h22100001;
			8'd12:   Instruction <= 32'h08000006;
			8'd13:   Instruction <= 32'h00114880;
			8'd14:   Instruction <= 32'h02495020;
			8'd15:   Instruction <= 32'h8d4b0000;
			8'd16:   Instruction <= 32'h8d4c0004;
			8'd17:   Instruction <= 32'h018b402a;
			8'd18:   Instruction <= 32'h1100fff8;
			8'd19:    Instruction <= 32'h00122020;
			8'd20:    Instruction <=32'h00112820;
			8'd21:    Instruction <= 32'h23bdffec;
			8'd22:    Instruction <= 32'hafbf0010;
			8'd23:    Instruction <= 32'hafb3000c;
			8'd24:    Instruction <= 32'hafb20008;
			8'd25:    Instruction <=32'hafb10004;
			8'd26:    Instruction <= 32'hafb00000;
			8'd27:    Instruction <= 32'h0c000024;
			8'd28:    Instruction <= 32'h8fb00000;
			8'd29:   Instruction <= 32'h8fb10004;
			8'd30:   Instruction <= 32'h8fb20008;
			8'd31:   Instruction <= 32'h8fb3000c;
			8'd32:   Instruction <= 32'h8fbf0010;
			8'd33:   Instruction <= 32'h23bd0014;
			8'd34:   Instruction <= 32'h2231ffff;
			8'd35:   Instruction <= 32'h08000009;
			8'd36:   Instruction <= 32'h00054880;
			8'd37:    Instruction <= 32'h00894820;
			8'd38:    Instruction <=32'h8d280000;
			8'd39:    Instruction <= 32'h8d2a0004;
			8'd40:    Instruction <= 32'had2a0000;
			8'd41:    Instruction <= 32'had280004;
			8'd42:    Instruction <= 32'h03e00008;
			8'd43:    Instruction <=32'h200b4000;
			8'd44:    Instruction <= 32'h000b5c00;
			8'd45:    Instruction <= 32'h216b0008;
			8'd46:    Instruction <= 32'h200c0001;
			8'd47:   Instruction <= 32'h00006820;
			8'd48:   Instruction <= 32'h200e0100;
			8'd49:   Instruction <= 32'h200f0400;
			8'd50:   Instruction <= 32'h20194000;
			8'd51:   Instruction <= 32'h0019cc00;
			8'd52:   Instruction <= 32'h23390010;
			8'd53:   Instruction <= 32'had6c0000;
			8'd54:   Instruction <= 32'h1000fffe;
			8'd55:    Instruction <= 32'h11cf0005;
			8'd56:    Instruction <=32'h8db80000;
			8'd57:    Instruction <= 32'h030ec020;
			8'd58:    Instruction <= 32'haf380000;
			8'd59:    Instruction <= 32'h000e7040;
			8'd60:    Instruction <= 32'h08000035;
			8'd61:    Instruction <=32'h21ad0004;
			8'd62:    Instruction <= 32'h200e0100;
			8'd63:    Instruction <= 32'h08000037;
			8'd64:    Instruction <= 32'h1000ffea;
//			8'd65:   Instruction <= 32'h200e0100;
//			8'd66:   Instruction <= 32'h0800003a;
//			8'd67:   Instruction <= 32'h1000ffea;
//			8'd67:   Instruction <= 32'h8fa40000;
//			8'd68:   Instruction <= 32'h8fbf0004;
//			8'd69:   Instruction <= 32'h23bd0008;
//			8'd70:   Instruction <= 32'h00821020;
//			8'd17:   Instruction <= 32'h03e00008;
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
