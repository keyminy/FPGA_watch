module hex2seg_a(
    input [2:0] sel,
    input [3:0] din,
    output [7:0] seg_d
    );

wire [3:0] idin;

assign idin = din + sel;

assign seg_d = (sel  > 3)     ? 8'h49 :
               (idin == 4'h0) ? 8'h3f :
               (idin == 4'h1) ? 8'h06 :
               (idin == 4'h2) ? 8'h5b :
               (idin == 4'h3) ? 8'h4f :
               (idin == 4'h4) ? 8'h66 :
               (idin == 4'h5) ? 8'h6d :
               (idin == 4'h6) ? 8'h7d :
               (idin == 4'h7) ? 8'h27 :
               (idin == 4'h8) ? 8'h7f :
               (idin == 4'h9) ? 8'h6f :
               (idin == 4'ha) ? 8'h5f :
               (idin == 4'hb) ? 8'h7c :
               (idin == 4'hc) ? 8'h58 :
               (idin == 4'hd) ? 8'h5e :
               (idin == 4'he) ? 8'h7b :
                                8'h71 ;
 
endmodule
