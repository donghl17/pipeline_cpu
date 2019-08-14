
module Peripheral(reset, clk, Address, Write_data, MemRead, MemWrite,digi,ILLOP);
	input reset, clk;
	input [31:0] Address, Write_data;
	input MemRead, MemWrite;
	//output reg [31:0] Read_data;
	output reg [11:0] digi;
	output  reg ILLOP;
	reg [31:0] TH,TL;
    //reg [1:0] TCON;//【1】表示中断【0】表示计时器开始
    //assign ILLOP=TCON[1];
    
    always@(posedge reset or posedge clk) begin
	if(reset) begin
		TH <= 32'hff8e795f;//fffe795f;
		TL <= 32'hff8e795f;//fffe795f;
		ILLOP <= 1'b0;
		//ILLOP
	end
	else if (MemWrite && Write_data[0] && Address[3:0]==4'b1000 )begin
	   //往计数器里写且是01
		if(TL==32'hffffffff) begin
				TL <= TH;
				ILLOP<= 1'b1;		//irq is enabled   
				//TCON[0]<= 1'b0;	            
		end
		else TL <= TL + 1;
		end
	else if(MemWrite) begin
			case(Address)
				//32'h40000000: TH <= Write_data;
				//32'h40000004: TL <= Write_data;
				32'h40000008: ILLOP <= Write_data[1];		//TCON变成01
				//32'h4000000C: led <= Write_data[7:0];			
				32'h40000010: digi <=Write_data[11:0];
				//32'h40000018: show_clk=Write_data[0];
				default:ILLOP <=1'b0 ;
			endcase			
		end
	else ILLOP <=1'b0;
	end
//always@(*) begin
//	if(MemRead) begin
//		case(Address)
//			32'h40000000: Read_data <= TH;			
//			32'h40000004: Read_data <= TL;			
//			32'h40000008: Read_data <= {29'b0,TCON};				
//			//32'h4000000C: Read_data <= {24'b0,led};			
//			//32'h40000010: Read_data <= {24'b0,digi};
//			//32'h40000014: Read_data <= {20'b0,systick};
//            //32'h40000018: show_clk <= {24'b0,TX_DATA};
////			32'h4000001C: begin
////							rdata <= {24'b0,RX_DATA1};
////							RX_GET <= 0;
////						  end
////			32'h40000020: rdata <= {30'b0,RX_GET,TX_STATUS};
//			default:begin Read_data <= 32'b0;end
//		endcase
//	end
//	else
//		Read_data <= 32'b0;
//end


	endmodule