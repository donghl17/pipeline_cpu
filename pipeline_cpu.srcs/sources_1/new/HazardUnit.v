
module HazardUnit(
input reset,
input ID_EX_RegWrite,
input Branch,
input and_out,
input [2:0] PCSrc,
input ID_EX_MemRead,
input [4:0] mux2_out,
input [4:0] rs,
input [4:0] rt,
output wire stall,
output reg IF_Flush
    );
    assign stall=(ID_EX_MemRead &&(mux2_out==rs || mux2_out==rt))?1:
    (ID_EX_RegWrite && Branch &&(mux2_out==rs || mux2_out==rt))?1:0;
//    assign stall=(ID_EX_MemRead==1)? ((mux2_out==rs)?1:((mux2_out==rt)?1:0)):
//    (ID_EX_RegWrite)? ((mux2_out==rs)?1:((mux2_out==rt)?1:0):0;
    
    //(ID_EX_RegWrite==1 && Branch==1)?((mux2_out==rs)?1:((mux2_out==rt)?1:0):0;
    always @(*)
    begin
    if(reset) IF_Flush<=0;
    else IF_Flush<=(and_out==0 && (PCSrc==3'b000 /*||PCSrc==3'b011||PCSrc==3'b100*/))? 0:1;
    end
    
endmodule
