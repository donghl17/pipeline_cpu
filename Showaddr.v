module Showaddr(
input [11:0]show_data,
output reg [6:0]cathodes,
output wire [3:0]AN
);
wire [6:0]led0;
wire [6:0]led1;
//wire [6:0]led2;
//wire [6:0]led3;
assign AN=show_data[11:8];
assign	led0=(show_data[3:0]==4'h0)?7'b0111111:
             (show_data[3:0]==4'h1)?7'b0000110:
             (show_data[3:0]==4'h2)?7'b1011011:
             (show_data[3:0]==4'h3)?7'b1001111:
             (show_data[3:0]==4'h4)?7'b1100110:
             (show_data[3:0]==4'h5)?7'b1101101:
             (show_data[3:0]==4'h6)?7'b1111101:
             (show_data[3:0]==4'h7)?7'b0000111:
             (show_data[3:0]==4'h8)?7'b1111111:
             (show_data[3:0]==4'h9)?7'b1101111:
             (show_data[3:0]==4'ha)?7'b1110111:
             (show_data[3:0]==4'hb)?7'b1111100:
             (show_data[3:0]==4'hc)?7'b0111001:
             (show_data[3:0]==4'hd)?7'b1011110:
             (show_data[3:0]==4'he)?7'b1111011:
             (show_data[3:0]==4'hf)?7'b1110001:7'b0;
 assign	led1=(show_data[7:4]==4'h0)?7'b0111111:
             (show_data[7:4]==4'h1)?7'b0000110:
             (show_data[7:4]==4'h2)?7'b1011011:
             (show_data[7:4]==4'h3)?7'b1001111:
             (show_data[7:4]==4'h4)?7'b1100110:
             (show_data[7:4]==4'h5)?7'b1101101:
             (show_data[7:4]==4'h6)?7'b1111101:
             (show_data[7:4]==4'h7)?7'b0000111:
             (show_data[7:4]==4'h8)?7'b1111111:
             (show_data[7:4]==4'h9)?7'b1101111:
             (show_data[7:4]==4'ha)?7'b1110111:
             (show_data[7:4]==4'hb)?7'b1111100:
             (show_data[7:4]==4'hc)?7'b0111001:
             (show_data[7:4]==4'hd)?7'b1011110:
             (show_data[7:4]==4'he)?7'b1111011:
             (show_data[7:4]==4'hf)?7'b1110001:7'b0;
 always @(*)begin
 case(show_data[11:8])
 				4'b0001: cathodes <=led0 ;	
 				4'b0010: cathodes <=led1 ;
				default: ;
 endcase
 end

endmodule