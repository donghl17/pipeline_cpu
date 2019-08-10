module ForwardUnit_for_load_use(
input EX_MEM_RegWrite,
input MEM_WB_RegWrite,
input [4:0] EX_MEM_Mux2_out,
input [4:0] MEM_WB_Mux2_out,
input [4:0] ID_EX_rs,
input [4:0] ID_EX_rt,
output wire [1:0] mux1_control,
output wire [1:0] mux5_control
    );
    
    assign mux5_control=(EX_MEM_RegWrite==1 && EX_MEM_Mux2_out!=0 && EX_MEM_Mux2_out==ID_EX_rs)? 2'b10:
                        (MEM_WB_RegWrite==1 &&  MEM_WB_Mux2_out==ID_EX_rs && ((EX_MEM_Mux2_out!=ID_EX_rs)||(~EX_MEM_RegWrite)) )? 2'b01:2'b00;
    assign mux1_control=(EX_MEM_RegWrite==1 && EX_MEM_Mux2_out!=0 && EX_MEM_Mux2_out==ID_EX_rt)? 2'b10:
                        (MEM_WB_RegWrite==1 &&  MEM_WB_Mux2_out==ID_EX_rt && ((EX_MEM_Mux2_out!=ID_EX_rt)||(~EX_MEM_RegWrite)) )? 2'b01:2'b00;
    
    
    
    
endmodule