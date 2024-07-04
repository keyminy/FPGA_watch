module bin2bcd7(
input [6:0] bin,
output [3:0] ONES, TENS
);
wire [3:0] c1,c2,c3,c4;
wire [3:0] d1,d2,d3,d4;

assign d1 = {1'b0,bin[6:4]};
assign d2 = {c1[2:0],bin[3]};
assign d3 = {c2[2:0],bin[2]};
assign d4 = {c3[2:0],bin[1]};
add3 m1(d1,c1);
add3 m2(d2,c2);
add3 m3(d3,c3);
add3 m4(d4,c4);
assign ONES = {c4[2:0],bin[0]};
assign TENS = {c1[3],c2[3],c3[3],c4[3]};
endmodule

module add3(
input [3:0] in,
output reg [3:0] out
);
always @ (*)
    if(in>4) out = in + 4'b0011;
    else out = in;
endmodule
