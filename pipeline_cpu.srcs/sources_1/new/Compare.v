
module Compare(
input [31:0]Number1,
input [31:0]Number2,
output Compare_out
    );
    assign Compare_out=(Number1==Number2)? 1:0;
endmodule
