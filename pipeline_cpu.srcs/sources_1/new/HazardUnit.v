
module HazardUnit(
input ID_EX_RegWrite,
input Branch,
input and_out,
input [1:0] PCSrc,
input ID_EX_MemRead,
input [4:0] mux2_out,
input [4:0] rs,
input [4:0] rt,
output wire stall,
output wire IF_Flush
    );
    assign stall=(ID_EX_MemRead &&(mux2_out==rs || mux2_out==rt))?1:
    (ID_EX_RegWrite && Branch &&(mux2_out==rs || mux2_out==rt))?1:0;
//    assign stall=(ID_EX_MemRead==1)? ((mux2_out==rs)?1:((mux2_out==rt)?1:0)):
//    (ID_EX_RegWrite)? ((mux2_out==rs)?1:((mux2_out==rt)?1:0):0;
    
    //(ID_EX_RegWrite==1 && Branch==1)?((mux2_out==rs)?1:((mux2_out==rt)?1:0):0;
    assign IF_Flush=(and_out==0 && PCSrc==2'b00)? 0:1;
    
endmodule
