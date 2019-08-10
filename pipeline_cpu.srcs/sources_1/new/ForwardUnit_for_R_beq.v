module ForwardUnit_for_R_beq(
input Branch,
input [4:0] EX_MEM_Mux2_out,
input [4:0]rt,
input [4:0]rs,
input EX_MEM_MemRead,
output wire [1:0] mux3_control,
output wire [1:0] mux4_control
    );
    
    assign mux4_control=(Branch==1 && EX_MEM_MemRead==1 && EX_MEM_Mux2_out!=0 && EX_MEM_Mux2_out==rs)? 2'b10:
                        (Branch==1 && EX_MEM_MemRead==0 &&EX_MEM_Mux2_out!=0 && EX_MEM_Mux2_out==rs)? 2'b01:2'b00;
    assign mux3_control=(Branch==1 && EX_MEM_MemRead==1 && EX_MEM_Mux2_out!=0 && EX_MEM_Mux2_out==rt)? 2'b10:
                        (Branch==1 && EX_MEM_MemRead==0 &&EX_MEM_Mux2_out!=0 && EX_MEM_Mux2_out==rt)? 2'b01:2'b00;
endmodule