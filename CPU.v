
module CPU(reset, sysclk,cathodes,AN);//, testmode,,led
	input reset, sysclk;
//	input [1:0]testmode;	
	output [6:0]cathodes;
	output [3:0]AN;
	//output [7:0]led;
	
	//PC��ر���
	reg [31:0] PC;
	wire [31:0] PC_next;
	wire [31:0] PC_plus_4;
	//assign led=PC[7:0];
    // assign clk=sysclk;
    //	wire clk,ledclk;
    //	Newclk newclk(sysclk,clk,ledclk);
    //ָ��洢��
    wire [31:0] Instruction;
    //mux6���
    wire [31:0] mux6_out;
    //IF/ID�Ĵ���
	reg [31:0] IF_ID_PC_plus_4;
	reg [31:0] IF_ID_Instruction;
	//������+stall���Ƶ�mux
	wire [1:0] RegDst;
	wire [2:0] PCSrc;
	wire Branch;
	wire MemRead;
	wire [1:0] MemtoReg;
	wire [3:0] ALUOp;
	wire ExtOp;
	wire LuOp;
	wire MemWrite;
	wire ALUSrc1;
	wire ALUSrc2;
	wire RegWrite;
	//�Ĵ�����+д��Ĵ������Ҫ�Ӻ��洫����
	wire [31:0] Databus1, Databus2;
	wire [31:0] mux7_out;
	
	wire [4:0] Write_register;
	//������չ��Ԫ
	wire [31:0] Ext_out;
	//ѡ�������չor����16λ��mux
	wire [31:0] LU_out;
	//jumpָ����תĿ��
	wire [31:0] Jump_target;
	//ԭͼmux11+���ţ�����Ϊ1ѡbeq������Ϊ0ѡPc+4
	wire [31:0] Branch_target;
	wire and_out;//�������
	wire Compare_out;//1��ȣ�0�����
	wire [31:0] mux4_out;
	wire [31:0] mux3_out;
	//mux2_out
	wire [4:0] mux2_out;
	//hazardunit
    wire stall;
	wire IF_Flush;
	//ID/EX�Ĵ���
	reg [31:0] ID_EX_PC_plus_4;
	reg [4:0] ID_EX_shamt;
	reg [31:0] ID_EX_Databus1;
	reg [31:0] ID_EX_Databus2;
	reg [31:0] ID_EX_LU_out;
	reg [4:0] ID_EX_rt;
	reg [4:0] ID_EX_rd;
	reg [4:0] ID_EX_rs;
	reg [5:0] ID_EX_funct;
	reg [1:0] ID_EX_RegDst;
	reg ID_EX_ALUSrc1;
	reg ID_EX_ALUSrc2;
	reg [3:0]ID_EX_ALUOp;
    reg ID_EX_MemRead;
	reg ID_EX_MemWrite;
	reg [1:0] ID_EX_MemtoReg;
	reg ID_EX_RegWrite;
	//ForwardUnit_for_r_beq
	wire [1:0] mux4_control;
	wire [1:0] mux3_control;
	//ForwardUnit_for_load_use
	wire [1:0] mux1_control;
    wire [1:0] mux5_control;
	//ALUcontrol
	wire [4:0] ALUCtl;
	wire Sign;
	//tmux5&1
	wire [31:0]mux5_out;
	wire [31:0]mux1_out;
	//ALU
	wire [31:0] ALU_in1;
	wire [31:0] ALU_in2;
	wire [31:0] ALU_out;
	wire Zero;
	//EX/MEM�Ĵ���
	reg [31:0] EX_MEM_PC_plus_4;
	reg [31:0] EX_MEM_ALU_out;
	reg [31:0] EX_MEM_mux1_out;
	reg EX_MEM_MemRead;
	reg [4:0] EX_MEM_mux2_out;
	reg EX_MEM_RegWrite;
	reg EX_MEM_MemWrite;
	reg [1:0] EX_MEM_MemtoReg;
	//datamemory
	wire [31:0] Read_data;
	//MEM/WB�Ĵ���
	reg [31:0] MEM_WB_PC_plus_4;
	reg [31:0] MEM_WB_Read_data;
	reg [31:0] MEM_WB_ALU_out;
	reg [4:0] MEM_WB_mux2_out;
	reg MEM_WB_RegWrite;
	reg [1:0]MEM_WB_MemtoReg;
	//�������
	wire ILLOP;
	//initial ILLOP=1'b0;
	//wire show_clk;
	wire [11:0] show_data;
    //reg [1:0]TCON_;
    //assign TCON=TCON_;
//reset�����pc��Ϊpcnext������pipline�е�stall����ָ��		
	always @(posedge reset or posedge sysclk)
		if (reset)
		begin
			PC <= 32'h00000000;
			//TCON_<=2'b00;
			end
		else if(stall)
		    PC<=PC;
		else
			PC <= PC_next;

//	always @(posedge reset)
//	begin
//	   PC <= 32'h00000000;
//	end

	//ѡ��Ҫ��ʾ�ļĴ�����ţ�pipline�в���		
	//wire [4:0]number;
    //choosereg Choosereg(testmode,number);
    
    //PC+4�ӷ���
	assign PC_plus_4 = PC + 32'd4;
	//ָ��洢��
	InstructionMemory instruction_memory1(.Address(PC), .Instruction(Instruction));
	//mux6 flush==1ˢ��flush==0��ˢ
	assign mux6_out = (IF_Flush)? 32'b0:Instruction;
	//IF/ID�Ĵ���
	always @(posedge sysclk)
	begin
	   if(stall)
	   begin
	   IF_ID_PC_plus_4<=IF_ID_PC_plus_4;
	   IF_ID_Instruction<=IF_ID_Instruction;
	   end
	   else begin
	   IF_ID_PC_plus_4<=PC_plus_4;
	   IF_ID_Instruction<=mux6_out;
	   end
	end
	
	
//��������������������������������������������������������������������������������������������������������������������������������������������	
//������+stall���Ƶ�mux
	Control control1(.ILLOP(ILLOP),
		.Stall(stall),.OpCode(IF_ID_Instruction[31:26]), .Funct(IF_ID_Instruction[5:0]),
		.PCSrc(PCSrc), .Branch(Branch), .RegWrite(RegWrite), .RegDst(RegDst), 
		.MemRead(MemRead),	.MemWrite(MemWrite), .MemtoReg(MemtoReg),
		.ALUSrc1(ALUSrc1), .ALUSrc2(ALUSrc2), .ExtOp(ExtOp), .LuOp(LuOp),.ALUOp(ALUOp));
    //wire Branch_out;
    //assign Branch_out=(stall==1)? 0:1;
		
//�Ĵ�����+д��Ĵ������Ҫ�Ӻ��洫����
	assign Write_register = MEM_WB_mux2_out;//(RegDst == 2'b00)? Instruction[20:16]: (RegDst == 2'b01)? Instruction[15:11]: 5'b11111;
	RegisterFile register_file1(.reset(reset), .clk(sysclk), .RegWrite(MEM_WB_RegWrite), 
		.Read_register1(IF_ID_Instruction[25:21]), .Read_register2(IF_ID_Instruction[20:16]), .Write_register(Write_register),
		.Write_data(mux7_out), .Read_data1(Databus1), .Read_data2(Databus2));
	
//������չ��Ԫ
	assign Ext_out = {ExtOp? {16{IF_ID_Instruction[15]}}: 16'h0000, IF_ID_Instruction[15:0]};
//ѡ�������չor����16λ��mux
	assign LU_out = LuOp? {IF_ID_Instruction[15:0], 16'h0000}: Ext_out;
	
//jumpָ����תĿ��
	assign Jump_target = {IF_ID_PC_plus_4[31:28], IF_ID_Instruction[25:0], 2'b00};
	
//ԭͼmux11+���ţ�����Ϊ1ѡbeq������Ϊ0ѡPc+4
	assign mux4_out=(mux4_control==2'b00)? Databus1:
	                (mux4_control==2'b01)? ALU_out:
	                Read_data;
	assign mux3_out=(mux3_control==2'b00)? Databus2:
	                (mux3_control==2'b01)? ALU_out:
	                Read_data;
	Compare compare_module(.Number1(mux4_out),.Number2(mux3_out),.Compare_out(Compare_out));
	assign and_out=Branch & Compare_out;//Zero;
	assign Branch_target = (and_out)? IF_ID_PC_plus_4 + {Ext_out[29:0], 2'b00}: PC_plus_4;
    
    //������һ��PC��ֵ��piplineҪ��һ�������źţ���������������������������������������������
	assign PC_next = (PCSrc == 3'b000)? Branch_target: (PCSrc == 3'b001)? Jump_target:(PCSrc == 3'b011)? 32'h80000004: (PCSrc == 3'b100) ? 32'h80000008 :Databus1;
	
	//forwardunit for r beq
	ForwardUnit_for_R_beq forwardunit1 (.Branch(Branch),
.EX_MEM_Mux2_out(EX_MEM_mux2_out),
.rt(IF_ID_Instruction[20:16]),
.rs(IF_ID_Instruction[25:21]),
.EX_MEM_MemRead(EX_MEM_MemRead),
.mux3_control(mux3_control),
.mux4_control(mux4_control));
//hazardunit
	HazardUnit hazardunit (.reset(reset),.ID_EX_RegWrite(ID_EX_RegWrite),.Branch(Branch),.and_out(and_out), .PCSrc(PCSrc),.ID_EX_MemRead(ID_EX_MemRead), .mux2_out(mux2_out), .rs(IF_ID_Instruction[25:21]),.rt(IF_ID_Instruction[20:16]), .stall(stall), .IF_Flush(IF_Flush));
//ID/EX�Ĵ���	
	always @(posedge sysclk)
	begin
	ID_EX_PC_plus_4<=IF_ID_PC_plus_4;
	ID_EX_shamt<=IF_ID_Instruction[10:6];
	ID_EX_Databus1<=Databus1;
	ID_EX_Databus2<=Databus2;
	ID_EX_LU_out<=LU_out;
	ID_EX_rt<=IF_ID_Instruction[20:16];
	ID_EX_rd<=IF_ID_Instruction[15:11];
	ID_EX_rs<=IF_ID_Instruction[25:21];
	ID_EX_funct<=IF_ID_Instruction[5:0];
	ID_EX_RegDst<=RegDst;
	ID_EX_ALUSrc1<=ALUSrc1;
	ID_EX_ALUSrc2<=ALUSrc2;
	ID_EX_ALUOp<=ALUOp;
	ID_EX_MemRead<=MemRead;
	ID_EX_MemWrite<=MemWrite;
	ID_EX_MemtoReg<=MemtoReg;
	ID_EX_RegWrite<=RegWrite;
	end
	
	
//������������������������������������������������������������������������������������������������������������������������������������������������������������������������	
//ForwardUnit_for_load_use
	ForwardUnit_for_load_use forwardunit2(
.EX_MEM_RegWrite(EX_MEM_RegWrite),
.MEM_WB_RegWrite(MEM_WB_RegWrite),
 .EX_MEM_Mux2_out(EX_MEM_mux2_out),
.MEM_WB_Mux2_out(MEM_WB_mux2_out),
 .ID_EX_rs(ID_EX_rs),
.ID_EX_rt(ID_EX_rt),
.mux1_control(mux1_control),
.mux5_control(mux5_control)
    );
//ALUcontrol
	ALUControl alu_control1(.ALUOp(ID_EX_ALUOp), .Funct(ID_EX_funct), .ALUCtl(ALUCtl), .Sign(Sign));
	
//tmux5&1
	assign mux5_out=(mux5_control==2'b00)? ID_EX_Databus1:
	                 (mux5_control==2'b01)? mux7_out:
	                 EX_MEM_ALU_out;
    assign mux1_out=(mux1_control==2'b00)? ID_EX_Databus2:
	                 (mux1_control==2'b01)? mux7_out:
	                 EX_MEM_ALU_out;
	//tmux2
	assign mux2_out=(ID_EX_RegDst==2'b00)? ID_EX_rt:
	                 (ID_EX_RegDst==2'b01)? ID_EX_rd:
	                5'd31;
//ALU
	assign ALU_in1 = ID_EX_ALUSrc1? {17'h00000, ID_EX_shamt}: mux5_out;
	assign ALU_in2 = ID_EX_ALUSrc2? ID_EX_LU_out: mux1_out;
	ALU alu1(.in1(ALU_in1), .in2(ALU_in2), .ALUCtl(ALUCtl), .Sign(Sign), .out(ALU_out), .zero(Zero));
	
	//EX/MEM�Ĵ���
	always @(posedge sysclk)
	begin
	EX_MEM_PC_plus_4<=ID_EX_PC_plus_4;
	EX_MEM_ALU_out<=ALU_out;
	EX_MEM_mux1_out<=mux1_out;
	EX_MEM_mux2_out<=mux2_out;
	EX_MEM_MemRead<=ID_EX_MemRead;
	EX_MEM_MemWrite<=ID_EX_MemWrite;
	EX_MEM_MemtoReg<=ID_EX_MemtoReg;
	EX_MEM_RegWrite<=ID_EX_RegWrite;
	end
	
//������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������	
	//datamemory ����һλΪ0ʱ�Ž�datamemeroy
	DataMemory data_memory1(.reset(reset), .clk(sysclk), .Address(EX_MEM_ALU_out), .Write_data(EX_MEM_mux1_out),
	 .Read_data(Read_data), .MemRead(EX_MEM_MemRead & (EX_MEM_ALU_out[30:29]!=2'b10)),
	  .MemWrite(EX_MEM_MemWrite & (EX_MEM_ALU_out[30:29]!=2'b10)));
	//���裬������һλΪ1ʱ�Ž�datamemeroy
	Peripheral peripheral1(.reset(reset), .clk(sysclk), .Address(EX_MEM_ALU_out), .Write_data(EX_MEM_mux1_out),
	 .MemRead(EX_MEM_MemRead & (EX_MEM_ALU_out[30:29]==2'b10)), .MemWrite(EX_MEM_MemWrite & (EX_MEM_ALU_out[30:29]==2'b10)),
	 .digi(show_data),.ILLOP(ILLOP));
    
    //MEM/WB�Ĵ���
	always @(posedge sysclk)
	begin
	MEM_WB_PC_plus_4<=EX_MEM_PC_plus_4;
	MEM_WB_Read_data<=Read_data;
	MEM_WB_ALU_out<=EX_MEM_ALU_out;
	MEM_WB_mux2_out<=EX_MEM_mux2_out;
	MEM_WB_MemtoReg<=EX_MEM_MemtoReg;
    MEM_WB_RegWrite<=EX_MEM_RegWrite;
	end
//����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������	
	
	assign mux7_out = (MEM_WB_MemtoReg == 2'b00)? MEM_WB_ALU_out: (MEM_WB_MemtoReg == 2'b01)? MEM_WB_Read_data: MEM_WB_PC_plus_4;  
    Showaddr showaddr(show_data,cathodes,AN);
//������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������


endmodule
	