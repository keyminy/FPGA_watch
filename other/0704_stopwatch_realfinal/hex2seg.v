module hex2seg(
    input [3:0] din,
    output [6:0] seg_d
    );

assign seg_d = (din == 4'h0) ? 7'h3f :
               (din == 4'h1) ? 7'h06 :
               (din == 4'h2) ? 7'h5b :
               (din == 4'h3) ? 7'h4f :
               (din == 4'h4) ? 7'h66 :
               (din == 4'h5) ? 7'h6d :
               (din == 4'h6) ? 7'h7d :
               (din == 4'h7) ? 7'h27 :
               (din == 4'h8) ? 7'h7f :
               (din == 4'h9) ? 7'h6f :
               (din == 4'ha) ? 7'h5f :
               (din == 4'hb) ? 7'h7c :
               (din == 4'hc) ? 7'h58 :
               (din == 4'hd) ? 7'h5e :
               (din == 4'he) ? 7'h7b :
                               7'h71 ;
 
endmodule
